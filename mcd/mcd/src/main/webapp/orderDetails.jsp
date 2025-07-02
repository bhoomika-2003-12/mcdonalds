<%@page import="com.mcd.models.Dto.OrderItems"%>
<%@page import="com.mcd.models.Dao.UserDaoImpli"%>
<%@page import="com.mcd.models.Dao.UserDao"%>
<%@page import="com.mcd.models.Dto.Orders"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.ParseException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mcd.models.Dto.User" %>
<%@ page import="java.util.ArrayList" %>

<%
// Check if user is logged in
User user = (User) session.getAttribute("pass");
boolean isLoggedIn = user != null;
String username = isLoggedIn ? user.getName() : "Guest";
String orderId=(String)request.getParameter("order_id");
String orderStatus=(String)request.getParameter("order_status");

// Date formatters
SimpleDateFormat dbDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
SimpleDateFormat displayFormat = new SimpleDateFormat("MMM dd, yyyy hh:mm a");

// Fetch orders from database
UserDao udao = new UserDaoImpli();

ArrayList<OrderItems> orders = isLoggedIn ? udao.getOrderItemsById(Integer.parseInt(orderId)) : new ArrayList<>();

%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Delight | Order Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #ff6b6b;
            --secondary-color: #ffa502;
            --accent-color: #1dd1a1;
            --dark-color: #2f3542;
            --light-color: #f1f2f6;
            --shadow: 0 10px 20px rgba(0,0,0,0.1);
            --transition: all 0.3s ease;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f9f9f9;
            color: #333;
            margin: 0;
            padding: 0;
            line-height: 1.6;
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
        
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            transition: var(--transition);
        }
        
        .btn-primary:hover {
            background-color: #ff5252;
            border-color: #ff5252;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.3);
        }
        
        .btn-outline-primary {
            color: var(--primary-color);
            border-color: var(--primary-color);
            transition: var(--transition);
        }
        
        .btn-outline-primary:hover {
            background-color: var(--primary-color);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.3);
        }
        
        .order-container {
            background: white;
            border-radius: 15px;
            box-shadow: var(--shadow);
            overflow: hidden;
            margin-bottom: 30px;
            transition: var(--transition);
            border: none;
        }
        
        .order-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }
        
        .order-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 20px;
            border-radius: 15px 15px 0 0;
        }
        
        .order-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 15px;
        }
        
        .order-table thead th {
            background-color: transparent;
            color: var(--dark-color);
            font-weight: 600;
            padding: 15px;
            border-bottom: 2px solid #eee;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
        }
        
        .order-table tbody tr {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: var(--transition);
            margin-bottom: 15px;
        }
        
        .order-table tbody tr:hover {
            transform: translateX(5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        
        .order-table td {
            padding: 15px;
            vertical-align: middle;
            border-top: none;
            position: relative;
        }
        
        .order-table td:first-child {
            border-radius: 10px 0 0 10px;
        }
        
        .order-table td:last-child {
            border-radius: 0 10px 10px 0;
        }
        
        .food-img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: var(--transition);
        }
        
        .food-img:hover {
            transform: scale(1.1);
        }
        
        .food-name {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 5px;
        }
        
        .food-category {
            font-size: 0.8rem;
            color: #777;
        }
        
        .quantity-badge {
            display: inline-block;
            padding: 5px 12px;
            background: linear-gradient(135deg, #f6e58d 0%, #ffbe76 100%);
            border-radius: 20px;
            font-weight: 600;
            color: #333;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .price {
            font-weight: 600;
            color: var(--dark-color);
        }
        
        .total-price {
            font-weight: 700;
            color: var(--primary-color);
            font-size: 1.1rem;
        }
        
        .order-summary {
            background: linear-gradient(135deg, #f9f9f9 0%, #f1f2f6 100%);
            border-radius: 10px;
            padding: 25px;
            box-shadow: var(--shadow);
            margin-top: 30px;
        }
        
        .order-summary-title {
            font-weight: 700;
            color: var(--dark-color);
            border-bottom: 2px dashed #ddd;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        
        .order-summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }
        
        .order-summary-label {
            color: #666;
            font-weight: 500;
        }
        
        .order-summary-value {
            font-weight: 600;
            color: var(--dark-color);
        }
        
        .grand-total {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-top: 20px;
            padding-top: 15px;
            border-top: 2px dashed #ddd;
        }
        
        .no-orders {
            text-align: center;
            padding: 50px;
            background: white;
            border-radius: 15px;
            box-shadow: var(--shadow);
            margin: 50px 0;
        }
        
        .no-orders-icon {
            font-size: 5rem;
            color: #ddd;
            margin-bottom: 20px;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }
        
        .order-status {
            display: inline-block;
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .status-pending {
            background: #fff3cd;
            color: #856404;
        }
        
        .status-delivered {
            background: #d4edda;
            color: #155724;
        }
        
        .status-cancelled {
            background: #f8d7da;
            color: #721c24;
        }
        
        .status-processing {
            background: #cce5ff;
            color: #004085;
        }
        
        .floating-action-btn {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: var(--primary-color);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 5px 20px rgba(255, 107, 107, 0.4);
            z-index: 1000;
            transition: var(--transition);
            border: none;
        }
        
        .floating-action-btn:hover {
            transform: translateY(-5px) scale(1.1);
            background: #ff5252;
        }
        
        .footer {
            background: var(--dark-color);
            color: white;
            padding: 50px 0 20px;
        }
        
        .footer a {
            color: #ddd;
            transition: var(--transition);
        }
        
        .footer a:hover {
            color: white;
            text-decoration: none;
        }
        
        .social-icon {
            display: inline-block;
            width: 40px;
            height: 40px;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
            text-align: center;
            line-height: 40px;
            margin-left: 10px;
            transition: var(--transition);
        }
        
        .social-icon:hover {
            background: var(--primary-color);
            transform: translateY(-3px);
        }
        
        /* Responsive styles */
        @media (max-width: 768px) {
            .order-table thead {
                display: none;
            }
            
            .order-table tr {
                display: block;
                margin-bottom: 20px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                border-radius: 10px;
            }
            
            .order-table td {
                display: flex;
                justify-content: space-between;
                align-items: center;
                text-align: right;
                padding: 12px 15px;
                border-bottom: 1px solid #eee;
            }
            
            .order-table td::before {
                content: attr(data-label);
                font-weight: 600;
                margin-right: auto;
                padding-right: 10px;
                text-align: left;
                color: #777;
            }
            
            .order-table td:first-child {
                border-radius: 10px 10px 0 0;
            }
            
            .order-table td:last-child {
                border-bottom: none;
                border-radius: 0 0 10px 10px;
            }
            
            .food-img {
                width: 60px;
                height: 60px;
            }
            
            .order-summary {
                margin-top: 20px;
            }
            
            .order-header {
                padding: 15px;
            }
            
            .order-header h4 {
                font-size: 1.2rem;
            }
            
            .order-status {
                font-size: 0.7rem;
                padding: 4px 10px;
            }
        }
        
        @media (max-width: 576px) {
            .navbar-brand img {
                width: 150px;
            }
            
            .order-container {
                border-radius: 10px;
            }
            
            .food-img {
                width: 50px;
                height: 50px;
            }
            
            .quantity-badge {
                padding: 3px 8px;
                font-size: 0.8rem;
            }
            
            .price, .total-price {
                font-size: 0.9rem;
            }
            
            .order-summary {
                padding: 15px;
            }
        }
    </style>
</head>

<body>
        <!-- Header Section -->
    <header class="navbar navbar-expand-lg navbar-light fixed-top shadow">
        <div class="container">
            <!-- LOGO -->
            <a class="navbar-brand" href="adminhome.jsp">
                <img src="https://logos-world.net/wp-content/uploads/2020/04/McDonalds-Logo-700x394.png" alt="Food Delight Logo" height="40">
            </a>

            <!-- Mobile Toggle -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" 
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Navbar Items -->
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item">
                        <a class="nav-link active" href="adminhome.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="foods.jsp">Foods</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="AdminOrder.jsp">Orders</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="alluser.jsp">Customers</a>
                    </li>
                    
                    <!-- Admin Dropdown -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="navbarDropdown" 
                           role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-person-circle me-1"></i> <c:out value="${user.username}"/>
                            <span class="badge badge-admin ms-1"><%=user.getName() %></span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="profile.jsp"><i class="bi bi-person me-2"></i>Profile</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <form action="Logout" method="post">
                                    <input type="hidden" name="csrfToken" value="<%= session.getAttribute("csrfToken") %>">
                                    <button type="submit" class="dropdown-item"><i class="bi bi-box-arrow-right me-2"></i>Logout</button>
                                </form>
                            </li>
                        </ul>
                    </li>
                    
                    <!-- Theme Toggle -->
                    <li class="nav-item ms-2">
                        <button id="themeToggle" class="btn theme-toggle-btn">
                            <i id="themeIcon" class="bi bi-moon-fill"></i>
                        </button>
                    </li>
                </ul>
            </div>
        </div>
    </header>
    
    <main class="container my-5 pt-4">
        <div class="d-flex justify-content-between align-items-center mb-4 animate__animated animate__fadeIn">
            <div>
                <h2 class="mb-0 fw-bold">Order Details</h2>
                <p class="text-muted mb-0">Order ID: <%= orderId %></p>
            </div>
        </div>

        <% if(isLoggedIn) { %>
            <% if(orders != null && !orders.isEmpty()) { %>
                <div class="order-container animate__animated animate__fadeInUp">
                    <div class="order-header">
                        <div class="row align-items-center">
                            <div class="col-md-6">
                                <h4 class="mb-0 text-white"><i class="bi bi-receipt me-2"></i>Order Summary</h4>
                            </div>
                            <div class="col-md-6 text-md-end">
                                <span class="order-status status-delivered">
                                    <i class="bi bi-check-circle me-1"></i><%=orderStatus%>
                                </span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="p-4">
                        <div class="table-responsive">
                            <table class="table order-table">
                                <thead>
                                    <tr>
                                        <th>Item</th>
                                        <th>Details</th>
                                        <th>Quantity</th>
                                        <th>Unit Price</th>
                                        <th>Total</th>
                                        
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                    double grandTotal = 0;
                                    for(OrderItems order : orders) { 
                                        grandTotal += order.getTotalPrice();
                                    %>
                                    <tr class="animate__animated animate__fadeIn">
                                        <td data-label="Item">
                                            <img src="<%= order.getFood_image() %>" alt="<%= order.getFood_name() %>" class="food-img">
                                        </td>
                                        <td data-label="Details">
                                            <div class="food-name"><%= order.getFood_name() %></div>
                                            <div class="food-category">Category</div>
                                        </td>
                                        <td data-label="Quantity">
                                            <span class="quantity-badge"><%= order.getQuantity() %></span>
                                        </td>
                                        <td data-label="Unit Price" class="price">₹<%= String.format("%.2f", order.getTotalPrice()/order.getQuantity()) %></td>
                                        <td data-label="Total" class="total-price">₹<%= String.format("%.2f", order.getTotalPrice()) %></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>

                        <div class="row mt-4">
                            <div class="col-12">
                                <div class="order-summary">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h5 class="order-summary-title mb-0"><i class="bi bi-receipt me-2"></i>Order Total</h5>
                                        <span class="grand-total">₹<%= String.format("%.2f", grandTotal) %></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <% } else { %>
                <div class="no-orders animate__animated animate__fadeIn">
                    <div class="no-orders-icon">
                        <i class="bi bi-cart-x"></i>
                    </div>
                    <h4 class="mb-3">No Orders Found</h4>
                    <p class="text-muted mb-4">You haven't placed any orders yet.</p>
                    <a href="menu.jsp" class="btn btn-primary btn-lg">
                        <i class="bi bi-utensils me-2"></i>Browse Menu
                    </a>
                </div>
            <% } %>
        <% } else { %>
            <div class="alert alert-warning animate__animated animate__fadeIn">
                <div class="d-flex align-items-center">
                    <i class="bi bi-exclamation-triangle-fill me-3 fs-4"></i>
                    <div>
                        <h4 class="mb-2">Please log in to view your orders</h4>
                        <p class="mb-0">You need to be logged in to see your order history.</p>
                    </div>
                </div>
                <div class="mt-3">
                    <a href="login.jsp" class="btn btn-primary me-2">Login</a>
                    <a href="signup.jsp" class="btn btn-outline-primary">Sign Up</a>
                </div>
            </div>
        <% } %>
    </main>
    
    <!-- Floating Action Button -->
    <button class="floating-action-btn animate__animated animate__fadeInUp">
        <i class="bi bi-headset fs-4"></i>
    </button>
    
    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 mb-4 mb-lg-0">
                    <h5 class="text-white mb-4">About Food Delight</h5>
                    <p>Bringing delicious meals to your doorstep with love and care. Our mission is to make every dining experience special.</p>
                    <div class="mt-4">
                        <img src="Assets/Logo/logo-transparent-png.png" width="180" alt="Logo" class="img-fluid">
                    </div>
                </div>
                <div class="col-lg-2 col-md-6 mb-4 mb-md-0">
                    <h5 class="text-white mb-4">Quick Links</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="userhome.jsp"><i class="bi bi-chevron-right me-1"></i> Home</a></li>
                        <li class="mb-2"><a href="menu.jsp"><i class="bi bi-chevron-right me-1"></i> Menu</a></li>
                        <% if(isLoggedIn) { %>
                            <li class="mb-2"><a href="myorders.jsp"><i class="bi bi-chevron-right me-1"></i> Orders</a></li>
                        <% } %>
                        <li class="mb-2"><a href="about.jsp"><i class="bi bi-chevron-right me-1"></i> About</a></li>
                        <li class="mb-2"><a href="contact.jsp"><i class="bi bi-chevron-right me-1"></i> Contact</a></li>
                    </ul>
                </div>
                <div class="col-lg-2 col-md-6 mb-4 mb-md-0">
                    <h5 class="text-white mb-4">Our Menu</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="#"><i class="bi bi-chevron-right me-1"></i> Burgers</a></li>
                        <li class="mb-2"><a href="#"><i class="bi bi-chevron-right me-1"></i> Pizzas</a></li>
                        <li class="mb-2"><a href="#"><i class="bi bi-chevron-right me-1"></i> Desserts</a></li>
                        <li class="mb-2"><a href="#"><i class="bi bi-chevron-right me-1"></i> Beverages</a></li>
                        <li class="mb-2"><a href="#"><i class="bi bi-chevron-right me-1"></i> Specials</a></li>
                    </ul>
                </div>
                <div class="col-lg-4">
                    <h5 class="text-white mb-4">Connect With Us</h5>
                    <p>Follow us on social media for the latest updates and offers.</p>
                    <div class="mt-4">
                        <a href="#" class="social-icon"><i class="bi bi-facebook"></i></a>
                        <a href="#" class="social-icon"><i class="bi bi-instagram"></i></a>
                        <a href="#" class="social-icon"><i class="bi bi-twitter"></i></a>
                        <a href="#" class="social-icon"><i class="bi bi-youtube"></i></a>
                    </div>
                    <div class="mt-4">
                        <h6 class="text-white mb-3">Download Our App</h6>
                        <div class="d-flex">
                            <a href="#" class="me-2">
                                <img src="https://via.placeholder.com/120x40?text=App+Store" alt="App Store" class="img-fluid" style="height: 40px;">
                            </a>
                            <a href="#">
                                <img src="https://via.placeholder.com/120x40?text=Play+Store" alt="Play Store" class="img-fluid" style="height: 40px;">
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <hr class="mt-4 mb-3" style="border-color: rgba(255,255,255,0.1);">
            <div class="row">
                <div class="col-md-6 text-center text-md-start">
                    <p class="mb-0">&copy; 2023 Food Delight. All rights reserved.</p>
                </div>
                <div class="col-md-6 text-center text-md-end">
                    <p class="mb-0">
                        <a href="#" class="text-white me-3">Privacy Policy</a>
                        <a href="#" class="text-white">Terms of Service</a>
                    </p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Animation for elements when they come into view
        document.addEventListener('DOMContentLoaded', function() {
            const animateElements = document.querySelectorAll('.order-table tbody tr, .order-summary');
            
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('animate__fadeInUp');
                        observer.unobserve(entry.target);
                    }
                });
            }, {
                threshold: 0.1
            });
            
            animateElements.forEach(element => {
                observer.observe(element);
            });
            
            // Floating action button click handler
            document.querySelector('.floating-action-btn').addEventListener('click', function() {
                alert('Customer support will be with you shortly!');
            });
        });
    </script>
</body>
</html>