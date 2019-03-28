# -*- coding: utf-8 -*-


from odoo.http import Controller, route, request
from odoo import tools
from odoo.addons.web.controllers.main import  content_disposition
import base64
import PyPDF2
import os
import tempfile
from contextlib import closing

class ReportEinvoicePdf(Controller):

    @route([
        '/report/einvoicepdf',
        '/report/einvoicepdf/<docids>',
    ], type='http', auth='user', website=True)
    def report_einvoicepdf(self, docids=None, **data):
        cr, uid, context = request.cr, request.uid, request.context

        if docids:
            docids = [int(i) for i in docids.split(',')]
        
        invoice_ids = request.env['account.invoice'].browse(docids)
        
        output = PyPDF2.PdfFileWriter()
        output_fd, output_file_path = tempfile.mkstemp(suffix='.pdf', prefix='invoice_report.')
        os.close(output_fd)
        
        for pdf_file in invoice_ids.mapped('einvoice_pdf_id.store_fname'):
            
            file_path = os.path.join(tools.config["data_dir"],'filestore',request.env.cr.dbname,pdf_file)
            pdf_fd = PyPDF2.PdfFileReader(file(file_path, "rb"))
            for page in range(pdf_fd.getNumPages()):
                output.addPage(pdf_fd.getPage(page))
         
        outputstream = file(output_file_path, "wb")
        output.write(outputstream)
        outputstream.close()
        
        pdf_fd = open(output_file_path,'rb')
        pdf = pdf_fd.read()          
        pdfhttpheaders = [('Content-Type', 'application/pdf'), ('Content-Length', len(pdf))]
        response = request.make_response(pdf, headers=pdfhttpheaders)
        filename = 'Invoices.pdf'
        response.headers.add('Content-Disposition', content_disposition(filename))
        
        return response