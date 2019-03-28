# -*- coding: utf-8 -*-
##############################################################################
#
#    Copyright (C) 2015, Eska Yazılım ve Danışmanlık A.Ş.
#    http://www.eskayazilim.com.tr
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as
#    published by the Free Software Foundation, either version 3 of the
#    License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
##############################################################################


import base64
import zipfile
import io
import logging

try:
    from suds import WebFault
    from suds.client import Client
    from suds.transport import TransportError
    from suds.transport.http import HttpAuthenticated
except ImportError:
    raise ImportError('Install suds library!')

from odoo import models, fields, api, _
from odoo.exceptions import UserError, Warning
from datetime import datetime,timedelta,date

_logger = logging.getLogger(__name__)


class AccountEinvoiceProvider(models.Model):
    _inherit = 'account.einvoice.provider'

    isis_username = fields.Char(string='Username')
    isis_password = fields.Char(string='Password')
    isis_customer_number = fields.Char(string='Customer Number')

    type = fields.Selection(selection_add=[('isis', 'İSİS Bilişim')])

    

    
    @api.multi
    def isis_get_client(self, webservice_type='other'):
        if not self.company_id.partner_id.vat:
            raise UserError(_('Please set company vat number!'))
        username = self.company_id.partner_id.vat[2:] + '|' + self.isis_customer_number + '|' + self.isis_username
        t = HttpAuthenticated(username=username, password=self.isis_password)
        if webservice_type == 'users':
            if self.environment == 'test':
                ws = 'http://musteritestws.isisbilisim.com.tr/services/TaxPayerQuery.svc?singleWsdl'
            else:
                ws = 'http://musteriws.isisbilisim.com.tr/services/TaxPayerQuery.svc?singleWsdl'
        else:
            if self.environment == 'test':
                ws = 'http://erptestep.isisbilisim.com.tr/EInvoiceEasy.svc?singleWsdl'
            else:
                ws = 'http://erpep.isisbilisim.com.tr/EInvoiceEasy.svc?singleWsdl'
        return Client(ws, transport=t)

    @api.multi
    def isis_check_error(self, result):
        if result.Status == 'ERROR':
            messages = result.GIBMessage.splitlines()
            _logger.error("Error Message: %s" % result.GIBMessage)
            current_lang = self.env.context.get('lang') or self.user.lang
            lang = 'TR' if current_lang == 'tr_TR' else 'EN'
            filtered = filter(lambda x: x[:6] == 'E:['+ lang +']', messages)
            message = ''
            for fm in filtered:
                message += (fm[6:] + '\n\n')
            raise UserError(_('E-Invoice Provider Error!') + '\n\n' + message)

    @api.multi
    def send(self, invoice):
        if self.type != 'isis':
            return super(AccountEinvoiceProvider, self).send(invoice)
        else:
            data = invoice.generate_ubl_xml_string()
            _logger.debug("Sending Invoice: %s" % data.decode('utf-8'))
            output = io.BytesIO()
            xml_file = zipfile.ZipFile(output, "w")
            xml_file.writestr('%s.xml' % invoice.invoice_unique_id, data)
            xml_file.close()
            bytedata = base64.b64encode(output.getvalue())
            try:
                client = self.isis_get_client()
                
                alias = (invoice.digital_invoice_type == 'e_archive' and 'e_archive' ) or \
                        (invoice.digital_invoice_type == 'IHRACAT' and 'urn:mail:ihracatpk@gtb.gov.tr')  or \
                        invoice.einvoice_postbox_id.name
                
                result = client.service.SendInvoice(self.company_id.partner_id.vat[2:],
                                                    self.company_id.einvoice_sender_email,
                                                    alias,
                                                    bytedata.decode('utf-8'))
                if result.Status == 'OK':
                    invoice.action_einvoice_waiting(_('E-Invoice sent'))
                else:
                    self.isis_check_error(result)
            except WebFault as e:
                raise UserError(_('E-Invoice Provider WebService Error!') + '\n\n' + str(e))
            return True


    @api.multi
    def einvoice_get_status(self, invoice):
        if self.type != 'isis':
            return super(AccountEinvoiceProvider, self).get_einvoice_status(invoice)
        else:
            try:
                client = self.isis_get_client()
                if invoice.type in ('out_refund', 'in_invoice'):
                    direction = 'INBOUND'
                else:
                    direction = 'OUTBOUND'
                result = client.service.GetStatus(self.company_id.partner_id.vat[2:],
                                                  direction,
                                                  invoice.invoice_unique_id)
                if result.Status == 'OK':
                    invoice.action_einvoice_completed()
                elif result.Status == 'ACCEPTED':
                    invoice.action_einvoice_accepted()
                    if invoice.einvoice_profile == 'IHRACAT':
                        for ext in result.Extensions:
                            if ext[1][0].Structure == 'PROCESS_FIELD_EXPORT':
                                invoice.gtb_ref_no_date = ext[1][0].ValuePart1
                                invoice.gtb_ref_no = ext[1][0].ValuePart2
                                invoice.gtb_declaration_no = ext[1][0].ValuePart3
                                invoice.gtb_intac_date = ext[1][0].ValuePart4
                                  
                elif result.Status == 'REJECTED':
                    invoice.action_einvoice_rejected()
                elif result.Status == 'ERROR':
                    if result.GIBMessage:
                        message = result.GIBMessage
                    else:
                        message = "GIB CODE: %s" % str(result.GIBCode)
                    invoice.action_einvoice_failed(u'%s' % message)
                elif result.Status == 'PROCCESSING':
                    invoice.action_einvoice_waiting(_('E-Invoice status update'))
                      
            except WebFault as e:
                raise UserError(_('E-Invoice Provider WebService Error!') + '\n\n' + e.message)
        if invoice.gtb_intac_date:
            invoice.action_move_create() 
            
        return True

    @api.multi
    def isis_einvoice_send_response(self, invoice, response, reason):
        try:
            client = self.isis_get_client()
            result = client.service.SendResponse(self.company_id.partner_id.vat[2:],
                                                invoice.invoice_unique_id,
                                                response,
                                                reason)
            if result.Status == 'OK':
                if response == 'ACCEPTED':
                    invoice.action_einvoice_accepted(reason)
                elif response == 'REJECTED':
                    invoice.action_einvoice_rejected(reason)
            else:
                self.isis_check_error(result)
        except WebFault as e:
            raise UserError(_('E-Invoice Provider WebService Error!') + '\n\n' + e.message)
        return True

    @api.multi
    def einvoice_accept(self, invoice, reason):
        if self.type != 'isis':
            return super(AccountEinvoiceProvider, self).einvoice_accept()
        else:
            return self.isis_einvoice_send_response(invoice, 'ACCEPTED', reason)

    @api.multi
    def einvoice_reject(self, invoice, reason):
        if self.type != 'isis':
            return super(AccountEinvoiceProvider, self).einvoice_reject()
        else:
            return self.isis_einvoice_send_response(invoice, 'REJECTED', reason)
    
    
    @api.multi
    def action_einvoice_get_registered_users(self):
        previous_day = (datetime.strptime(str(self.registered_users_last_updated), '%Y-%m-%d') - timedelta(1))
        res = self.einvoice_get_registered_users(previous_day.strftime('%Y-%m-%d'))
        if res:
            self.registered_users_last_updated = date.today()
    
    @api.multi
    def einvoice_get_registered_users(self, from_date):
        if self.type != 'isis':
            return super(AccountEinvoiceProvider, self).einvoice_get_users(from_date)
        else:
            try:
                client = self.isis_get_client('users')
                result = client.service.GetActiveListByDate(from_date)
                if result:
                    for row in result[0]:
                        postbox = self.env['res.partner.einvoice.postbox'].search([
                            ('identifier', '=', 'TR'+row.Identifier),
                            ('name', '=', row.Alias)
                        ], limit=1)
                        if not postbox:
                            postbox = {
                                'identifier': 'TR'+row.Identifier,
                                'name': row.Alias,
                                'title':row.Title
                            }
                            self.env['res.partner.einvoice.postbox'].create(postbox)
                    
                    self._cr.commit()
                    
                    self._cr.execute(
                        """
                        UPDATE account_einvoice_postbox pb set partner_id = (SELECT id from res_partner where parent_id is null and vat = pb.identifier limit 1) 
                        """)
                    self._cr.commit()
                    
                    self._cr.execute(
                        """
                        UPDATE res_partner set einvoice_registered_user = true, default_einvoice_profile = 'TICARIFATURA' where parent_id is null and id in 
                                (SELECT distinct(partner_id) FROM  account_einvoice_postbox) 
                        """)
                    
                    self._cr.commit()
                    
                    self._cr.execute(
                        """
                        UPDATE res_partner p SET default_einvoice_postbox_id = (SELECT id FROM  account_einvoice_postbox where partner_id = p.id LIMIT 1) 
                        WHERE parent_id is null and default_einvoice_postbox_id is null and 
                        NOT EXISTS (SELECT * from (SELECT count(*) as c FROM account_einvoice_postbox 
                                    WHERE identifier = p.vat GROUP BY identifier ) t WHERE c > 1  )
                        """)
                    
                    self._cr.commit()
                    
                return True
            except WebFault as e:
                _logger.error(_('E-Invoice Provider WebService Error!')+ '\n\n' + e)
                pass
            return False

    @api.multi
    def get_registered_user(self, vknList):
        if self.type != 'isis':
            return super(AccountEinvoiceProvider, self).einvoice_get_registered_users_by_vkn(vknList)
        else:
            try:
                client = self.isis_get_client('users')
                l = client.factory.create('ns3:ArrayOfstring')   
                l.string = vknList
                result = client.service.GetActiveListByVknList(l)
                registered_user=False
                if result:
                    partners_to_check = {}
                    for row in result[0]:
                        partners_to_check[row.Identifier] = True
                        user = self.env['account.einvoice.registered.user'].search([
                            ('identifier', '=', row.Identifier),
                            ('alias', '=', row.Alias)
                        ], limit=1)
                        if not user:
                            updatedate=""
                            if hasattr(row, 'UpdatedDate'):
                                updatedate=row.UpdatedDate
                            user = {
                                'identifier': row.Identifier,
                                'alias': row.Alias,
                                'title': row.Title or '',
                                'type': row.Type or '',
                                'first_created': str(row.CreatedDate),
                                'alias_created': updatedate,
                            }
                            registered_user = self.env['account.einvoice.registered.user'].create(user)
                            self.einvoice_check_user(registered_user)
                    
                    for partner in self.env['res.partner'].search([('parent_id','=',False),('sanitized_vat','in',list(partners_to_check.keys()))]):
                        if len(partner.einvoice_postbox_ids)>1:
                            defaultpk = self.env['res.partner.einvoice.postbox'].search([('partner_id','=',partner.id),('name','ilike','default')])
                            if len(defaultpk) > 0:
                                partner.default_einvoice_postbox_id = defaultpk[0]
                            
                        
                return registered_user,registered_user
            except WebFault as e:
                _logger.error(_('E-Invoice Provider WebService Error!')+ '\n\n' + e.message)
                pass
            return False
    
    @api.multi
    def einvoice_check_user(self, registered_user):
        users = self.env['res.partner'].search([('vat', '=', 'TR'+registered_user.identifier)])
        for user in users:
            postbox = {
                'partner_id': user.id,
                'name': registered_user.alias,
                'identifier': registered_user.identifier
            }
            if not user.einvoice_registered=='yes':
                user.einvoice_registered = 'yes'
                self.env['res.partner.einvoice.postbox'].create(postbox)
            else:
                pbx = self.env['res.partner.einvoice.postbox'].search([('partner_id', '=', user.id),
                                                                   ('name', '=', registered_user.alias)])
                if not pbx:
                    self.env['res.partner.einvoice.postbox'].create(postbox)
            if not user.default_einvoice_postbox_id and user.einvoice_postbox_ids:
                user.default_einvoice_postbox_id = user.einvoice_postbox_ids[0]

    
    @api.multi
    def einvoice_get_invoices(self):
        if self.type != 'isis':
            return super(AccountEinvoiceProvider, self).einvoice_get_invoices()
        else:
            try:
                client = self.isis_get_client()
                count = 0
                while count < 50:
                    count += 1
                    result = client.service.GetSingleEnvelope(self.company_id.partner_id.vat[2:])
                    self.isis_check_error(result)
                    if result.EnvelopeUUID:
                        bytedata = base64.decodestring(result.ByteData)
                        buffer = io.BytesIO(bytedata)
                        if zipfile.is_zipfile(buffer):
                            file = zipfile.ZipFile(buffer, 'r')
                            for name in file.namelist():
                                bytedata = file.read(name)
                        _logger.debug("Processing Envelope: %s" % bytedata.decode('utf-8'))
                        self.einvoice_process_envelope(bytedata)
                        result = client.service.ReceiveEnvelopeDone(self.company_id.partner_id.vat[2:],
                                                                   result.EnvelopeUUID)
                        self.isis_check_error(result)
                        self._cr.commit()
                    else:
                        count = 50
                return True
            except WebFault as e:
                _logger.error(_('E-Invoice Provider WebService Error!')+ '\n\n' + e.message)
                pass
            return False


    @api.multi
    def einvoice_update_invoices(self):
        if self.type != 'isis':
            return super(AccountEinvoiceProvider, self).einvoice_update_invoices()
        else:
            invoices = self.env['account.invoice'].search([('einvoice_state', '=', 'waiting'),
                                                           ('company_id', '=', self.company_id.id)])
            for invoice in invoices:
                try:
                    self.einvoice_get_status(invoice)
                except:
                    pass
    
    #cron jobs
    
    
    @api.model
    def run_get_registered_users(self):
        providers = self.search([('auto_registered_user_update', '=', True)])
        for provider in providers:
            provider.action_einvoice_get_registered_users()

    @api.model
    def run_get_einvoices(self):
        companies = self.env['res.company'].search([('einvoice_registered_company', '=', True)])
        for company in companies:
            if company.einvoice_provider.auto_invoice_retrieval:
                company.einvoice_provider.action_einvoice_get_invoices()

    @api.model
    def run_update_einvoices(self):
        companies = self.env['res.company'].search([('einvoice_registered_company', '=', True)])
        for company in companies:
            if company.einvoice_provider.auto_invoice_status_update:
                company.einvoice_provider.action_einvoice_update_invoices()

    @api.model
    def run_send_einvoices(self):
        companies = self.env['res.company'].search([('einvoice_registered_company', '=', True)])
        exception_invoices = self.env['account.invoice']
        for company_id in companies.ids:
            for invoice in self.env['account.invoice'].search([('is_einvoice','!=',False),
                                                               ('state','in',['open','paid']),
                                                               ('einvoice_state','=','draft'),
                                                               ('company_id','=',company_id)],order='internal_number asc',limit=10):
                try:
                    invoice.action_einvoice_send_xml()
                except UserError as e:
                    exception_invoices |= invoice
                    message = _('E-Invoice Provider XML Send Error!')+ '\n\n' + e.value
                    invoice.message_post(body=message)
                    _logger.error(message)
                    
                except Exception as e:
                    exception_invoices |= invoice
                    message = _('E-Invoice Provider XML Send Error!')+ '\n\n' + e.message
                    invoice.message_post(body=message)
                    _logger.error(message)
                    
        exception_invoices.write({'einvoice_state':'exception'})    




