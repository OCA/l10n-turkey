# -*- encoding: utf-8 -*-
#
#Created on Dec 24, 2018
#
#@author: dogan
#

from odoo import models, fields, api


class EinvoiceProvider(models.Model):
    _name = 'account.einvoice.provider'
    _description="Einvoice Provider"
    
    type = fields.Selection([],string='Type')
    environment = fields.Selection([('test','TEST'),('prod','PRODUCTION')])
    name = fields.Char('Name')
    company_id = fields.Many2one('res.company',default=1)
    
    auto_registered_user_update = fields.Boolean(string='Auto Registered User Update', default=False)

    auto_invoice_retrieval = fields.Boolean(string='Auto Invoice Retrieval', default=False)

    auto_invoice_status_update = fields.Boolean(string='Auto Invoice Status Update', default=False)

    import_incoming_invoice_lines = fields.Boolean(string='Import Incoming Invoice Lines', default=False)

    force_incoming_invoice_check = fields.Boolean(string="Force Incoming Invoice Check", default=True)

    registered_users_last_updated = fields.Date(string="Users Last Updated", default='2000-01-01')

    
    
    @api.multi
    def send(self, invoice):
        ''' Send e-invoice ubl to provider. Intended to be implemented by inheriting module
        '''
        pass
    
    
    @api.multi
    def get_registered_user(self, vat):
        ''' Get registration status of a vat from provider. Intended to be implemented by inheriting module
        '''
        pass
    
    @api.multi
    def get_pdf(self, uuid):
        ''' Get PDF document from provider. Intended to be implemented by inheriting module
        '''
        pass
    
    @api.multi
    def GetXML(self, invoice):
        ''' Get signed xml from provider. Intended to be implemented by inheriting module
        '''
        pass
    
    @api.multi
    def get_state(self, invoice):
        ''' Update invoice state from provider. Intended to be implemented by inheriting module
        '''
        pass
    
    @api.multi
    def cancel(self, invoice):
        ''' Update invoice state from provider. Intended to be implemented by inheriting module
        '''
        pass
    
   
    
    
    