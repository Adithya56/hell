 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="eStoreProduct.model.custCredModel" %>
    <%@ page import="eStoreProduct.utility.ProductStockPrice" %>
    <%@ page import="java.util.*" %>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

<link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
</head>
<body>
<%
custCredModel cust = (custCredModel) request.getAttribute("customer");
List<ProductStockPrice> products = (List<ProductStockPrice>) request.getAttribute("products");

%>

<div class="container">
    <div class="row">
        <div class="col-xs-12">
    		<div class="invoice-title">
    			<h2>Invoice</h2><h3 class="pull-right">By SLAM Store</h3>
    		</div>
    		<hr>
    		<div class="row">
    			<div class="col-xs-6">
    				<address>
    				<strong>Billed To:</strong><br>
    					<p>cust.getCustName()</p>
    					<p>cust.getCustMobile()</p>
    					<P>cust.getCustLocation()</P>
    				</address>
    			</div>
    			<div class="col-xs-6 text-right">
    				<address>
        			<strong>Shipped To:</strong><br>
    				<p>cust.getCustName()</p>
    					<p>cust.getCustMobile()</p>
    					<p>cust.getCustSAddress() </p>
    					<p>cust.getCustSpincode()</p>
    				</address>
    			</div>
    		</div>
    		<div class="row">
    			<div class="col-xs-6">
    				<address>
    					<strong>Payment Method:</strong><br>
    					online
    				</address>
    			</div>
    			<div class="col-xs-6 text-right">
    				<address>
    					<strong>Order Date:</strong><br>
    					March 7, 2014<br><br>
    				</address>
    			</div>
    		</div>
    	</div>
    </div>
    
    <div class="row">
    	<div class="col-md-12">
    		<div class="panel panel-default">
    			<div class="panel-heading">
    				<h3 class="panel-title"><strong>Order summary</strong></h3>
    			</div>
    			<div class="panel-body">
    				<div class="table-responsive">
    					<table class="table table-condensed">
    						<thead>
                                <tr>
        							<td><strong>ITEMID</strong></td>
        							<td class="text-center"><strong>ITEM</strong></td>
        							<td class="text-center"><strong>ProductGSTCID</strong></td>
        							<td class="text-right"><strong>PRICE</strong></td>
                                </tr>
    						</thead>
    						<tbody>
<% for(ProductStockPrice p:products){ %>
    							<tr>
    								<td>p.getProd_id()</td>
    								<td class="text-center">p.getProd_title()</td>
    								<td class="text-center">p.getProd_gstc_id()</td>
    								<td class="text-right">p.getPrice()</td>
    							</tr>
    							<%} %>
                             
    						</tbody>
    					</table>
    				</div>
    			</div>
    		</div>
    	</div>
    </div>
</div>
</body>
</html>