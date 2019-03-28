# -*- coding: utf-8 -*-

from odoo import models, api, fields, _
from lxml import etree
from odoo.tools import float_is_zero, float_round
from odoo.exceptions import ValidationError, UserError


from openerp.tools.misc import find_in_path

import logging
import uuid
import zipfile
import os
import base64
import datetime
import pytz
import subprocess

import tempfile
from contextlib import closing
from apport.hookutils import attach_file

logger = logging.getLogger(__name__)


def _get_wkhtmltopdf_bin():
    wkhtmltopdf_bin = find_in_path('wkhtmltopdf')
    if wkhtmltopdf_bin is None:
        raise IOError
    return wkhtmltopdf_bin

class AccountInvoice(models.Model):
    _name = 'account.invoice'
    _inherit = ['account.invoice', 'base.ubl']

    digital_invoice_type = fields.Selection(selection=[('e_invoice', 'E-Invoice'), ('e_archive', 'E-Archive'),('ihracat','IHRACAT')],
                                            string="Digital Invoice Type")

    e_invoicetype = fields.Selection(selection=[('temel_fatura', 'Temel Fatura'), ('ticari_fatura', 'Ticari Fatura')],
                                     string="E-Invoice Type", default="temel_fatura")

    send_status = fields.Selection(
        selection=[('sent', 'Sent'), ('failed', 'Failed'),
                   ('waiting', 'Waiting'),
                   ('not_found', 'Invoice is not avaible or is not processed yet.')],
        string="Sending Status")

    invoice_unique_id = fields.Char(string="Unique Id")
    invoice_status_text = fields.Char(string="Invoice Info")
    
    # overwrite number to change to regular field from related field
    number = fields.Char('Number',related=False, readonly=True,
                         states={'draft': [('readonly', False)], 'open': [('readonly', False)],
                                 'proforma': [('readonly', False)], 'proforma2': [('readonly', False)]}, copy=False)
    einvoice_postbox_id = fields.Many2one('res.partner.einvoice.postbox', 'Receiver Postbox')
    issue_time = fields.Char('Issue Time')
    
    einvoice_xml_id = fields.Many2one('ir.attachment',string='Sent XML')
    einvoice_pdf_id = fields.Many2one('ir.attachment',string='Downloaded PDF')
    
    gtb_ref_no_date = fields.Date('GTB Refrence Date')
    gtb_ref_no = fields.Char('GTB Reference No')
    gtb_declaration_no = fields.Char('GTB Declaration No')
    gtb_intac_date = fields.Date('GTB INTAC Date')
    
    
    @api.multi
    def send(self, invoice):
        ''' Send e-invoice ubl to provider. Intended to be implemented by inheriting module
        '''
        if self.company_id.einvoice_provider_id:
            self.company_id.einvoice_provider_id.send(self)
        else:
            pass
    
    @api.multi
    def generate_ubl_xml_string(self, version='2.1'):
        self.ensure_one()
        # assert self.state in ('open', 'paid')
        assert self.type in ('out_invoice', 'in_refund')
        logger.debug('Starting to generate UBL XML Invoice file')
        lang = self.get_ubl_lang()
        # The aim of injecting lang in context
        # is to have the content of the XML in the partner's lang
        # but the problem is that the error messages will also be in
        # that lang. But the error messages should almost never
        # happen except the first days of use, so it's probably
        # not worth the additional code to handle the 2 langs
        xml_root = self.with_context(lang=lang). \
            generate_invoice_ubl_xml_etree(version=version)
        xml_string = etree.tostring(
            xml_root, pretty_print=True, encoding='UTF-8',
            xml_declaration=True)
        self._ubl_check_xml_schema(xml_string, 'Invoice', version=version)
        logger.debug(
            'Invoice UBL XML file generated for account invoice ID %d '
            '(state %s)', self.id, self.state)
        logger.debug(xml_string.decode('utf-8'))
        return xml_string

    @api.multi
    def generate_invoice_ubl_xml_etree(self, version='2.1'):
        nsmap, ns = self._ubl_get_nsmap_namespace('Invoice-2', version=version)
        xml_root = etree.Element('Invoice', nsmap=nsmap)
        self._ubl_add_header(xml_root, ns, version=version)
        # self._ubl_add_order_reference(xml_root, ns, version=version)
        self._ubl_add_contract_document_reference(
            xml_root, ns, version=version)
        self._ubl_add_attachments(xml_root, ns, version=version)
        self._ubl_add_supplier_party(
            False, self.company_id, 'AccountingSupplierParty', xml_root, ns,
            version=version)
        self._ubl_add_customer_party(
            self.partner_id, False, 'AccountingCustomerParty', xml_root, ns,
            version=version)
#         delivery_partner = self.get_delivery_partner()
        self._ubl_add_delivery(self.partner_shipping_id, xml_root, ns)
        # Put paymentmeans block even when invoice is paid ?
#         self._ubl_add_payment_means(
#             self.partner_bank_id, self.payment_mode_id, self.date_due,
#             xml_root, ns, version=version)
        if self.payment_term_id:
            self._ubl_add_payment_terms(
                self.payment_term_id, xml_root, ns, version=version)
        self._ubl_add_tax_total(xml_root, ns, version=version)
        self._ubl_add_legal_monetary_total(xml_root, ns, version=version)

        line_number = 0
        for iline in self.invoice_line_ids:
            line_number += 1
            self._ubl_add_invoice_line(
                xml_root, iline, line_number, ns, version=version)
        return xml_root

    @api.multi
    def _ubl_add_sending_type(self, parent_node, ns):
        return {}
#         additional_reference = etree.SubElement(
#             parent_node, ns['cac'] + 'AdditionalDocumentReference')
#         id = etree.SubElement(
#             additional_reference, ns['cbc'] + 'ID')
#         id.text = '0'
#         issue_date = etree.SubElement(additional_reference, ns['cbc'] + 'IssueDate')
#         issue_date.text = str(self.date_invoice)
#         document_type_code = etree.SubElement(additional_reference, ns['cbc'] + 'DocumentTypeCode')
#         document_type_code.text = "SendingType"
#         document_type = etree.SubElement(additional_reference, ns['cbc'] + 'DocumentType')
#         document_type.text = "ELEKTRONIK"

#     @api.multi
#     def _ubl_add_ecommerce_data(self, parent_node, ns):
#  
        # Web Address
#         web_address = etree.SubElement(
#             parent_node, ns['cac'] + 'AdditionalDocumentReference')
#         id = etree.SubElement(
#             web_address, ns['cbc'] + 'ID')
#         id.text = "internetSatisBilgi/webAdresi"
#  
#         currentdate = datetime.datetime.now(pytz.timezone('Europe/Istanbul'))
#         currentdate = currentdate.strftime('%Y-%m-%d')
#  
#         issue_date = etree.SubElement(web_address, ns['cbc'] + 'IssueDate')
#         issue_date.text = str(currentdate)
#         document_type = etree.SubElement(web_address, ns['cbc'] + 'DocumentType')
#         url = ""
#         if self.company_id:
#             if self.company_id.website:
#                 url = self.company_id.website
#  
#         document_type.text = url
 
        # EInvoice  Condition
#         e_invoice = etree.SubElement(
#             parent_node, ns['cac'] + 'AdditionalDocumentReference')
#         id = etree.SubElement(
#             e_invoice, ns['cbc'] + 'ID')
#         id.text = "EINVOICE"
 
#         currentdate = datetime.datetime.now(pytz.timezone('Europe/Istanbul'))
#         currentdate = currentdate.strftime('%Y-%m-%d')
#  
#         issue_date = etree.SubElement(e_invoice, ns['cbc'] + 'IssueDate')
#         issue_date.text = str(currentdate)
#         document_type = etree.SubElement(e_invoice, ns['cbc'] + 'DocumentType')
#         document_type.text = "3"
 
        # Payment Type
#         payment_type = etree.SubElement(
#             parent_node, ns['cac'] + 'AdditionalDocumentReference')
#         id = etree.SubElement(
#             payment_type, ns['cbc'] + 'ID')
#         id.text = "internetSatisBilgi/odemeSekli"
#  
#         issue_date = etree.SubElement(payment_type, ns['cbc'] + 'IssueDate')
#         issue_date.text = str(currentdate)
#  
#         document_type = etree.SubElement(payment_type, ns['cbc'] + 'DocumentType')
#         document_type.text = "KREDIKARTI/BANKAKARTI"
 
        # Payment Date
#         payment_date = etree.SubElement(
#             parent_node, ns['cac'] + 'AdditionalDocumentReference')
#         id = etree.SubElement(
#             payment_date, ns['cbc'] + 'ID')
#         id.text = "internetSatisBilgi/odemeTarihi"
 
#         issue_date = etree.SubElement(payment_date, ns['cbc'] + 'IssueDate')
#         issue_date.text = str(currentdate)
#  
#         document_type = etree.SubElement(payment_date, ns['cbc'] + 'DocumentType')
 
#         date_paid = self.date_invoice
#         # TODO: must acquire from account.payment instead of payment.transaction
#         if "payment.transaction" in self.env:
#             if "invoice_id" in self.env["payment.transaction"]:
#                 for invoice in self:
#                     tx = self.env["payment.transaction"].search([('invoice_id', '=', invoice.id)], limit=1)
#                     if tx.state == 'done' and invoice.amount_total == tx.amount:
#                         current_date = datetime.datetime.strptime(tx.create_date, "%Y-%m-%d %H:%M:%S")
#                         stripped_date = current_date.strftime("%Y-%m-%d")
#                         date_paid = stripped_date
#  
#         document_type.text = str(date_paid)
 
        # Delivery Date
#         delivery_date = etree.SubElement(
#             parent_node, ns['cac'] + 'AdditionalDocumentReference')
#         id = etree.SubElement(
#             delivery_date, ns['cbc'] + 'ID')
#         id.text = "internetSatisBilgi/gonderiBilgileri/gonderimTarihi"
 
#         issue_date = etree.SubElement(delivery_date, ns['cbc'] + 'IssueDate')
#         issue_date.text = str(currentdate)
#  
#         document_type = etree.SubElement(delivery_date, ns['cbc'] + 'DocumentType')
#         document_type.text = str(self.date_invoice)
 
        # Carrier Info
#         carrier_info = etree.SubElement(
#             parent_node, ns['cac'] + 'AdditionalDocumentReference')
#         id = etree.SubElement(
#             carrier_info, ns['cbc'] + 'ID')
#         id.text = "internetSatisBilgi/gonderiBilgileri/gonderiTasiyan/tuzelKisi/vkn"
#  
#         issue_date = etree.SubElement(carrier_info, ns['cbc'] + 'IssueDate')
#         issue_date.text = str(currentdate)
#  
#         document_type = etree.SubElement(carrier_info, ns['cbc'] + 'DocumentType')
#         document_type.text = "9860008925"
 
#         # Carrier Info
#         deliver_carrier = etree.SubElement(
#             parent_node, ns['cac'] + 'AdditionalDocumentReference')
#         id = etree.SubElement(
#             deliver_carrier, ns['cbc'] + 'ID')
#         id.text = "internetSatisBilgi/gonderiBilgileri/gonderiTasiyan/tuzelKisi/unvan"
#  
#         issue_date = etree.SubElement(deliver_carrier, ns['cbc'] + 'IssueDate')
#         issue_date.text = str(currentdate)
#  


    @api.multi
    def _ubl_add_header(self, parent_node, ns, version='2.1'):
        ubl_version = etree.SubElement(
            parent_node, ns['cbc'] + 'UBLVersionID')
        ubl_version.text = version
        customization_id = etree.SubElement(parent_node, ns['cbc'] + 'CustomizationID')
        customization_id.text = "TR1.2"
        profile_id = etree.SubElement(parent_node, ns['cbc'] + 'ProfileID')
        if self.digital_invoice_type == 'e_invoice':
            profile_id.text = "TICARIFATURA"
        else:
            profile_id.text = "EARSIVFATURA"
        doc_id = etree.SubElement(parent_node, ns['cbc'] + 'ID')
        doc_id.text = self.number
        copy_indicator = etree.SubElement(parent_node, ns['cbc'] + 'CopyIndicator')
        copy_indicator.text = "false"
        docuid = etree.SubElement(parent_node, ns['cbc'] + 'UUID')
        docuid.text = str(self.invoice_unique_id)
        issue_date = etree.SubElement(parent_node, ns['cbc'] + 'IssueDate')
        issue_date.text = str(self.date_invoice)
        
        issue_time = etree.SubElement(parent_node, ns['cbc'] + 'IssueTime')
        issue_time.text = self.issue_time
        
        type_code = etree.SubElement(parent_node, ns['cbc'] + 'InvoiceTypeCode')
        if self.type == 'in_refund':
            type_code.text = "IADE"
        else:
            type_code.text = "SATIS"
        total_in_count =etree.SubElement(parent_node, ns['cbc'] + 'Note')
        total_in_count.text = 'YALNIZ ' + (self.invoice_amount_in_words)
        total_balance =etree.SubElement(parent_node, ns['cbc'] + 'Note')
        balance ="Borç"
        if self.total_balance >0:
            balance="Borç"
        else:
            balance ="Alacak"
        total_balance.text= 'Bu fatura dahil hesap bakiyeniz: ' + str(self.total_balance) + ' ' + balance
        if self.comment:
            note = etree.SubElement(parent_node, ns['cbc'] + 'Note')
            note.text = self.comment
        doc_currency = etree.SubElement(
            parent_node, ns['cbc'] + 'DocumentCurrencyCode')
        doc_currency.text = self.currency_id.name
        
        linecountnumeric = etree.SubElement(parent_node, ns['cbc'] + 'LineCountNumeric')
        linecountnumeric.text = str(len(self.invoice_line_ids))
        self._add_sales_order_info(parent_node, ns)

        if self.digital_invoice_type == 'e_archive':
            self._ubl_add_sending_type(parent_node, ns)
            #self._ubl_add_ecommerce_data(parent_node, ns)
            self._add_template_data(parent_node, ns, 'einvoice')


        if self.digital_invoice_type == 'e_invoice':
            self._add_template_data(parent_node, ns, 'einvoice')
            
    

    
    @api.multi
    def _add_sales_order_info(self, parent_node, ns):

        if self.origin:
            sale_order = self.env["sale.order"].search([('name', '=', self.origin)], limit=1)

            if len(sale_order) > 0:
                order_date = sale_order.confirmation_date
                order_name = sale_order.name

                order_date_converted = datetime.datetime.strptime(str(order_date), "%Y-%m-%d %H:%M:%S")
                stripped_date = order_date_converted.strftime("%Y-%m-%d")

                order_node = etree.SubElement(parent_node, ns['cac'] + 'OrderReference')

                order_id_node = etree.SubElement(order_node, ns['cbc'] + 'ID')
                order_id_node.text = str(order_name)
                order_id_node = etree.SubElement(order_node, ns['cbc'] + 'SalesOrderID')
                order_id_node.text = str(order_name)
                order_date_node = etree.SubElement(order_node, ns['cbc'] + 'IssueDate')
                order_date_node.text = str(stripped_date)

    @api.multi
    def _add_template_data(self, parent_node, ns, template_name):
 
        path = os.path.dirname(os.path.realpath(__file__)).replace('models', 'data')
 
        xslt_file = os.path.join(path, template_name + ".xslt")
        only_xslt = os.path.join(template_name, ".xslt").replace('/','')
 
        if os.path.isfile(xslt_file):
            with open(xslt_file, "rb") as f:
                base64data = base64.b64encode(f.read())
 
                additional_reference = etree.SubElement(
                    parent_node, ns['cac'] + 'AdditionalDocumentReference')
                id = etree.SubElement(
                    additional_reference, ns['cbc'] + 'ID')
                id.text = self.number
                issue_date = etree.SubElement(additional_reference, ns['cbc'] + 'IssueDate')
                issue_date.text = str(self.date_invoice) or str(datetime.datetime.today())[:10]
                document_type = etree.SubElement(additional_reference, ns['cbc'] + 'DocumentType')
                document_type.text = "XSLT"
                attachment = etree.SubElement(additional_reference, ns['cac'] + 'Attachment')
 
                embedded_binary_object = etree.SubElement(attachment, ns['cbc'] + 'EmbeddedDocumentBinaryObject',
                                                          characterSetCode="UTF-8", encodingCode="Base64",
                                                          mimeCode="application/xml", filename=only_xslt)
                embedded_binary_object.text = base64data
        else:
            raise ValidationError(_("Requested Invoice template is not available."))
    
    
    @api.multi
    def _ubl_add_legal_monetary_total(self, parent_node, ns, version='2.1'):
        monetary_total = etree.SubElement(
            parent_node, ns['cac'] + 'LegalMonetaryTotal')
        cur_name = self.currency_id.name
        prec = self.currency_id.decimal_places
        line_total = etree.SubElement(
            monetary_total, ns['cbc'] + 'LineExtensionAmount',
            currencyID=cur_name)
        line_total.text = '%0.*f' % (prec, self.amount_untaxed)
        tax_excl_total = etree.SubElement(
            monetary_total, ns['cbc'] + 'TaxExclusiveAmount',
            currencyID=cur_name)
        tax_excl_total.text = '%0.*f' % (prec, self.amount_untaxed)
        tax_incl_total = etree.SubElement(
            monetary_total, ns['cbc'] + 'TaxInclusiveAmount',
            currencyID=cur_name)
        tax_incl_total.text = '%0.*f' % (prec, self.amount_total)
        # calculate discount
        discount_total = 0
        charge_total_amount=0
        for line in self.invoice_line_ids:
            if line.discount > 0:
                discount_total += line.price_unit * (line.discount / 100) * line.quantity
            if line.discount < 0:
                charge_total_amount += abs(line.price_unit * line.quantity * (line.discount / 100))
        tax_allowance_total = etree.SubElement(
            monetary_total, ns['cbc'] + 'AllowanceTotalAmount',
            currencyID=cur_name)
        tax_allowance_total.text = str(discount_total)
        charge_allowed_total = etree.SubElement(
            monetary_total, ns['cbc'] + 'ChargeTotalAmount',
            currencyID=cur_name)
        charge_allowed_total.text = str(charge_total_amount)
        payable_amount = etree.SubElement(
            monetary_total, ns['cbc'] + 'PayableAmount',
            currencyID=cur_name)
        payable_amount.text = '%0.*f' % (prec, self.amount_total)

    def _ubl_add_invoice_line_tax_total(self, iline, parent_node, ns, version='2.1'):
        cur_name = self.currency_id.name
        prec = self.currency_id.decimal_places
        tax_total_node = etree.SubElement(parent_node, ns['cac'] + 'TaxTotal')
        price = iline.price_unit * (1 - (iline.discount or 0.0) / 100.0)
        res_taxes = iline.invoice_line_tax_ids.compute_all(
            price, quantity=iline.quantity, product=iline.product_id,
            partner=self.partner_id)
        tax_total = float_round(
            res_taxes['total_included'] - res_taxes['total_excluded'],
            precision_digits=prec)
        tax_amount_node = etree.SubElement(
            tax_total_node, ns['cbc'] + 'TaxAmount', currencyID=cur_name)
        tax_amount_node.text = '%0.*f' % (prec, tax_total)
        if not float_is_zero(tax_total, precision_digits=prec):
            for res_tax in res_taxes['taxes']:
                tax = self.env['account.tax'].browse(res_tax['id'])
                # we don't have the base amount in res_tax :-(
                self._ubl_add_tax_subtotal(
                    False, res_tax['amount'], tax, cur_name, tax_total_node,
                    ns, version=version)
        else:
            tax_sub_total_node = etree.SubElement(tax_total_node, ns['cac'] + 'TaxSubtotal')
            taxablemount_node = etree.SubElement(tax_sub_total_node, ns['cbc'] + 'TaxableAmount', currencyID=cur_name)
            taxablemount_node.text = "0"
            taxamount_node = etree.SubElement(tax_sub_total_node, ns['cbc'] + 'TaxAmount', currencyID=cur_name)
            taxamount_node.text = "0"
            percent_node = etree.SubElement(tax_sub_total_node, ns['cbc'] + 'Percent')
            percent_node.text = "0"
            tax_category = etree.SubElement(tax_sub_total_node, ns['cac'] + 'TaxCategory')
            tax_scheme = etree.SubElement(tax_category, ns['cac'] + 'TaxScheme')
            tax_scheme_name = etree.SubElement(tax_scheme, ns['cbc'] + 'Name')
            tax_scheme_name.text = "KDV GERCEK"
            tax_scheme_taxtypecode = etree.SubElement(tax_scheme, ns['cbc'] + 'TaxTypeCode')
            tax_scheme_taxtypecode.text = "0015"

    @api.multi
    def _ubl_add_invoice_line(self, parent_node, iline, line_number, ns, version='2.1'):
        cur_name = self.currency_id.name
        line_root = etree.SubElement(
            parent_node, ns['cac'] + 'InvoiceLine')
        dpo = self.env['decimal.precision']
        qty_precision = dpo.precision_get('Product Unit of Measure')
        price_precision = dpo.precision_get('Product Price')
        account_precision = self.currency_id.decimal_places
        line_id = etree.SubElement(line_root, ns['cbc'] + 'ID')
        line_id.text = str(line_number)
        line_note =etree.SubElement(line_root, ns['cbc'] + 'Note')
        line_note.text=iline.name or "/"
        
        uom_unece_code = False
        # uom_id is not a required field on account.invoice.line
        if iline.uom_id and iline.uom_id.unece_code:
            uom_unece_code = iline.uom_id.unece_code
        if uom_unece_code:
            quantity = etree.SubElement(
                line_root, ns['cbc'] + 'InvoicedQuantity',
                unitCode=uom_unece_code)
        else:
            quantity = etree.SubElement(
                line_root, ns['cbc'] + 'InvoicedQuantity')
        qty = iline.quantity
        quantity.text = '%0.*f' % (qty_precision, qty)
        line_amount = etree.SubElement(
            line_root, ns['cbc'] + 'LineExtensionAmount',
            currencyID=cur_name)
        line_amount.text = '%0.*f' % (account_precision, iline.price_subtotal)
        self._ubl_add_invoice_line_tax_total(
            iline, line_root, ns, version=version)
        self._ubl_add_item(
            iline.name, iline.product_id, line_root, ns, type='sale',
            version=version)
        price_node = etree.SubElement(line_root, ns['cac'] + 'Price')
        price_amount = etree.SubElement(
            price_node, ns['cbc'] + 'PriceAmount', currencyID=cur_name)
        price_unit = 0.0
        # Use price_subtotal/qty to compute price_unit to be sure
        # to get a *tax_excluded* price unit
        if not float_is_zero(qty, precision_digits=qty_precision):
            price_unit = float_round(
                iline.price_subtotal / float(qty),
                precision_digits=price_precision)
        price_amount.text = '%0.*f' % (price_precision, price_unit)

   
   

    @api.multi
    def update_status(self):
        # Check Status
        for invoice in self:
            if not invoice.digital_invoice_type:
                raise ValidationError(_("Unknown invoice type."))
            else:
                sent, status = invoice.company_id.einvoice_provider_id.get_state(invoice)
                invoice.write({'send_status':sent, 'invoice_status_text':status})
                

    @api.multi
    def get_document_data(self):
        self.ensure_one()

        if not self.digital_invoice_type:
            raise ValidationError(_("Invoice type unknown. Failed to retrieve document."))

        if self.digital_invoice_type in ['e_invoice', 'e_archive']:

            if not self.einvoice_pdf_id:
                inv_pdf = self.env['ir.attachment'].sudo().search([('invoice_id','=',self.id)], limit=1)
                if len(inv_pdf) > 0:
                    self.einvoice_pdf_id = inv_pdf
                else:
                    self.einvoice_pdf_id = self.company_id.einvoice_provider_id.get_pdf(self)
            
            
            return {
                'type': 'ir.actions.act_url',
                'url': '/web/binary/show_document?id=%s' % (self.einvoice_pdf_id.id),
                'target': '_blank',
            }
            
    
    
    @api.multi
    def action_invoice_open(self):
        # Send E-Invoice or E-Archive    
        self.write({'issue_time':(datetime.datetime.now() + datetime.timedelta(hours=3)).strftime('%H:%M:%S')})
        for invoice in self.sorted(key='date_invoice'): 
            if not invoice.company_id.einvoice_registered or (invoice.type != "out_invoice" and invoice.type != "in_refund"):
                continue
            provider_id = invoice.company_id.einvoice_provider_id
            
            # check if partner is einvoice registered
            partner_id = invoice.partner_id
            if partner_id.vat:
                if not invoice.digital_invoice_type:
                    vat_country, vat_number = partner_id._split_vat(partner_id.vat)
        
                    try:
                        int(vat_country)
                    except ValueError:
                        pass
                    else:
                        vat_number = str(vat_country) + str(vat_number)
                       
                    registered_vat,postboxes = provider_id.get_registered_user(vat_number)
                    if registered_vat:
                        #TODO: get postboxes and set 
                        partner_id.einvoice_registered = 'yes'
                        add_postboxes = [(0, 0, {'partner_id':partner_id.id,
                                                 'name':pb['alias']}) for pb in postboxes \
                        
                            if pb['alias'] not in partner_id.einvoice_postbox_ids.mapped('name') ]
                        partner_id.einvoice_postbox_ids = add_postboxes 
                        
                        
                        if not partner_id.default_einvoice_postbox_id.id:
                            default_pb = partner_id.einvoice_postbox_ids.filtered(lambda pb: 'default' in pb.name)
                            
                            if len(default_pb) > 0:
                                default_pb = default_pb[0]
                            elif len(partner_id.einvoice_postbox_ids) > 0:
                                default_pb = partner_id.einvoice_postbox_ids[0]
                            
                            partner_id.default_einvoice_postbox_id = default_pb 
                            
                        vals = {'digital_invoice_type': 'e_invoice'}
                        if not invoice.einvoice_postbox_id:
                            vals.update({'einvoice_postbox_id':partner_id.default_einvoice_postbox_id.id})
                        invoice.write(vals)
    
                    else:
                        invoice.write({'digital_invoice_type': 'e_archive'})
    
            else:
                invoice.write({'digital_invoice_type': 'e_archive'})
            
            
            #if not  invoice.number:
            sequence = invoice.journal_id.sequence_id
            if invoice.digital_invoice_type == 'e_invoice':
                sequence = self.env['ir.sequence'].search([('code', '=', 'account.einvoice')],limit=1)
                         
            elif invoice.digital_invoice_type == 'e_archive':
                sequence = self.env['ir.sequence'].search([('code', '=', 'account.earchive')],limit=1)
                
            if not invoice.number:
                invoice.number = sequence.next_by_id()
            xslt= bytes(bytearray(u'{}'.format(self.get_einvoice_xsl()), encoding='utf-8')) 
            #provider_res = invoice.company_id.einvoice_provider_id.send(invoice)
            #if provider_res:
            base64data = base64.b64encode(invoice.generate_ubl_xml_string(version=invoice.get_ubl_version()))
            attachmentdata = {
                "name": invoice.invoice_unique_id + ".xml",
                "datas": base64data,
                "datas_fname": invoice.invoice_unique_id + ".xml",
                "res_model": "account.invoice",
                "res_id": invoice.id,
                "type": "binary",
                "mimetype": "application/xml"
            }
#   
            invoice.einvoice_xml_id = self.env['ir.attachment'].create(attachmentdata)
#             else:
#                 raise ValidationError('Fatura gönderimi başarısız!')

            
        res = super(AccountInvoice, self).action_invoice_open()

        for invoice in self.filtered(lambda i: not i.number and i.move_id):
            invoice.number = invoice.move_id.name
        

        if "payment.transaction" in self.env:
            if "invoice_id" in self.env["payment.transaction"]:
                for invoice in self:
                    tx = self.env["payment.transaction"].search([('invoice_id', '=', invoice.id)], limit=1)
                    if tx.state == 'done' and invoice.amount_total == tx.amount:
                        if tx.acquirer_id.journal_id:
                            invoice.with_context(tx_currency_id=tx.currency_id.id).pay_and_reconcile(
                                tx.acquirer_id.journal_id, pay_amount=invoice.amount_total)

        return res
    
    @api.model
    def get_einvoice_xsl(self):
        xsl_filepath = os.path.join(os.path.dirname(__file__), '../data/einvoice.xslt')
        xsl_file = open(xsl_filepath)
        xsl = xsl_file.read()
        xsl_file.close()
        return xsl
    
    @api.multi
    def einvoice_generate_einvoice_pdf_from_xslt(self, invoice, einvoice, xslt):
        transform = etree.XSLT(etree.XML(xslt))
        template = transform(einvoice)
        pdfreport_fd, pdfreport_path = tempfile.mkstemp(suffix='.pdf', prefix='einvoice.tmp.')
        content_file_fd, content_file_path = tempfile.mkstemp(suffix='.html', prefix='einvoice.tmp.')
        file_to_del = [pdfreport_path]
        file_to_del.append(content_file_path)
        with closing(os.fdopen(content_file_fd, 'w')) as content_file:
            content_file.write(str(template))
        try:
            command_args = ['--footer-font-size','8','--footer-font-name','"Arial"','--footer-center','Sayfa [page]/[toPage]','--margin-left','3','--margin-right','2']
            command_args.extend(['--quiet'])
            wkhtmltopdf = [_get_wkhtmltopdf_bin()] + command_args
            wkhtmltopdf += [content_file_path] + [pdfreport_path]

            process = subprocess.Popen(wkhtmltopdf, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            out, err = process.communicate()

            if process.returncode not in [0, 1]:
                raise UserError(_('Wkhtmltopdf failed (error code: %s). '
                                       'Message: %s') % (str(process.returncode), err))

            with closing(os.fdopen(pdfreport_fd, 'rb')) as pdfreport:
                pdf = base64.b64encode(pdfreport.read())

            invoice.einvoice_attach_file(pdf, 'pdf')

            for f_to_del in file_to_del:
                try:
                    os.unlink(f_to_del)
                except OSError :
                    _logger.error('cannot remove file %s: %s', f_to_del, OSError)
        except:
            raise

    @api.model
    def create(self, vals):
        vals.update({'invoice_unique_id': str(uuid.uuid4())})
        return super(AccountInvoice, self).create(vals)

    @api.multi
    def copy(self, default=None):

        default.update({'digital_invoice_type': None, 'invoice_status_text': None, 'send_status': None})

        return super(AccountInvoice, self).copy(default=default)

    @api.multi
    def action_cancel(self):

        # Cancel process on eLogo
        for invoice in self:
            if invoice.digital_invoice_type == 'e_archive':
                invoice.company_id.einvoice_provider_id.cancel(invoice)
            else:
                #TDE FIX ONUR
                continue
                raise ValidationError("E-Invoice cannot be cancelled.")

        return super(AccountInvoice, self).action_cancel()
    
    
    @api.multi
    def generate_einvoice_pdf(self):
        self.ensure_one()
        nsmap, ns = self._ubl_get_nsmap_namespace('Invoice-2', version=self.get_ubl_version())
        
        einvoice = etree.fromstring(base64.b64decode(self.einvoice_xml_id.datas))
        namespaces = {'cac':nsmap['cac'],'cbc':nsmap['cbc']}
        xsl_ref = einvoice.xpath("//cac:AdditionalDocumentReference[cbc:DocumentType='XSLT']", 
                       namespaces=namespaces)
        
        xsl = None
        
        if len(xsl_ref) > 0:
            xsl = base64.b64decode(xsl_ref[0].xpath("//cbc:EmbeddedDocumentBinaryObject",namespaces=namespaces)[0].text)
        else:
            path = os.path.dirname(os.path.realpath(__file__)).replace('models', 'data')
            template_name =  'einvoice'
            xslt_file = os.path.join(path, template_name + ".xslt")
            if os.path.isfile(xslt_file):
                with open(xslt_file, "rb") as f:
                    xsl = f.read()
                    
        if not xsl:
            raise ValidationError('XLST bulunamadı')
            
        transform = etree.XSLT(etree.fromstring(xsl))
        template = transform(einvoice)
        pdfreport_fd, pdfreport_path = tempfile.mkstemp(suffix='.pdf', prefix='einvoice.tmp.')
        content_file_fd, content_file_path = tempfile.mkstemp(suffix='.html', prefix='einvoice.tmp.')
        file_to_del = [pdfreport_path]
        file_to_del.append(content_file_path)
        with closing(os.fdopen(content_file_fd, 'w')) as content_file:
            content_file.write(str(template))
        try:
            command_args = ['--footer-font-size','8','--footer-font-name','"Arial"','--footer-center','Sayfa [page]/[toPage]','--margin-left','3','--margin-right','2']
            command_args.extend(['--quiet'])
            wkhtmltopdf = [_get_wkhtmltopdf_bin()] + command_args
            wkhtmltopdf += [content_file_path] + [pdfreport_path]
     
            process = subprocess.Popen(wkhtmltopdf, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            out, err = process.communicate()
            if process.returncode not in [0, 1]:
                raise UserError(_('Wkhtmltopdf failed (error code: %s). '
                                       'Message: %s') % (str(process.returncode), err))
     
            with closing(os.fdopen(pdfreport_fd, 'rb')) as pdfreport:
                pdf = base64.b64encode(pdfreport.read())
     
            for f_to_del in file_to_del:
                try:
                    os.unlink(f_to_del)
                except (OSError, IOError) as exc:
                    pass
            return pdf
        except:
            raise
    
    @api.multi
    def invoice_print(self):
        """ Print the invoice and mark it as sent, so that we can see more
            easily the next step of the workflow
        """
        self.ensure_one()
        self.sent = True
        bytedata=False
        self.einvoice_pdf_id.unlink()
        if not self.einvoice_pdf_id.id:
            bytedata=self.generate_einvoice_pdf()
        
        self.einvoice_pdf_id=self.env['ir.attachment'].create({
                'name':str(self.number) + '.pdf','type':'binary','datas_fname':str(self.number),
                'datas':bytedata})   
        return self.env['ir.actions.report'].search([('report_name','=','/report/einvoicepdf')])
    
#     @api.multi
#     def invoice_print(self):
#         """ Print the invoice and mark it as sent, so that we can see more
#             easily the next step of the workflow
#         """
#         self.ensure_one()
#         if self.digital_invoice_type:
#             return {
#                 'type': 'ir.actions.act_url',
#                 'url': '/web/show_invoice_pdf/%s' % self.id,
#                 'target': 'current',
#             }
#         else:
#             return super(AccountInvoice, self).invoice_print()
#         
