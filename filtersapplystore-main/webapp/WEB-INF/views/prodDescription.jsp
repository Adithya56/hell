<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.util.*" %>
<%@ page import="eStoreProduct.model.Product" %>
<%@ page import="eStoreProduct.DAO.ProdStockDAO" %>
<%@ page import="eStoreProduct.DAO.ProdStockDAOImp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Product Description</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 20px;
    }

    .container {
        max-width: 800px;
        margin: 0 auto;
    }

    h2 {
        text-align: center;
        margin-bottom: 20px;
    }

    .product-image {
        text-align: center;
        margin-bottom: 20px;
    }

    .product-image img {
        max-width: 100%;
        max-height: 400px;
    }

    .product-details {
        text-align: center;
    }

    .product-name {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 10px;
    }

    .product-description {
        margin-bottom: 20px;
    }

    .product-price {
        font-size: 20px;
        margin-bottom: 20px;
    }
</style>
</head>

<%
    Product product = (Product)request.getAttribute("oneproduct");
	ProdStockDAO ps = new ProdStockDAOImp();
%>

<div class="container">
    <h2>Product Description</h2>
    <div class="product-image">
        <img src="<%= product.getImage_url()%>" alt="<%= product.getProd_title() %>">
    </div>
    <div class="product-details">
        <h3 class="product-name"><%= product.getProd_title() %></h3>
        <p class="product-description"><%= product.getProd_desc() %></p>
        <p class="product-price"><%= ps.getProdPriceById(product.getProd_id()) %></p>
    </div>
</div>

</body>
</html>