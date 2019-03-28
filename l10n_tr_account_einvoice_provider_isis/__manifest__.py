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

{
    'name': 'Turkey E-Invoice Integrator - ISIS',
    'version': '1.0',
    'category': 'Accounting',
    'summary': 'E-Invoice ISIS implementation',
    'description': """
Turkey E-Invoice Integrator - ISIS
====================================================

E-Invoice ISIS implementation
    """,
    'author': 'Eska Yazılım ve Danışmanlık A.Ş.',
    'website': 'http://www.eskayazilim.com.tr',
    'depends': ['l10n_tr_account_einvoice',
                ],
    'data': ['views/account_einvoice_provider_view.xml',
             ],
    'installable': True,
}