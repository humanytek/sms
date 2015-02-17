<html>
<head>
    <style type="text/css">
        ${css}
    </style>
</head>
<body>
	<%page expression_filter="entity"/>
    
	%for order in objects:
	
	<% setLang(order.partner_id.lang) %>
	<% temp_dict = get_initial_date(order)%>
	<br/><br/><hr/>
	<table width="100%" style="font-size:13;font-family: Times New Roman;" border="0">
	<tr>
		<td width="25%" style="font-size:15;text-align:left;">
			${_("Warehouse")}
		</td>
		<td width="25%" style="font-size:15;text-align:left;">
			${order.sale_id and order.sale_id.shop_id.name or ''}<hr/>
		</td>
		<td width="25%" style="font-size:15;text-align:left;">
			${_("Warehouse Name")}<hr/>
		</td>
		<td width="25%" style="font-size:15;text-align:left;">
			${order.sale_id and order.sale_id.shop_id.warehouse_id.name or ''}<hr/>
		</td>
	</tr>
	<tr>
		<td width="25%" style="font-size:15;text-align:left;">
			${_("Salesman")}
		</td>
		<td width="25%" style="font-size:15;text-align:left;" valign="bottom">
			${order.sale_id and order.sale_id.user_id.name or ''}<strong></strong><hr/></td>
		<td style="font-size:15;text-align:left;">
			${_("User Name")}<hr/>
		</td>
		<td width="25%">
			${order.user_id.name or ''}<hr/>
		</td>
	</tr>
	<tr>
		<td width="25%" style="font-size:15;text-align:left;">
			${_("Initial date")}
		</td>
		<td width="25%">${temp_dict.get('initial_date','')}<hr/>
		</td>
		<td width="25%" style="font-size:15;text-align:left;">
			${_("End date")}<hr/>
		</td>
		<td width="25%">
			${temp_dict.get('end_date','')}<hr/>
		</td>
	</tr>
    </table>
    
    <table width="100%" style="font-size:13;font-family: Times New Roman;" border="0">
    <tr>
    	<td width="15%"><b>
    		${_("Stock Location")}</b>
    	</td>
    	<td width="10%"><b>
    		${_("Code")}</b>
    	</td>
    	<td width="10%">
    		${""}
    	</td>
    	<td width="10%"><b>
    		${_("Quantity")}</b>
    	</td>
    	<td width="10%"><b>
    		${_("Uom")}</b>
    	</td>
    	<td><b>
    		${_("Product Name")}</b>
    	</td>
    	<td width="10%"><b>
    		${_("Sale Price")}</b>
    	</td>
    	<td width="10%"><b>
    		${_("Amount")}</b>
    	</td>
    </tr>
    </table>
    
    <% serial_nos =0%>
    <% amount=0.00%>
    <% items=0.00%>
    %for line in order.move_lines:
    <% serial_nos +=1%>
    <% amount+=line.sale_line_id and line.sale_line_id.price_unit or 0.00*line.product_qty%>
    <% items+=line.product_qty%>
    <table  width="100%" style="font-size:13;font-family: Times New Roman;" border="0">
    <tr>
    	<td width="15%">
    	${line.location_id.name or ''}
    	</td>
    	<td width="10%">
    	${line.product_id.default_code or ''}
    	</td>
    	<td width="10%">
    	${''}	
    	</td>
    	<td width="10%">
    	${formatLang(line.product_qty)}
    	</td>
    	<td width="10%">
    	${line.product_uom.name or ''}
    	</td>
    	<td >
    	${line.product_id.name}
    	</td>
    	<td width="10%">
    	${order.sale_id and order.sale_id.currency_id.symbol or ''}${' '}${line.sale_line_id and line.sale_line_id.price_unit or 0.00}
    	</td>
    	<td width="10%">
    	${order.sale_id and order.sale_id.currency_id.symbol or ''}${' '}${line.sale_line_id and line.sale_line_id.price_unit or 0.00*line.product_qty}
    	</td>
    </tr>
    </table>
    	
    %endfor
    
    <hr>
    <table  width="100%" style="font-size:13;font-family: Times New Roman;" border="0">
	    <tr>
	    	<td width="30%" style="font-size:15;text-align:left;">${_("Number of items")}
	    	</td>
	    	<td width="30%" style="font-size:15;text-align:left;">${serial_nos}
	    	</td>
	    	<td width="20%" style="font-size:15;text-align:left;">${_("Amount")}
	    	</td>
	    	<td width="20%" style="font-size:15;text-align:left;">${order.sale_id and order.sale_id.currency_id.symbol or ''}${' '}${formatLang(amount)}
	    	</td>
	    </tr>
	    <tr>
	    	<td width="25%" style="font-size:15;text-align:left;">${_("Items")}
	    	</td>
	    	<td width="25%" style="font-size:15;text-align:left;">${formatLang(items)}
	    	</td>
	    </tr>
    </table>
    
    <p style="page-break-after:always"></p>
    
%endfor
</body>
</html>