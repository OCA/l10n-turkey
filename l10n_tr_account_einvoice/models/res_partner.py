# -*- coding: utf-8 -*-

from odoo import models, api, tools, fields, _
from odoo.exceptions import ValidationError

    
class ResPartner(models.Model):
    _inherit = "res.partner"

    mersis = fields.Char(string="Mersis")
    commercial_id = fields.Char(string="Commercial Identity No")
    tax_office = fields.Char("Tax Office")

    default_einvoice_postbox_id = fields.Many2one('res.partner.einvoice.postbox')
    einvoice_postbox_ids = fields.One2many('res.partner.einvoice.postbox','partner_id',string='E-invoice Postboxes')
    einvoice_registered = fields.Selection([('yes','Yes'),
                                            ('no','No'),
                                            ('unknown','Unknown')], default='unknown')
    
    @api.onchange('vat')
    def onchange_vat(self):
        self.einvoice_registered = 'unknown'
        self.default_einvoice_postbox_id = False
        self.einvoice_postbox_ids = False
    
    @api.model
    def simple_vat_check(self, country_code, vat_number):
        '''Remove Vat Check'''
        # TODO: Add normal functionality ASAP remove country code check from Turkey

        try:
            int(country_code)
            int(vat_number)
        except ValueError:
            return super(ResPartner, self).simple_vat_check(country_code, vat_number)
        else:

            vat_number = str(country_code) + str(vat_number)

            # check vat number (vergi no)
            if len(vat_number) == 10:
                sum = 0
                check = 0
                for f in range(0, 9):
                    c1 = (int(vat_number[f]) + (9 - f)) % 10
                    c2 = (c1 * (2 ** (9 - f))) % 9
                    if (c1 != 0) and (c2 == 0):
                        c2 = 9
                    sum += c2
                if sum % 10 == 0:
                    check = 0
                else:
                    check = 10 - (sum % 10)
                if int(vat_number[9]) == check:
                    return super(ResPartner, self).simple_vat_check("TR", vat_number)

            # check personal id (tc kimlik no)
            if len(vat_number) == 11:
                c1a = 0
                c1b = 0
                c2 = 0
                for f in range(0, 9, 2):
                    c1a += int(vat_number[f])
                for f in range(1, 9, 2):
                    c1b += int(vat_number[f])
                c1 = ((7 * c1a) - c1b) % 10
                for f in range(0, 10):
                    c2 += int(vat_number[f])
                c2 = c2 % 10
                if int(vat_number[9]) == c1 and int(vat_number[10]) == c2:
                    return super(ResPartner, self).simple_vat_check("TR", vat_number)

        return super(ResPartner, self).simple_vat_check(country_code, vat_number)


class ResCompany(models.Model):
    _inherit = "res.company"

    mersis = fields.Char(string="Mersis")
    commercial_id = fields.Char(string="Commercial Identity No")
    tax_office = fields.Char("Tax Office")
    einvoice_registered = fields.Boolean('E-Invoice registered?', default=False)
    einvoice_provider_id = fields.Many2one('account.einvoice.provider',string='E-Invoice Provider')
    einvoice_sender_email = fields.Char('Einvoice sender')
    @api.multi
    def write(self, vals):

        partner_id = self.partner_id
        dict = {}

        if vals.get("mersis") != None:
            dict["mersis"] = vals.get("mersis")
        if vals.get("commercial_id") != None:
            dict["commercial_id"] = vals.get("commercial_id")
        if vals.get("tax_office") != None:
            dict["tax_office"] = vals.get("tax_office")

        if len(dict) > 0:
            partner_id.write(dict)

        return super(ResCompany, self).write(vals)
