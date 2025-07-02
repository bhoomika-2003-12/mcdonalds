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

// Date formatters
SimpleDateFormat dbDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
SimpleDateFormat displayFormat = new SimpleDateFormat("MMM dd, yyyy hh:mm a");

// Fetch orders from database
UserDao udao = new UserDaoImpli();
ArrayList<Orders> orders = isLoggedIn ? udao.getOrderbyId(user.getUserId()) : new ArrayList<>();
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Delight | My Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin-top: 0;
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

        .order-table {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            overflow: hidden;
        }

        .order-table th {
            background-color: #da291c;
            color: white;
            font-weight: 500;
        }

        .order-table tr:hover {
            background-color: rgba(218, 41, 28, 0.05);
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

        .badge-pending {
            background-color: #ffc107;
            color: #000;
        }

        .badge-delivered {
            background-color: #28a745;
            color: #fff;
        }

        .badge-cancelled {
            background-color: #dc3545;
            color: #fff;
        }

        .badge-processing {
            background-color: #17a2b8;
            color: #fff;
        }

        .order-id-link {
            color: #da291c;
            text-decoration: none;
            font-weight: 500;
        }

        .order-id-link:hover {
            text-decoration: underline;
        }

        .no-orders {
            text-align: center;
            padding: 50px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }

        .no-orders-icon {
            font-size: 5rem;
            color: #6c757d;
            margin-bottom: 20px;
        }
        
        .footer {
            background-color: #f8f9fa;
            padding: 2rem 0;
            margin-top: 2rem;
        }
        
        .social-icon {
            color: #6c757d;
            font-size: 1.5rem;
            margin-left: 10px;
        }
        
        .social-icon:hover {
            color: #da291c;
        }
        
        .footer-link {
            color: #6c757d;
            text-decoration: none;
        }
        
        .footer-link:hover {
            color: #da291c;
            text-decoration: underline;
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
                    <li class="nav-item"><a class="nav-link" href="menu.jsp">Menu</a></li>
                    <li class="nav-item"><a class="nav-link" href="about.jsp">About</a></li>
                    <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
                    
                    <% if(isLoggedIn) { %>
                        <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="navbarDropdown" 
                           role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-person-circle me-1"></i> <c:out value="${user.username}"/>
                            <span class="badge badge-admin ms-2">user</span>
                        </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="profile.jsp"><i class="bi bi-person-fill me-2"></i>Profile</a></li>
                                    <li><a class="dropdown-item" href="myorder.jsp"><i class="bi bi-list-check me-2"></i>My Orders</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li>
                                        <form action="Logout" method="post">
                                            <button type="submit" class="dropdown-item">Logout</button>
                                        </form>
                                    </li>
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
        <div class="row mb-4">
            <div class="col-12">
                <h2 class="fw-bold mb-2"><i class="bi bi-list-check"></i> My Orders</h2>
                <p class="text-muted">View your order history and status</p>
            </div>
        </div>
        
        <% if(orders != null && !orders.isEmpty()) { %>
            <div class="table-responsive order-table">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Date</th>
                            <th>Price</th>
                            <th>Status</th>
                            <th>Payment</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(Orders order : orders) { 
                            String formattedDate = "Date not available";
                            if(order.getOrder_date() != null && !order.getOrder_date().isEmpty()) {
                                try {
                                    java.util.Date orderDate = dbDateFormat.parse(order.getOrder_date());
                                    formattedDate = displayFormat.format(orderDate);
                                } catch (ParseException e) {
                                    log("Error parsing date: " + order.getOrder_date());
                                    formattedDate = order.getOrder_date();
                                }
                            }
                            
                            String statusBadgeClass = "badge-" + order.getOrder_status().toLowerCase();
                        %>
                        <tr>
                            <td>
                                <a href="orderDetails.jsp?order_id=<%= order.getOrder_id()%>&order_status=<%=order.getOrder_status() %>" class="order-id-link">
                                    #<%= order.getOrder_id() %>
                                </a>
                            </td>
                            <td><%= formattedDate %></td>
                            <td>₹<%= String.format("%.2f", order.getTotal_price()) %></td>
                            <td>
                                <span class="badge <%= statusBadgeClass %>">
                                    <i class="bi 
                                        <%= "pending".equalsIgnoreCase(order.getOrder_status()) ? "bi-hourglass" : 
                                           "processing".equalsIgnoreCase(order.getOrder_status()) ? "bi-gear" : 
                                           "delivered".equalsIgnoreCase(order.getOrder_status()) ? "bi-check-circle" : "bi-x-circle" %> 
                                        me-1"></i>
                                    <%= order.getOrder_status() %>
                                </span>
                            </td>
                            <td>
                                <span class="badge bg-light text-dark">
                                    <i class="bi 
                                        <%= "cash".equalsIgnoreCase(order.getPayment_method()) ? "bi-cash-coin" : "bi-credit-card" %> 
                                        me-1"></i>
                                    <%= order.getPayment_method() %>
                                </span>
                            </td>
                            <td>
                                <% if(order.getOrder_status().equalsIgnoreCase("pending")){ %>
                                <div class="btn-group btn-group-sm" role="group">
                                    <form action="updateOrder" method="post">
                                        <input type="hidden" name="order_id" value="<%= order.getOrder_id() %>">
                                        <input type="hidden" name="user_id" value="<%=user.getUserId()%>">
                                        <input type="hidden" name="action" value="Confirm">
                                        <input type="hidden" name="csrfToken" value="<%= session.getAttribute("csrfToken") %>">
                                        <button type="submit" class="btn btn-success btn-sm">
                                            <i class="bi bi-check-lg me-1"></i> Confirm
                                        </button>
                                    </form>
                                    <form action="updateOrder" method="post">
                                        <input type="hidden" name="order_id" value="<%= order.getOrder_id() %>">
                                        <input type="hidden" name="user_id" value="<%=user.getUserId()%>">
                                        <input type="hidden" name="action" value="cancelled">
                                        <input type="hidden" name="csrfToken" value="<%= session.getAttribute("csrfToken") %>">
                                        <button type="submit" class="btn btn-danger btn-sm">
                                            <i class="bi bi-x-lg me-1"></i> Cancel
                                        </button>
                                    </form>
                                </div>
                                <% } else if (order.getOrder_status().equalsIgnoreCase("processing")) { %>
                                    <span class="badge bg-info text-white">
                                        <i class="bi bi-arrow-repeat me-1"></i> In Progress
                                    </span>
                                <% } else { %>
                                    <span class="text-muted">No actions</span>
                                <% } %>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } else { %>
            <div class="no-orders">
                <div class="no-orders-icon">
                    <i class="bi bi-cart-x"></i>
                </div>
                <h4 class="mb-3">No Orders Found</h4>
                <p class="text-muted mb-4">You haven't placed any orders yet.</p>
                <a href="menu.jsp" class="btn btn-primary">
                    <i class="bi bi-arrow-right me-1"></i> Browse Menu
                </a>
            </div>
        <% } %>
    </main>

    <!-- Footer -->
    <footer class="footer py-4">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <h5>About Us</h5>
                    <p>Food Delight is your go-to platform for delicious meals, offering a wide variety of dishes crafted with love.</p>
                </div>
                <div class="col-md-4">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="userhome.jsp" class="footer-link">Home</a></li>
                        <li><a href="menu.jsp" class="footer-link">Menu</a></li>
                        <% if(isLoggedIn) { %>
                            <li><a href="myorder.jsp" class="footer-link">My Orders</a></li>
                        <% } %>
                        <li><a href="about.jsp" class="footer-link">About</a></li>
                        <li><a href="contact.jsp" class="footer-link">Contact</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
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