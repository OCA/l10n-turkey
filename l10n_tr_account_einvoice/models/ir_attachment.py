# -*- coding: utf-8 -*-

from odoo import models, fields, api


class Attachment(models.Model):
    _inherit = "ir.attachment"

    invoice_id = fields.Integer(string="Invoice Id")
