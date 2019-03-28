{
    'name': 'Localization TR  Address',
    'version': '12.0.2',
    'summary': "Add custom field in Customer like District, Region, Neighbourhood",
    'description': """This Module is used to add custom field in res.partner Object""",
    'category': 'Partner',
    'website':'http://www.codequarters.com',
    'author': 'Kirankumar,Ahmet Altinisik,Onur UGUR,Codequarters',
    'external_dependencies': {'python': ['xlrd']},
    'depends': ['sale','base','contacts'],
    'data': [
        'security/ir.model.access.csv',
        'data/res.country.state.csv',
       'views/res_partner_view.xml',
        'views/address_details_view.xml',
        'wizard/wizard_import_script_views.xml',
       # 'data/res_country_data.xml',
    ],
    'installable': True,
    'auto_install': False
}
