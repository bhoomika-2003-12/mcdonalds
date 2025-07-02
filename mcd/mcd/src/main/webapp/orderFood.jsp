<%@page import="com.mcd.models.Dao.UserDaoImpli"%>
<%@page import="com.mcd.models.Dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mcd.models.Dto.*" %>
<%@ page import="com.mcd.models.Dao.AdminDao" %>
<%@ page import="com.mcd.models.Dao.AdminDaoImpli" %>
<%@ page import="java.util.*" %>

<%
// Check if user is logged in
User user = (User) session.getAttribute("pass");
boolean isLoggedIn = user != null;
String username = isLoggedIn ? user.getName() : "Guest";

// Check for success/error messages
String successMsg = (String) request.getAttribute("success");
String errorMsg = (String) request.getAttribute("error");

// Fetch food items from database
AdminDao adao = new AdminDaoImpli();
UserDao udao = new UserDaoImpli();
ArrayList<Food> foodlist = adao.getAllFood();

// Get cart items - only if there's no success message
ArrayList<Cart> cartItems = null;
if (successMsg == null && isLoggedIn) {
    cartItems = udao.getCart(user.getUserId());
}
%>
    
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Delight | Checkout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #ff6b6b;
            --secondary-color: #ff8e8e;
            --dark-color: #333;
            --light-color: #f8f9fa;
            --success-color: #28a745;
            --danger-color: #dc3545;
            --warning-color: #fd7e14;
            --info-color: #17a2b8;
        }

        body {
            font-family: 'Poppins', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            margin: 0;
            padding-top: 70px;
            background-color: #f5f5f5;
            color: #333;
            line-height: 1.6;
        }

        /* Navbar Styles */
        .navbar {
            background-color: white !important;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 0.5rem 0;
        }

        .navbar-brand img {
            transition: transform 0.3s ease;
        }

        .navbar-brand:hover img {
            transform: scale(1.05);
        }

        .nav-link {
            font-weight: 500;
            padding: 0.5rem 1rem;
            transition: all 0.3s ease;
            color: var(--dark-color) !important;
        }

        .nav-link:hover {
            color: var(--primary-color) !important;
            transform: translateY(-2px);
        }

        /* Checkout Container */
        .checkout-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 2rem;
            margin: 2rem auto;
            transition: all 0.3s ease;
        }

        .checkout-container:hover {
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .checkout-title {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 1.5rem;
            position: relative;
            padding-bottom: 0.5rem;
        }

        .checkout-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 3px;
            background: var(--primary-color);
            border-radius: 3px;
        }

        /* Customer Info */
        .customer-info {
            background: rgba(255, 107, 107, 0.1);
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            border-left: 4px solid var(--primary-color);
        }

        /* Table Styles */
        .table {
            margin-bottom: 2rem;
            border-radius: 8px;
            overflow: hidden;
        }

        .table th {
            background-color: var(--primary-color);
            color: white;
            font-weight: 600;
            border: none;
        }

        .table td, .table th {
            vertical-align: middle;
            padding: 1rem;
        }

        .table tbody tr {
            transition: all 0.2s ease;
        }

        .table tbody tr:hover {
            background-color: rgba(255, 107, 107, 0.05);
            transform: translateX(5px);
        }

        .total-row {
            font-weight: 600;
            background-color: rgba(40, 167, 69, 0.1) !important;
        }

        /* Form Styles */
        .form-label {
            font-weight: 500;
            margin-bottom: 0.5rem;
            color: var(--dark-color);
        }

        .form-control, .form-select {
            border-radius: 8px;
            padding: 0.75rem 1rem;
            border: 1px solid #ddd;
            transition: all 0.3s ease;
            margin-bottom: 1rem;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(255, 107, 107, 0.25);
        }

        /* Button Styles */
        .btn {
            border-radius: 8px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .btn-confirm {
            background-color: var(--success-color);
            color: white;
        }

        .btn-confirm:hover {
            background-color: #218838;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        .btn-back {
            background-color: #6c757d;
            color: white;
        }

        .btn-back:hover {
            background-color: #5a6268;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-primary:hover {
            background-color: #e05555;
            border-color: #e05555;
        }

        /* Alert Styles */
        .alert {
            border-radius: 8px;
            padding: 1.25rem;
            margin-top: 1.5rem;
        }

        /* Footer Styles */
        .footer {
            background-color: white;
            padding: 3rem 0;
            margin-top: 3rem;
            border-top: 1px solid #eee;
        }

        .footer h5 {
            font-weight: 600;
            margin-bottom: 1.25rem;
            color: var(--dark-color);
        }

        .footer-link {
            color: #666;
            text-decoration: none;
            transition: all 0.3s ease;
            display: block;
            margin-bottom: 0.5rem;
        }

        .footer-link:hover {
            color: var(--primary-color);
            transform: translateX(5px);
        }

        .social-icon {
            display: inline-block;
            width: 40px;
            height: 40px;
            line-height: 40px;
            text-align: center;
            background: #f1f1f1;
            color: #666;
            border-radius: 50%;
            margin-right: 0.5rem;
            transition: all 0.3s ease;
        }

        .social-icon:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-3px);
        }

        /* Responsive Adjustments */
        @media (max-width: 992px) {
            .navbar-collapse {
                padding: 1rem 0;
            }
            
            .checkout-container {
                padding: 1.5rem;
            }
        }

        @media (max-width: 768px) {
            body {
                padding-top: 60px;
            }
            
            .table-responsive {
                margin-bottom: 1rem;
                border-radius: 8px;
                border: 1px solid #ddd;
            }
            
            .table th, .table td {
                padding: 0.75rem;
            }
            
            .btn-group {
                width: 100%;
            }
            
            .btn {
                width: 100%;
                margin-bottom: 0.5rem;
            }
        }

        @media (max-width: 576px) {
            .checkout-container {
                padding: 1rem;
                margin: 1rem auto;
            }
            
            .customer-info {
                font-size: 0.9rem;
            }
            
            .footer {
                text-align: center;
            }
            
            .footer .col-md-4 {
                margin-bottom: 2rem;
            }
            
            .social-icon {
                margin: 0 0.25rem 0.5rem;
            }
        }

        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .animate-fade {
            animation: fadeIn 0.6s ease-out forwards;
        }

        /* Loading Spinner */
        .spinner-border {
            width: 1.5rem;
            height: 1.5rem;
            border-width: 0.2em;
            display: inline-block;
            vertical-align: text-bottom;
        }
    </style>
</head>
<body>
<!-- Header Section -->
    <header class="navbar navbar-expand-lg navbar-light bg-white fixed-top shadow-sm">
        <div class="container">
            <!-- LOGO -->
            <a class="navbar-brand fw-bold" href="home.jsp">
                <img src="https://logos-world.net/wp-content/uploads/2020/04/McDonalds-Logo-700x394.png" width="180" alt="Logo" class="img-fluid">
            </a>

            <!-- NAVBAR TOGGLER -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- NAVBAR ITEMS -->
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item"><a class="nav-link" href="userhome.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="menu.jsp">Menu</a></li>
                    <li class="nav-item"><a class="nav-link" href="about.jsp">About</a></li>
                    <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
                    
                    <% if(isLoggedIn) { %>
                        <li class="nav-item dropdown ms-2">
                            <a href="#" class="nav-link dropdown-toggle d-flex align-items-center" id="dropdownUser" data-bs-toggle="dropdown" aria-expanded="false">
                                <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="Profile" width="32" height="32" class="rounded-circle me-2">
                                <span class="d-none d-lg-inline"><%= username %></span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="dropdownUser">
                                <li><a class="dropdown-item" href="profile.jsp"><i class="bi bi-person-fill me-2"></i>Profile</a></li>
                                <li><a class="dropdown-item" href="myorders.jsp"><i class="bi bi-list-check me-2"></i>My Orders</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li> <form action="Logout" method="post">
                                    <button type="submit" class="dropdown-item">Logout</button>
                                </form></li>
                            </ul>
                        </li>
                    <% } %>
                    
                    <li class="nav-item ms-2">
                        <a href="cart.jsp" class="btn btn-success position-relative">
                            <i class="bi bi-cart-fill"></i> <span class="d-none d-md-inline">Cart</span>
                        </a>
                    </li>
                    
                    <li class="nav-item ms-2">
                        <% if(isLoggedIn) { %>
                            <a href="logout.jsp" class="btn btn-outline-danger">
                                <i class="bi bi-box-arrow-right"></i> <span class="d-none d-md-inline">Logout</span>
                            </a>
                        <% } else { %>
                            <div class="d-flex gap-2">
                                <a href="login.jsp" class="btn btn-primary">
                                    <i class="bi bi-box-arrow-in-right"></i> <span class="d-none d-md-inline">Login</span>
                                </a>
                                <a href="signup.jsp" class="btn btn-outline-primary d-none d-md-block">
                                    Sign Up
                                </a>
                            </div>
                        <% } %>
                    </li>
                </ul>
            </div>
        </div>
    </header>
    
    <main class="container animate-fade">
        <% if (successMsg != null) { %>
            <div class="alert alert-success mt-4 text-center">
                <i class="bi bi-check-circle-fill fs-1 d-block mb-3" style="color: var(--success-color);"></i>
                <h3 class="fw-bold"><%= successMsg %></h3>
                <% if (request.getAttribute("orderId") != null) { %>
                    <p class="lead">Your order ID: <span class="badge bg-secondary"><%= request.getAttribute("orderId") %></span></p>
                <% } %>
                <p class="mb-4">Thank you for your order! We'll prepare your food with care.</p>
                <div class="d-flex justify-content-center gap-3 flex-wrap">
                    <a href="orders.jsp" class="btn btn-primary px-4">
                        <i class="bi bi-list-check me-2"></i>View My Orders
                    </a>
                    <a href="menu.jsp" class="btn btn-outline-primary px-4">
                        <i class="bi bi-arrow-left-circle me-2"></i>Continue Shopping
                    </a>
                </div>
            </div>
        <% } %>
        
        <% if (errorMsg != null) { %>
            <div class="alert alert-danger mt-4 text-center">
                <i class="bi bi-exclamation-triangle-fill fs-1 d-block mb-3" style="color: var(--danger-color);"></i>
                <h4 class="fw-bold"><%= errorMsg %></h4>
                <a href="cart.jsp" class="btn btn-outline-danger mt-3">
                    <i class="bi bi-arrow-left-circle me-2"></i>Back to Cart
                </a>
            </div>
        <% } %>
        
        <%-- Only show checkout form if there's no success message --%>
        <% if (successMsg == null) { %>
            <% if (user != null) { 
                if (cartItems != null && !cartItems.isEmpty()) { 
                    int tcost = 0;
                    for (Cart item : cartItems) {
                        tcost += item.getTotal_price();
                    }
            %>
                <div class="checkout-container">
                    <h2 class="checkout-title">Checkout</h2>
                    <div class="customer-info mb-4">
                        <div class="d-flex flex-wrap align-items-center justify-content-between">
                            <div class="mb-2 mb-md-0">
                                <i class="bi bi-person-circle me-2"></i>
                                <strong>Customer:</strong> <%= user.getName() %>
                            </div>
                            <div>
                                <i class="bi bi-envelope me-2"></i>
                                <strong>Email:</strong> <%= user.getEmail() %>
                            </div>
                        </div>
                    </div>
                    
                    <form action="order" method="POST" id="checkoutForm">
                        <h4 class="mb-3">Order Summary</h4>
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Item</th>
                                        <th>Name</th>
                                        <th>Qty</th>
                                        <th>Price</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (Cart item : cartItems) { %>
                                        <tr>
                                            <td>
                                                <img src="<%= item.getFood_image()%>" 
                                                     class="img-fluid rounded" 
                                                     style="height: 60px; width: auto; max-width: 80px; object-fit: cover;" 
                                                     alt="<%= item.getFood_name()%>">
                                            </td>
                                            <td><%= item.getFood_name()%></td>
                                            <td><%= item.getQuantity() %></td>
                                            <td>₹<%= item.getPrice() %></td>
                                            <td>₹<%= item.getTotal_price()%></td>
                                        </tr>
                                    <% } %>
                                </tbody>
                                <tfoot>
                                    <tr class="total-row">
                                        <td colspan="4" class="text-end fw-bold">Grand Total:</td>
                                        <td class="fw-bold">₹<%= tcost %></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>

                        <h4 class="mt-4 mb-3">Delivery Information</h4>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="address" class="form-label">Complete Address</label>
                                <input type="text" class="form-control" id="address" name="address" 
                                       placeholder="House no, Street, Landmark" required>
                            </div>
                            <div class="col-md-3">
                                <label for="city" class="form-label">City</label>
                                <input type="text" class="form-control" id="city" name="city" 
                                       placeholder="Your city" required>
                            </div>
                            <div class="col-md-3">
                                <label for="state" class="form-label">State</label>
                                <input type="text" class="form-control" id="state" name="state" 
                                       placeholder="Your state" required>
                            </div>
                            <div class="col-md-6">
                                <label for="phonenumber" class="form-label">Phone Number</label>
                                <input type="tel" class="form-control" name="phonenumber" 
                                       value="<%=user.getPhone()%>" required>
                            </div>
                            <div class="col-md-6">
                                <label for="payment_method" class="form-label">Payment Method</label>
                                <select class="form-select" name="payment_method" id="payment_method" required>
                                    <option value="" selected disabled>Select payment method</option>
                                    <option value="cash">Cash on Delivery</option>
                                    <option value="phonepay">PhonePe</option>
                                    <option value="card">Credit/Debit Card</option>
                                    <option value="netbanking">Net Banking</option>
                                </select>
                            </div>
                            <input type="hidden" name="uid" value="<%=user.getUserId()%>"/>
                            <input type="hidden" name="tcost" value="<%=tcost%>"/>
                        </div>

                        <div class="d-flex justify-content-between mt-4 flex-wrap gap-3">
                            <a href="cart.jsp" class="btn btn-back flex-grow-1">
                                <i class="bi bi-arrow-left me-2"></i>Back to Cart
                            </a>
                            <button type="submit" name="submit" class="btn btn-confirm flex-grow-1" id="submitBtn">
                                <span id="submitText">Confirm Order</span>
                                <span id="submitSpinner" class="spinner-border spinner-border-sm d-none" role="status" aria-hidden="true"></span>
                            </button>
                        </div>
                    </form>
                </div>
            <% } else { %>
                <div class="checkout-container text-center py-5">
                    <i class="bi bi-cart-x fs-1" style="color: var(--warning-color);"></i>
                    <h3 class="mt-3">Your cart is empty</h3>
                    <p class="text-muted mb-4">Please add items to your cart before proceeding to checkout.</p>
                    <a href="menu.jsp" class="btn btn-primary px-4">
                        <i class="bi bi-arrow-left me-2"></i>Browse Menu
                    </a>
                </div>
            <% } %>
        <% } %>
        
        <% if (!isLoggedIn && successMsg == null && errorMsg == null) { %>
            <div class="checkout-container text-center py-5">
                <i class="bi bi-lock-fill fs-1" style="color: var(--primary-color);"></i>
                <h3 class="mt-3">Please log in to checkout</h3>
                <p class="text-muted mb-4">You need to be logged in to place an order.</p>
                <div class="d-flex justify-content-center gap-3 flex-wrap">
                    <a href="login.jsp" class="btn btn-primary px-4">
                        <i class="bi bi-box-arrow-in-right me-2"></i>Login
                    </a>
                    <a href="signup.jsp" class="btn btn-outline-primary px-4">
                        <i class="bi bi-person-plus me-2"></i>Sign Up
                    </a>
                </div>
            </div>
        <% } %>
    </main>
    
    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-4 text-center text-lg-start">
                    <h5>About Us</h5>
                    <p>Food Delight brings delicious meals to your doorstep with the freshest ingredients and fastest delivery.</p>
                    <img src="Assets/Logo/logo-transparent-png.png" width="180" alt="Logo" class="img-fluid mt-2">
                </div>
                <div class="col-lg-4 text-center">
                    <h5>Quick Links</h5>
                    <div class="d-flex flex-column flex-sm-row justify-content-center gap-3 gap-sm-4">
                        <div>
                            <a href="userhome.jsp" class="footer-link">Home</a>
                            <a href="menu.jsp" class="footer-link">Menu</a>
                            <% if(isLoggedIn) { %>
                                <a href="myorders.jsp" class="footer-link">Orders</a>
                            <% }} %>
                        </div>
                        <div>
                            <a href="about.jsp" class="footer-link">About</a>
                            <a href="contact.jsp" class="footer-link">Contact</a>
                            <a href="faq.jsp" class="footer-link">FAQs</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 text-center text-lg-end">
                    <h5>Follow Us</h5>
                    <div class="mt-3">
                        <a href="#" class="social-icon"><i class="bi bi-facebook"></i></a>
                        <a href="#" class="social-icon"><i class="bi bi-instagram"></i></a>
                        <a href="#" class="social-icon"><i class="bi bi-twitter"></i></a>
                        <a href="#" class="social-icon"><i class="bi bi-youtube"></i></a>
                    </div>
                    <div class="mt-3">
                        <p class="mb-1"><i class="bi bi-telephone me-2"></i> +91 1234567890</p>
                        <p><i class="bi bi-envelope me-2"></i> info@fooddelight.com</p>
                    </div>
                </div>
            </div>
            <hr class="my-4">
            <div class="text-center">
                <p class="mb-0">&copy; 2023 Food Delight. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Form submission spinner
        document.getElementById('checkoutForm')?.addEventListener('submit', function() {
            const submitBtn = document.getElementById('submitBtn');
            const submitText = document.getElementById('submitText');
            const submitSpinner = document.getElementById('submitSpinner');
            
            submitText.textContent = 'Processing...';
            submitSpinner.classList.remove('d-none');
            submitBtn.disabled = true;
        });
        
        // Smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });
    </script>
</body>
</html>