# -*- coding: utf-8 -*-
from odoo import http,  _
from odoo.http import request, content_disposition
import base64

import odoo.modules.registry

import os


def binary_content(xmlid=None, model='ir.attachment', id=None, field='datas', unique=False, filename=None,
                   filename_field='datas_fname', download=False, mimetype=None,
                   default_mimetype='application/octet-stream', env=None):
    return request.registry['ir.http'].binary_content(
        xmlid=xmlid, model=model, id=id, field=field, unique=unique, filename=filename,
        filename_field=filename_field,
        download=download, mimetype=mimetype, default_mimetype=default_mimetype, env=env)


class Binary(http.Controller):
    @http.route('/web/binary/download_document', type='http', auth="public")
    def download_document(self, filename=None, undelete=None, **kw):
        """ Download link for files stored as binary fields.
        :param str model: name of the model to fetch the binary from
        :param str field: binary field
        :param str id: id of the record from which to fetch the binary
        :param str filename: field holding the file's name, if any
        :returns: :class:`werkzeug.wrappers.Response`
        """

        with open(filename, 'rb') as f:
            filecontent = f.read()

        head, tail = os.path.split(filename)

        if not undelete:
            if os.path.isfile(filename):
                os.remove(filename)

        return request.make_response(filecontent,
                                     [('Content-Type', 'application/octet-stream'),
                                      ('Content-Disposition', content_disposition(tail))])

    @http.route('/web/binary/show_document', type='http', auth="public")
    def content_common(self, xmlid=None, model='ir.attachment', id=None, field='datas', filename=None,
                       filename_field='datas_fname', unique=None, mimetype=None, download=None, data=None, token=None,
                       **kw):
        status, headers, content = binary_content(xmlid=xmlid, model=model, id=id, field=field, unique=unique,
                                                  filename=filename, filename_field=filename_field, download=download,
                                                  mimetype=mimetype)

        content_base64 = base64.b64decode(content)
        headers.append(('Content-Length', len(content_base64)))
        response = request.make_response(content_base64, headers)

        return response
    
    @http.route("/web/show_invoice_pdf/<model('account.invoice'):invoice>", type='http', auth="user")
    def einvoice_pdf(self, invoice, **kw):
        content_base64 = invoice.generate_einvoice_pdf()
        content = base64.b64decode(content_base64)
    
        
        headers = [('Content-Type', 'application/pdf'), 
                   ('Content-Length', len(content)),
                   ('Content-Disposition', content_disposition('%s.pdf' % invoice.number))]
        
        #filename = 'Invoices.pdf'
        #response.headers.add('Content-Disposition', content_disposition(filename))
        
        
        
        response = request.make_response(content, headers)

        return response
    

