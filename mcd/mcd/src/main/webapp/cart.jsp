<%@page import="com.mcd.models.Dao.UserDaoImpli"%>
<%@page import="com.mcd.models.Dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mcd.models.Dto.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<%
// Check if user is logged in
User user = (User) session.getAttribute("pass");
boolean isLoggedIn = (user != null);
String username = isLoggedIn ? user.getName() : "Guest";

// Number formatter for currency
NumberFormat currency = NumberFormat.getCurrencyInstance(new Locale("en", "IN"));

// Fetch cart items
UserDao udao = new UserDaoImpli();
String deleteMsg = (String)request.getAttribute("deleted");
String errorMsg = (String)request.getAttribute("notdeleted");
//Check for success/error messages
String successMsg = (String) request.getAttribute("success");
String errorMsg1 = (String) request.getAttribute("error");

// Generate CSRF token if not exists
String csrfToken = (String) session.getAttribute("csrfToken");
if (csrfToken == null) {
    csrfToken = java.util.UUID.randomUUID().toString();
    session.setAttribute("csrfToken", csrfToken);
}
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Delight | Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            padding-top: 60px;
            background-color: #f8f9fa;
        }
        
        .navbar {
            background-color: #fff !important;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            min-height: 60px;
            padding-top: 0.5rem;
            padding-bottom: 0.5rem;
        }

        .navbar-brand img {
            height: 40px;
            width: auto;
        }

        .navbar-nav .nav-item {
            display: flex;
            align-items: center;
            padding: 0 0.5rem;
        }

        .navbar-nav .btn {
            flex-shrink: 0;
            white-space: nowrap;
        }

        
        .cart-table {
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        
        .cart-table th {
            background-color: #da291c;
            color: white;
        }
        
        .food-img {
            height: 80px;
            width: auto;
            border-radius: 8px;
            object-fit: cover;
        }
        
        .total-cost {
            font-size: 1.3rem;
            font-weight: bold;
            color: #da291c;
        }
        
        .btn-checkout {
            background-color: #da291c;
            border-color: #da291c;
            padding: 10px 25px;
            font-weight: 500;
        }
        
        .btn-checkout:hover {
            background-color: #b82218;
            border-color: #b82218;
        }
        
        .quantity-control {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .quantity-btn {
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
        }
                        .badge {
    padding: 0.35em 0.65em;
    font-size: 0.75em;
    font-weight: 700;
    line-height: 1;
    text-align: center;
    white-space: nowrap;
    vertical-align: baseline;
    border-radius: 0.25rem;
}

.badge-admin {
    background-color: #6c757d;
    color: white;
}
    </style>
</head>

<body>
    <!-- Header Section -->
    <header class="navbar navbar-expand-lg navbar-light fixed-top">
        <div class="container">
            <!-- LOGO -->
            <a class="navbar-brand fw-bold" href="home.jsp">
                <img src="https://logos-world.net/wp-content/uploads/2020/04/McDonalds-Logo.png" alt="Logo">
            </a>

            <!-- NAVBAR TOGGLER -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- NAVBAR ITEMS -->
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item"><a class="nav-link" href="userhome.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link active" href="menu.jsp">Menu</a></li>
                    <li class="nav-item"><a class="nav-link" href="about.jsp">About</a></li>
                    <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
                    
                    <% if(isLoggedIn) { %>
                        <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="navbarDropdown" 
                           role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-person-circle me-1"></i> <c:out value="${user.username}"/>
                            <span class="badge badge-admin ms-2">User</span>
                        </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="profile.jsp"><i class="bi bi-person-fill me-2"></i>Profile</a></li>
                                    <li><a class="dropdown-item" href="myorder.jsp"><i class="bi bi-list-check me-2"></i>My Orders</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                     <li><form action="Logout" method="post">
                                    <button type="submit" class="dropdown-item">Logout</button>
                                </form></li>
                                </ul>
                            </div>
                        </li>
                        
                        <li class="nav-item">
                            <a href="cart.jsp" class="btn btn-success">
                                <i class="bi bi-cart-fill"></i> Cart
                            </a>
                        </li>
                    <% } else { %>
                        <li class="nav-item">
                            <div class="d-flex gap-2">
                                <a href="login.jsp" class="btn btn-primary">Login</a>
                                <a href="signup.jsp" class="btn btn-outline-primary">Sign Up</a>
                            </div>
                        </li>
                    <% } %>
                </ul>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="container my-4">
    <% if (successMsg != null) { %>
            <div class="alert alert-success mt-4">
                <h4><%= successMsg %></h4>
                <% if (request.getAttribute("orderId") != null) { %>
                    <p>Order ID: <%= request.getAttribute("orderId") %></p>
                <% } %>
                <div class="d-flex gap-2 mt-3">
                    <a href="myorder.jsp" class="btn btn-primary">View My Orders</a>
                    <a href="menu.jsp" class="btn btn-outline-primary">Continue Shopping</a>
                </div>
            </div>
        <% } %>
        
        <% if (errorMsg1 != null) { %>
            <div class="alert alert-danger mt-4">
                <h4><%= errorMsg1 %></h4>
            </div>
        <% } %>
        
        <% if(deleteMsg != null) { %>
            <div class="alert alert-success">
                <%= deleteMsg %>
            </div>
        <% } %>
        
        
        
        <% if(errorMsg != null) { %>
            <div class="alert alert-danger">
                <%= errorMsg %>
            </div>
        <% } %>
        
        <% if (isLoggedIn) { %>
            <h2 class="mb-4">Your Shopping Cart</h2>
            
            <% 
            ArrayList<Cart> cartItems = udao.getCart(user.getUserId());
            if (cartItems.isEmpty()) { 
            %>
                <div class="alert alert-info">
                    Your cart is empty. <a href="userhome.jsp" class="alert-link">Browse our menu</a> to add items.
                </div>
            <% } else { 
                double totalCost = 0;
            %>
                <div class="table-responsive">
                    <table class="table cart-table">
                        <thead>
                            <tr>
                                <th>Item</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Cart item : cartItems) { 
                                double itemTotal = item.getPrice() * item.getQuantity();
                                totalCost += itemTotal;
                            %>
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <img src="<%= item.getFood_image() %>" alt="<%= item.getFood_name() %>" 
                                             class="food-img me-3">
                                        <div>
                                            <h6 class="mb-1"><%= item.getFood_name() %></h6>
                                        </div>
                                    </div>
                                </td>
                                <td class="align-middle"><%= currency.format(item.getPrice()) %></td>
                                <td class="align-middle">
                                    <div class="quantity-control">
                                  <!--       <form action="updateCart" method="post" class="d-inline">
                                            <input type="hidden" name="cartId" value="<= item.getCart_id() %>">
                                            <input type="hidden" name="action" value="decrease">
                                            <input type="hidden" name="csrfToken" value="<= csrfToken %>">
                                            <button type="submit" class="btn btn-sm btn-outline-secondary quantity-btn">-</button>
                                        </form> -->
                                        
                                        <span><%= item.getQuantity() %></span>
                                        
                                     <!--    <form action="updateCart" method="post" class="d-inline">
                                            <input type="hidden" name="cartId" value="<= item.getCart_id() %>">
                                            <input type="hidden" name="action" value="increase">
                                            <input type="hidden" name="csrfToken" value="<= csrfToken %>">
                                            <button type="submit" class="btn btn-sm btn-outline-secondary quantity-btn">+</button>
                                        </form> -->
                                    </div>
                                </td>
                                <td class="align-middle"><%= currency.format(itemTotal) %></td>
                                <td class="align-middle">
                                    <form action="removeFromCart" method="post">
                                        <input type="hidden" name="cartId" value="<%= item.getCart_id() %>">
                                        <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                                        <button type="submit" class="btn btn-sm btn-danger">
                                            <i class="bi bi-trash"></i> Remove
                                        </button>
                                    </form>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                
                <div class="d-flex justify-content-between align-items-center mt-4">
                    <a href="menu.jsp" class="btn btn-outline-secondary">
                        <i class="bi bi-arrow-left"></i> Continue Shopping
                    </a>
                    
                    <div class="text-end">
                        <div class="total-cost mb-3">Total: <%= currency.format(totalCost) %></div>
                        <a href="orderFood.jsp" class="btn btn-checkout">
                            <i class="bi bi-credit-card"></i> Proceed to Checkout
                        </a>
                    </div>
                </div>
            <% } %>
        <% } else { %>
            <div class="alert alert-warning text-center py-4">
                <h4>Please <a href="login.jsp" class="alert-link">log in</a> to view your cart</h4>
                <p class="mb-0">New customer? <a href="signup.jsp" class="alert-link">Create an account</a></p>
            </div>
        <% } %>
    </main>
    
    <!-- Footer -->
    <footer class="footer py-4">
        <div class="container">
            <div class="row">
                <div class="col-md-4 text-start">
                    <h5>About Us</h5>
                    <p>Food Delight is your go-to platform for delicious meals, offering a wide variety of dishes crafted with love.</p>
                </div>
                <div class="col-md-4 text-center">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="userhome.jsp" class="footer-link">Home</a></li>
                        <li><a href="menu.jsp" class="footer-link">Menu</a></li>
                        <% if(isLoggedIn) { %>
                            <li><a href="myorders.jsp" class="footer-link">Orders</a></li>
                        <% } %>
                        <li><a href="about.jsp" class="footer-link">About</a></li>
                        <li><a href="contact.jsp" class="footer-link">Contact</a></li>
                    </ul>
                </div>
                <div class="col-md-4 text-end">
                    <h5>Follow Us</h5>
                    <a href="#" class="social-icon"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="social-icon"><i class="bi bi-instagram"></i></a>
                    <a href="#" class="social-icon"><i class="bi bi-twitter"></i></a>
                    <a href="#" class="social-icon"><i class="bi bi-youtube"></i></a>
                </div>
            </div>
            <div class="text-center mt-3">
                <p>&copy; 2023 Food Delight | All Rights Reserved</p>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>