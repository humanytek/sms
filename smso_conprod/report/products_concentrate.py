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


import time
from report import report_sxw
from datetime import datetime, timedelta

class product_concentrate(report_sxw.rml_parse):
    def __init__(self, cr, uid, name, context):
        super(product_concentrate, self).__init__(cr, uid, name, context=context)
        self.localcontext.update({
            'time': time,
            'get_initial_date': self.get_initial_date
            
        })
        
    def get_initial_date(self, order):
        ctxt = self.localcontext
        temp_dict = {}
        initial_date = ctxt['data']['form'].get('initial_date',"")
        end_date = ctxt['data']['form'].get('end_date',"")
        temp_dict.update({'initial_date':initial_date,
                          'end_date':end_date})
        return temp_dict
        


report_sxw.report_sxw(
                      'report.product.concentrate',
                      'stock.picking.out',
                      'smso_conprod/report/product_concentrate.mako',
                      parser=product_concentrate, header="external")



# vim:expandtab:smartindent:tabstop=4:softtabstop=4:shiftwidth=4: