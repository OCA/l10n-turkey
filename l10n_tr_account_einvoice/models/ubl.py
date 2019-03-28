# -*- coding: utf-8 -*-

from odoo import models, api, tools, _
from odoo.exceptions import UserError
from lxml import etree
import logging
from odoo.tools.float_utils import float_is_zero, float_round

logger = logging.getLogger(__name__)


class BaseUbl(models.AbstractModel):
    _inherit = 'base.ubl'

    @api.model
    def _ubl_check_xml_schema(self, xml_string, document, version='2.1'):
        '''Validate the XML file against the XSD'''
        xsd_file = 'l10n_tr_account_einvoice/data/xsd-%s/maindoc/UBL-%s-%s.xsd' % (
            version, document, version)
        xsd_etree_obj = etree.parse(tools.file_open(xsd_file))
        official_schema = etree.XMLSchema(xsd_etree_obj)
        '''
        try:
            t = etree.parse(StringIO(xml_string))
            official_schema.assertValid(t)
        except Exception, e:
            # if the validation of the XSD fails, we arrive here
            logger = logging.getLogger(__name__)
            logger.warning(
                "The XML file is invalid against the XML Schema Definition")
            logger.warning(xml_string)
            logger.warning(e)
            raise UserError(_(
                "The UBL XML file is not valid against the official "
                "XML Schema Definition. The XML file and the "
                "full error have been written in the server logs. "
                "Here is the error, which may give you an idea on the "
                "cause of the problem : %s.")
                            % unicode(e))
        '''
        return True

    @api.model
    def _ubl_get_nsmap_namespace(self, doc_name, version='2.1'):
        nsmap = {
            None: 'urn:oasis:names:specification:ubl:schema:xsd:' + doc_name,
            'cac': 'urn:oasis:names:specification:ubl:'
                   'schema:xsd:CommonAggregateComponents-2',
            'cbc': 'urn:oasis:names:specification:ubl:schema:xsd:'
                   'CommonBasicComponents-2',
            'ext': 'urn:oasis:names:specification:ubl:schema:xsd:'
                   'CommonExtensionComponents-2',
            'ubltr': 'urn:oasis:names:specification:ubl:schema:xsd:'
                     'TurkishCustomizationExtensionComponents',
            'udt': 'urn:un:unece:uncefact:data:specification:'
                   'UnqualifiedDataTypesSchemaModule:2',
            'qdt': 'urn:oasis:names:specification:ubl:schema:xsd:'
                   'QualifiedDatatypes-2',
            'ccts': 'urn:un:unece:uncefact:'
                    'documentation:2',
        }
        ns = {
            'cac': '{urn:oasis:names:specification:ubl:schema:xsd:'
                   'CommonAggregateComponents-2}',
            'cbc': '{urn:oasis:names:specification:ubl:schema:xsd:'
                   'CommonBasicComponents-2}',
            'ext': '{urn:oasis:names:specification:ubl:schema:xsd:'
                   'CommonExtensionComponents-2}',
            'ubltr': '{urn:oasis:names:specification:ubl:schema:xsd:'
                     'TurkishCustomizationExtensionComponents}',
            'udt': '{urn:un:unece:uncefact:data:specification:'
                   'UnqualifiedDataTypesSchemaModule:2}',
            'qdt': '{urn:oasis:names:specification:ubl:schema:xsd:'
                   'QualifiedDatatypes-2}',
            'ccts': '{urn:un:unece:uncefact:'
                    'documentation:2}',
        }
        return nsmap, ns

    @api.model
    def _ubl_get_party_identification(self, commercial_partner):
        '''This method is designed to be inherited in localisation modules
        Should return a dict with key=SchemeName, value=Identifier'''
        vat_no = "'CC##' (CC=Country Code, ##=VAT Number)"
        dict = {}
        if commercial_partner.vat:
            if len(commercial_partner.vat) == 12:
                dict["VKN"] = commercial_partner.vat[2:]
            elif len(commercial_partner.vat) == 13:
                dict["TCKN"] = commercial_partner.vat[2:]
            elif len(commercial_partner.vat) == 10:
                dict["VKN"] = commercial_partner.vat
            elif len(commercial_partner.vat) == 11:
                dict["TCKN"] = commercial_partner.vat
            else:
                raise UserError(_(
                    'The VAT number [%s] for partner [%s] does not seem to be valid. \nNote: the expected format is %s') % (
                                    commercial_partner.vat, commercial_partner.name, vat_no))
        else:
            dict["TCKN"] = "11111111111"
        if commercial_partner.commercial_id:
            dict["TICARETSICILNO"] = commercial_partner.commercial_id
        if commercial_partner.mersis:
            dict["MERSISNO"] = commercial_partner.mersis
       
 
        return dict
# 
# 
# 
# 
    @api.model
    def _ubl_add_payment_terms(
            self, payment_term, parent_node, ns, version='2.1'):
        pay_term_root = etree.SubElement(
            parent_node, ns['cac'] + 'PaymentTerms')
        pay_term_note = etree.SubElement(
            pay_term_root, ns['cbc'] + 'Note')
        pay_term_note.text = payment_term.name
        pay_term_due_date = etree.SubElement(
            pay_term_root, ns['cbc'] + 'PaymentDueDate')
        pay_term_due_date.text=str(self.date_due)

    @api.model
    def _ubl_add_delivery(
            self, delivery_partner, parent_node, ns, version='2.1'):
        delivery = etree.SubElement(parent_node, ns['cac'] + 'Delivery')
        delivery_id = etree.SubElement(
                delivery, ns['cbc'] + 'ID')
        delivery_id.text="1"
        actual_delivery_date = etree.SubElement(
                delivery, ns['cbc'] + 'ActualDeliveryDate')
        actual_delivery_date.text =(self.mapped('invoice_line_ids.picking_ids') and str(self.invoice_line_ids[0].picking_ids[0].date_done)[:10]) \
            or str(self.date_invoice)[:10]
        if self.carrier_id:
            self._ubl_add_carrier(self.carrier_id.partner_id,'CarrierParty',delivery,ns,version=version)
            self._ubl_add_carrier(self.partner_shipping_id.commercial_partner_id,'DeliveryParty',delivery,ns,version=version)
            if self.incoterm_id:
                self._ubl_add_delivery_terms(self.incoterm_id, delivery, ns, version='2.1')

    @api.model
    def _ubl_add_address(
            self, partner, node_name, parent_node, ns, version='2.1'):
        address = etree.SubElement(parent_node, ns['cac'] + node_name)
        if partner.street:
            streetname = etree.SubElement(
                address, ns['cbc'] + 'StreetName')
        if partner.street:
            streetname.text  = partner.street 
        etree.SubElement(address, ns['cbc'] + 'BuildingNumber')
        city_sub_divis=etree.SubElement(address, ns['cbc'] + 'CitySubdivisionName')
        if hasattr(partner,'neighbour_id') and partner.neighbour_id:
            city_sub_divis.text = '  '+ partner.neighbour_id.name
        if partner.street2:
            streetname.text += ' ' + partner.street2
        if hasattr(partner, 'street3') and partner.street3:
            blockname = etree.SubElement(
                address, ns['cbc'] + 'BlockName')
            blockname.text = partner.street3
        if partner.city or hasattr(partner,'district_id') and partner.district_id:
            city = etree.SubElement(address, ns['cbc'] + 'CityName')
            city.text = partner.city or partner.district_id.name
        if hasattr(partner,'region_id') and partner.region_id:
            region_id = etree.SubElement(address, ns['cbc'] + 'Region')
            region_id.text=partner.region_id.name
        if hasattr(partner,'district_id') and partner.district_id:
            district = etree.SubElement(address, ns['cbc'] + 'District')
            district.text=partner.district_id.name
        if partner.zip:
            zip = etree.SubElement(address, ns['cbc'] + 'PostalZone')
            zip.text = partner.zip
        if partner.country_id:
            self._ubl_add_country(
                partner.country_id, address, ns, version=version)
        else:
            logger.warning('UBL: missing country on partner %s', partner.name)
            
    @api.model
    def _ubl_add_carrier(
            self, partner, node_name, parent_node, ns, version='2.1'):
        carrier_party=etree.SubElement(parent_node, ns['cac'] + node_name)
        if partner.website:
            partner_website=partner_website=etree.SubElement(carrier_party, ns['cbc'] + 'WebsiteURI')
            partner_website.text=partner.website
        party_identification = etree.SubElement(carrier_party, ns['cac'] + 'PartyIdentification')
        if partner.vat:
            partner_vat = etree.SubElement(party_identification, ns['cbc'] + 'ID',schemeID='VKN')
            partner_vat.text=partner.vat.replace('TR','')
        
        party_name=etree.SubElement(carrier_party, ns['cac'] + 'PartyName')
        party_name_name =etree.SubElement(party_name, ns['cbc'] + 'Name')
        party_name_name.text=partner.display_name
        self._ubl_add_address(
            partner, 'PostalAddress', carrier_party, ns, version=version)
        self._ubl_add_party_tax_scheme(
             partner, carrier_party, ns)   
        self._ubl_add_contact(partner, carrier_party, ns, version=version)

    @api.model
    def _ubl_get_tax_scheme_dict_from_partner(self, commercial_partner):
        tax_scheme_dict = {
            'id': 'VAT',
            'name': False,
            'type_code': False,
            }
        return tax_scheme_dict
            
    
    @api.model
    def _ubl_add_party_tax_scheme(
            self, commercial_partner, parent_node, ns, version='2.1'):
        if commercial_partner.vat:
            party_tax_scheme = etree.SubElement(
                parent_node, ns['cac'] + 'PartyTaxScheme')
            partney_tax_schmeme_tax_office = etree.SubElement(
                party_tax_scheme, ns['cac'] + 'TaxScheme')
            tax_office = etree.SubElement(
                partney_tax_schmeme_tax_office, ns['cbc'] + 'Name')
            tax_office.text = commercial_partner.x_vergidairesi or ""
            tax_scheme_dict = self._ubl_get_tax_scheme_dict_from_partner(
                commercial_partner)
#             self._ubl_add_tax_scheme(
#                 tax_scheme_dict, party_tax_scheme, ns, version=version)
#             
    @api.model
    def _ubl_add_tax_subtotal(
            self, taxable_amount, tax_amount, tax, currency_code,
            parent_node, ns, version='2.1'):
        prec = self.env['decimal.precision'].precision_get('Account')
        tax_subtotal = etree.SubElement(parent_node, ns['cac'] + 'TaxSubtotal')
        if not float_is_zero(taxable_amount, precision_digits=prec):
            taxable_amount_node = etree.SubElement(
                tax_subtotal, ns['cbc'] + 'TaxableAmount',
                currencyID=currency_code)
            taxable_amount_node.text = '%0.*f' % (prec, taxable_amount)
        tax_amount_node = etree.SubElement(
            tax_subtotal, ns['cbc'] + 'TaxAmount', currencyID=currency_code)
        calculationsequencenumeric = etree.SubElement(
            tax_subtotal, ns['cbc'] + 'CalculationSequenceNumeric')
        calculationsequencenumeric.text="1"
        tax_amount_node.text = '%0.*f' % (prec, tax_amount)
        if (
                tax.amount_type == 'percent' and
                not float_is_zero(tax.amount, precision_digits=prec+3)):
            percent = etree.SubElement(
                tax_subtotal, ns['cbc'] + 'Percent')
            percent.text = str(
                float_round(tax.amount, precision_digits=2))
        self._ubl_add_tax_category(tax, tax_subtotal, ns, version=version)

    @api.model
    def _ubl_add_tax_category(
            self, tax, parent_node, ns, node_name='TaxCategory',
            version='2.1'):
        tax_category = etree.SubElement(parent_node, ns['cac'] + node_name)
        tax_scheme_dict = self._ubl_get_tax_scheme_dict_from_tax(tax)
        self._ubl_add_tax_scheme(
            tax_scheme_dict, tax_category, ns, version=version)
    
    
        
    @api.model
    def _ubl_add_tax_scheme(
            self, tax_scheme_dict, parent_node, ns, version='2.1'):
        tax_scheme = etree.SubElement(parent_node, ns['cac'] + 'TaxScheme')
        tax_scheme_name = etree.SubElement(tax_scheme, ns['cbc'] + 'Name')
        tax_scheme_name.text = tax_scheme_dict['name'] or self.tax_line_ids[0].name[:3]
        tax_scheme_type_code = etree.SubElement(
            tax_scheme, ns['cbc'] + 'TaxTypeCode')
        tax_scheme_type_code.text = tax_scheme_dict['type_code'] or self.tax_line_ids[0].tax_id.unece_categ_code or '0015'
