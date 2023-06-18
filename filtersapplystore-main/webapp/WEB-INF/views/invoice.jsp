<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Invoice</title>
</head>
<body>

payment Id: <%= request.getParameter("razorpay_payment_id")%> <br>
Order Id: <%= request.getParameter("razorpay_order_id")%><br>
Signature: <%= request.getParameter("razorpay_signature")%><br>
payment method: <%= request.getParameter("razorpay_method")%><br>
Amount: <%= request.getParameter("razorpay_amount")%>


</body>
</html>
