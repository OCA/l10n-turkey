# -*- encoding: utf-8 -*-
#
#Created on Dec 21, 2018
#
#@author: dogan
#


from odoo import models, fields


class EinvoicePostbox(models.Model):
    _name = 'res.partner.einvoice.postbox'
    _description="Partner Postbox"
    
    name = fields.Char('Name', required=True)
    partner_id = fields.Many2one('res.partner','Partner', required=True, ondelete='cascade')
    identifier = fields.Char('Identifier')
    
    
class AccountEinvoiceRegisteredUser(models.Model):
    _name='account.einvoice.registered.user'
    
    
    identifier= fields.Char('Identifier')
    alias = fields.Char('Alias')
    title = fields.Char('Title')                          
    type = fields.Char('Type')
    first_created= fields.Char('First Created')
    alias_created = fields.Char('Alias Created')