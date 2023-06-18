<%-- 
 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="eStoreProduct.model.Product" %>
<%@ page import="eStoreProduct.DAO.ProdStockDAO" %>
<%@ page import="eStoreProduct.DAO.ProdStockDAOImp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cart</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    $(document).ready(function() {
        // Function to update quantity and cart cost
        function updateQuantity(element) {
            var productId = $(element).data("product-id");
            var quantity = $(element).val();
            
            // AJAX call to update the quantity
            $.ajax({
                url: "updateCart",
                type: "POST",
                data: { productId: productId, quantity: quantity },
                success: function(response) {
                    // Update the cart cost on success
                    $("#cst").text("Total Cost: $" + response.cartcost);
                },
                error: function(xhr, status, error) {
                    console.log('AJAX Error: ' + error);
                  }
            });
        }}); 
        
        // Attach event listener to quantity input field
        $(document).on("change", ".qtyinp", function() {
            updateQuantity(this);
        });
    	$(document).on('click', '.buyid', function(event) {
    		    event.preventDefault();
    buynow()
    });
    	function buynow()
    	  {
    		  console.log("buy now");

    		  	window.location.href="buycartitems";  
    		    }
    </script>
</head>
<body>
    <div class="container mt-5">
        <h2>Cart</h2>
        <div class="row mt-4">
            Iterate over the products and render the HTML content
            <%
            
                List<Product> products = (List<Product>) request.getAttribute("products");
            if(products!=null){
            ProdStockDAO ps = new ProdStockDAOImp();
            double cartcost=0;
            int totalitems=0;
            int shipch=0;
           /* cartcost = (double) request.getAttribute("cartt"); */
                for (Product product : products) {totalitems++;
                cartcost+=ps.getProdPriceById(product.getProd_id());
            %>
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="card h-100">
                    <img class="card-img-top" src="<%= product.getImage_url() %>" alt="<%= product.getProd_title() %>">
                    <br>
                    
                    <div class="card-body">
                    <label>Quantity<input type="number" align="center" name="Quantity" class="form-control qtyinp" style="width: 50px;" min="1" data-product-id="<%= product.getProd_id() %>" onchange="updateQuantity(this)" value="1"></label>
                    
                        <h5 class="card-title"><%= product.getProd_title() %></h5>
                        <p class="card-text"><%= product.getProd_desc() %></p>
                        <p class="card-text"><%= ps.getProdPriceById(product.getProd_id()) %></p>
                         
                        <button class="btn btn-primary removeFromCart" data-product-id="<%= product.getProd_id() %>">Remove from Cart</button>
                        <button class="btn btn-secondary addToWishlistButton" data-product-id="<%= product.getProd_id() %>">Add to Wishlist</button>
                    </div>
                </div>
            </div>
            <%
                }
            %>
            <div>
            <div>
            <p>Total Items:<%=totalitems %></p>
            <p>ShipMent Charges:<%=shipch %></p>
            
            </div>
            <div id="costdiv">
            	<p id="cst">TotalCost:$<%= cartcost%></p>
            	<button class="buyid" style="background-color: #4CAF50; color: white; padding: 10px 20px; border: none; cursor: pointer;">Buy Now</button>

            	<%
            }
            	else
            	{
            		%><p>No CartProducts</p>
            		<%
            }
            %></div> 
            </div>
        </div>
    </div>
</body>
</html>
 --%>
 
 
 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="eStoreProduct.model.Product" %>
<%@ page import="eStoreProduct.DAO.ProdStockDAO" %>
<%@ page import="eStoreProduct.DAO.ProdStockDAOImp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cart</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"> -->
  <!-- <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
    <style>
        .product-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            align-items: flex-start;
            gap: 20px;
        }
        
        .product-card {
            flex: 0 0 calc(33.33% - 20px);
            max-width: calc(33.33% - 20px);
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .product-card img {
            width: 150px;
            height: 150px;
            object-fit: cover;
            margin-bottom: 10px;
        }
        
        .product-card .card-body {
            text-align: center;
        }
        
        .product-card .card-body p {
            margin-bottom: 0;
        }
        
        #costdiv {
            text-align: center;
            margin-top: 20px;
        }
        
    </style>
    <style>
    /* ...Existing styles... */

    .product-card .card-body {
        text-align: center;
    }

    .product-card .card-body p {
        margin-bottom: 0;
    }

    .product-card .card-body .btn {
        margin-top: 10px;
    }

    #costdiv {
        text-align: center;
        margin-top: 20px;
    }

    #costdiv p {
        margin-bottom: 10px;
    }

    #costdiv .buyid {
        background-color: #4CAF50;
        color: white;
        padding: 10px 20px;
        border: none;
        cursor: pointer;
    }
</style>
    
    <script>
    function updateQuantity(input) {
        var quantity = input.value;
        var productId = input.getAttribute('data-product-id');
        console.log(quantity);
        console.log("product no="+productId);
        $.ajax({
          url: 'updateQuantity',
          method: 'POST',
          data: { productId: productId, quantity: quantity },
          success: function(response) {
            console.log(response);
            $("#cst").html("TotalCost: $" + response);
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
          }
        });
      }
            
            // Attach event listener to quantity input field
            $(document).on("change", ".qtyinp", function() {
                updateQuantity(this);
            });
            
            $(document).on('click', '.buyid', function(event) {
                event.preventDefault();
                buynow();
            });
            
            function buynow() {
                console.log("buy now");
                window.location.href = "buycartitems";
            }
        });
    </script>
</head>
<body>
    <div class="container mt-5">
        <h2>Cart</h2>
        <div class="row mt-4">
            <div class="product-container">
                <%-- Iterate over the products and render the HTML content --%>
                <%
                    List<Product> products = (List<Product>) request.getAttribute("products");
                    if (products != null) {
                        ProdStockDAO ps = new ProdStockDAOImp();
                        double cartcost = 0;
                        int totalitems = 0;
                        int shipch = 0;
                        for (Product product : products) {
                            totalitems++;
                            cartcost += ps.getProdPriceById(product.getProd_id());
                %>
                <div class="product-card">
                    <div class="card h-100">
                        <img class="card-img-top" src="<%= product.getImage_url() %>" alt="<%= product.getProd_title() %>">
                        <div class="card-body">
                            <label>Quantity
                                <input type="number" name="Quantity" class="form-control qtyinp" style="width: 50px;" min="1" data-product-id="<%= product.getProd_id() %>" onchange="updateQuantity(this)" value="1">
                            </label>
                            <h5 class="card-title"><%= product.getProd_title() %></h5>
                            <p class="card-text"><%= product.getProd_desc() %></p>
                            <p class="card-text">$<%= ps.getProdPriceById(product.getProd_id()) %></p>
                            <button class="btn btn-primary removeFromCart" data-product-id="<%= product.getProd_id() %>">Remove from Cart</button>
                            <button class="btn btn-secondary addToWishlistButton" data-product-id="<%= product.getProd_id() %>">Add to Wishlist</button>
                        </div>
                    </div>
                </div>
                <%
                        }
                %>
            </div>
           <div>
    <div id="costdiv">
        <p id="cst">Total Cost: $<%= cartcost %></p>
        <button class="buyid">Buy Now</button>
    </div>
    <% } else { %>
    <p>No Cart Products</p>
    <% } %>
</div>
        </div>
    </div>
</body>
</html>
 