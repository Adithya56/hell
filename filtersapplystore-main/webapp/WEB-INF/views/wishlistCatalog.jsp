<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.*" %>
<%@ page import="eStoreProduct.model.Product" %>
<%@ page import="eStoreProduct.DAO.ProdStockDAO" %>
<%@ page import="eStoreProduct.DAO.ProdStockDAOImp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
       <div class="container mt-5">
        <h2>Wishlist</h2>
        <div class="row mt-4">
            <%-- Iterate over the products and render the HTML content --%>
            <%
                List<Product> products = (List<Product>) request.getAttribute("products");
            ProdStockDAO ps = new ProdStockDAOImp();
                for (Product product : products) {
            %>
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="card h-100">
                    <img class="card-img-top" src="<%= product.getImage_url() %>" alt="<%= product.getProd_title() %>">
                    <div class="card-body">
                         <h5 class="card-title"><%= product.getProd_title() %></h5>
                    	 <p class="card-text"><%= product.getProd_desc() %></p>
                   		 <p class="card-text"><%= ps.getProdPriceById(product.getProd_id()) %></p>
                        <button class="btn btn-primary removeFromWishlist" data-product-id="<%= product.getProd_id() %>">Remove from wishlist</button>
                        <button class="btn btn-primary addToCartButton" data-product-id="<%= product.getProd_id() %>">Add To Cart</button>
                    </div>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>