<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="eStoreProduct.model.Product" %>
<%@ page import="eStoreProduct.model.custCredModel" %>
<%@ page import="eStoreProduct.DAO.ProdStockDAO" %>
<%@ page import="eStoreProduct.DAO.ProdStockDAOImp" %>
<%@ page import="eStoreProduct.utility.ProductStockPrice" %>
<%@ page import="eStoreProduct.model.productqty" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<div id="id1">
<div class="container mt-5">
    <div class="row mt-4">
        <%
        double productCost=0.0;
        int quantity=1;
        custCredModel cust = (custCredModel) request.getAttribute("customer");
        List<ProductStockPrice> products = (List<ProductStockPrice>) request.getAttribute("products");
        int nop = 0, shpch = 0;
        double totalCost = 0;

        for (ProductStockPrice product : products) {
        	quantity = product.getQuantity();
            productCost= product.getPrice();
            totalCost+=productCost*quantity;
        %>
        <div class="col-lg-4 col-md-6 mb-4">
            <div class="card h-100">
                <img class="card-img-top" src="<%= product.getProd_title() %>" alt="<%=product.getProd_title() %>">
                <div class="card-body">
                    <h5 class="card-title"><%= product.getProd_title() %></h5>
                    <%-- <p class="card-text"><%= ps.getProdPriceById(product.getProd_id()) %></p> --%>
                    <p class="card-text">Quantity: <%= quantity %></p>
                    <p class="card-text">Subtotal: <%= productCost %></p>
                </div>
            </div>
        </div>
        <%
        }
        %>
    </div>
</div>
   <div id="cont">
     <form action="orderFunction()" method="post">    
        <label>CustomerId:</label>
        <input type="hidden" id="custId" name="custId" value="${cust != null ? cust.custId : ""}"><br>

        <label for="custName">Name:</label>
        <input type="text" id="custName" name="custName" value="${cust != null ? cust.custName : ""}" readonly><br>

        <label for="custMobile">Mobile:</label>
        <input type="text" id="custMobile" name="custMobile" value="${cust != null ? cust.custMobile : ""}"><br>

        <label for="custSAddress">Shipping Address:</label>
        <input type="text" id="custSAddress" name="custSAddress" value="${cust != null ? cust.custSAddress : ""}"><br>

        <label for="custsPincode">Shipment Pincode:</label>
        <input type="number" id="custsPincode" name="custSpincode" value="${cust != null ? cust.custSpincode : ""}"><br>

        <input type="submit" value="ok">
    </form>
        </div>
<div>
<p class="card-text">TotalCost: <%= totalCost %></p>
</div>


<div>
    <button class="btn btn-primary back">Back</button>
    <button class="btn btn-primary continue" onclick="continuenext()">Continue</button>
</div>

</div>

<script>
function orderFunction()
{
	var mobile=$("#custMobile").val();
	var custsaddress=$("#custSAddress").val();
	var spincode=$("#custSpincode").val();
	 $.ajax({
		    url: "confirmShipmentAddress",
		    method: 'POST',
		    data: { mobile:mobile,
		    	custsaddress:custsaddress,
		    	spincode:spincode
		    	},
		    success: function(response) {
		    	document.getElementById("cont").innerHTML="UPDATED DETAILS";
		    },
		    error: function(xhr, status, error) {
		      console.log('AJAX Error: ' + error);
		    }
		  });	
	}
function continuenext()
{  console.log("hiiiiiiiii");
  	window.location.href="done";
	
	}
    $(document).on('click', '.back', function(event) {
        event.preventDefault();
        console.log("Back");
        history.back();
    });
   
</script>
</body>
</html>
