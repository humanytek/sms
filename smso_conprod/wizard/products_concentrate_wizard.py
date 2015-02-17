# -*- encoding: utf-8 -*-
##############################################################################
#
#    Copyright (c) 2013 SF Soluciones.
#    (http://www.sfsoluciones.com)
#    contacto@sfsoluciones.com
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
##############################################################################

from osv import fields, osv

class products_concentrate_wizard(osv.osv_memory):
    
    _name = "products.concentrate.wizard"
    _columns = {
                'initial_date': fields.date("Initial Date"),
                'end_date': fields.date("End Date"),
               }
    
    def print_button(self, cr, uid, ids, context=None):

        data = self.read(cr, uid, ids,)[-1]
        initial_date = data.get('initial_date',False)
        end_date = data.get('end_date',False)
        stock_pool = self.pool.get('stock.picking.out')
        stock_ids = stock_pool.search(cr, uid, [('state','in',['done']),('date','>=',initial_date),
                                                ('date','<=',end_date)])
        
        if context is None:
            context = {}
        context['data'] = data
        report = {
            'type': 'ir.actions.report.xml',
            'report_name': 'product.concentrate',
            'datas': {
                'model':'stock.picking.out',           
                'ids': stock_ids,
                'report_type': 'pdf',
                'form': data,              
                },
            'nodestroy': False,
            'context': context
            }
        return report
        
    

    
products_concentrate_wizard()

# vim:expandtab:smartindent:tabstop=4:softtabstop=4:shiftwidth=4: