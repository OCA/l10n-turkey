{
    'name': 'Turkey Einvoice',
    'version': '12.0.1.0.0',
    'category': 'Accounting & Finance',
    'summary': 'Integrate invoice  Send E-Invoices and E-Archive Invoices through Odoo.',
    'author': 'Codequarters',
    'website': 'http://www.codequarters.com',
    'depends': [
        "account_invoice_ubl","l10n_tr_address"
    ],
    'data': [
        'security/ir.model.access.csv',
        'views/res_partner.xml',
        'views/account_invoice.xml',
        'views/account_einvoice_provider_view.xml',
        'data/custom_ubl_data.xml',
    ],
    'installable': True,
}
