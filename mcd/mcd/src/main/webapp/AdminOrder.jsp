<%@page import="com.mcd.models.Dao.UserDaoImpli"%>
<%@page import="com.mcd.models.Dao.UserDao"%>
<%@page import="com.mcd.models.Dto.Orders"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.ParseException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mcd.models.Dto.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
// Check if user is logged in and is admin
User user = (User) session.getAttribute("pass");

// Date formatters
SimpleDateFormat dbDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
SimpleDateFormat displayFormat = new SimpleDateFormat("MMM dd, yyyy hh:mm a");

// Fetch orders from database
UserDao udao = new UserDaoImpli();
ArrayList<Orders> orders = udao.getAllOrder();

// Generate CSRF token if not exists
if (session.getAttribute("csrfToken") == null) {
    session.setAttribute("csrfToken", java.util.UUID.randomUUID().toString());
}
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>McDonalds | Order Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #da291c;
            --secondary-color: #ffbc0d;
            --dark-color: #27251f;
            --light-color: #f8f9fa;
            --success-color: #28a745;
            --warning-color: #ffc107;
            --danger-color: #dc3545;
            --info-color: #17a2b8;
            --shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--light-color);
            color: var(--dark-color);
            padding-top: 70px;
            transition: var(--transition);
        }

        /* Navbar Styles */
        .navbar {
            background-color: white !important;
            box-shadow: var(--shadow);
            padding: 15px 0;
            transition: var(--transition);
        }

        .navbar-brand img {
            height: 40px;
            transition: var(--transition);
        }

        .navbar-brand:hover img {
            transform: scale(1.05);
        }

        .nav-link {
            font-weight: 500;
            color: var(--dark-color) !important;
            padding: 8px 15px;
            border-radius: 5px;
            transition: var(--transition);
            margin: 0 5px;
        }

        .nav-link:hover, .nav-link.active {
            color: var(--primary-color) !important;
            background-color: rgba(218, 41, 28, 0.1);
        }

        /* Badge Styles */
        .badge {
            font-weight: 500;
            padding: 0.5em 0.75em;
            border-radius: 20px;
            font-size: 0.85em;
        }

        .badge-admin {
            background-color: var(--primary-color);
            color: white;
        }

        .badge-pending {
            background-color: var(--warning-color);
            color: var(--dark-color);
        }

        .badge-processing {
            background-color: var(--info-color);
            color: white;
        }

        .badge-delivered {
            background-color: var(--success-color);
            color: white;
        }

        .badge-cancelled {
            background-color: var(--danger-color);
            color: white;
        }

        /* Table Styles */
        .order-table {
            background-color: white;
            border-radius: 10px;
            box-shadow: var(--shadow);
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .order-table th {
            background-color: var(--primary-color);
            color: white;
            font-weight: 600;
            padding: 15px;
            border: none;
        }

        .order-table td {
            vertical-align: middle;
            padding: 12px 15px;
        }

        .order-table tr {
            transition: var(--transition);
        }

        .order-table tr:hover {
            background-color: rgba(218, 41, 28, 0.05);
        }

        /* Link Styles */
        .order-id-link {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            transition: var(--transition);
        }

        .order-id-link:hover {
            color: #b82218;
            text-decoration: underline;
        }

        /* No Orders Styles */
        .no-orders {
            text-align: center;
            padding: 50px;
            background-color: white;
            border-radius: 10px;
            box-shadow: var(--shadow);
            margin: 2rem 0;
        }

        .no-orders-icon {
            font-size: 5rem;
            color: #6c757d;
            margin-bottom: 20px;
        }

        /* Filter Section */
        .filter-section {
            background-color: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 25px;
            box-shadow: var(--shadow);
        }

        /* Footer Styles */
        .footer {
            background-color: var(--dark-color);
            color: white;
            padding: 40px 0 20px;
        }

        .footer h5 {
            color: var(--secondary-color);
            margin-bottom: 20px;
            font-weight: 600;
        }

        .footer-link {
            color: #ddd;
            text-decoration: none;
            transition: var(--transition);
            display: block;
            margin-bottom: 10px;
        }

        .footer-link:hover {
            color: var(--secondary-color);
            transform: translateX(5px);
        }

        .social-icon {
            color: white;
            font-size: 1.5rem;
            margin-left: 15px;
            transition: var(--transition);
        }

        .social-icon:hover {
            color: var(--secondary-color);
            transform: translateY(-3px);
        }

        /* Responsive Adjustments */
        @media (max-width: 991px) {
            .navbar-brand img {
                height: 35px;
            }
            
            .order-table th, 
            .order-table td {
                padding: 10px;
                font-size: 0.9rem;
            }
            
            .badge {
                padding: 0.4em 0.6em;
                font-size: 0.8rem;
            }
        }

        @media (max-width: 767px) {
            body {
                padding-top: 60px;
            }
            
            .order-table {
                display: block;
                width: 100%;
                overflow-x: auto;
                -webkit-overflow-scrolling: touch;
            }
            
            .btn-group {
                flex-direction: column;
                gap: 5px;
            }
            
            .btn-group .btn {
                width: 100%;
            }
            
            .footer .col-md-4 {
                margin-bottom: 30px;
                text-align: center !important;
            }
            
            .social-icon {
                margin: 0 10px;
            }
        }

        @media (max-width: 575px) {
            .no-orders {
                padding: 30px 15px;
            }
            
            .no-orders-icon {
                font-size: 3.5rem;
            }
            
            .filter-section {
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
                <img src="https://logos-world.net/wp-content/uploads/2020/04/McDonalds-Logo-700x394.png" alt="McDonalds Logo" height="40">
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
                        <a class="nav-link" href="adminhome.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="foods.jsp">Foods</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="AdminOrder.jsp">Orders</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="alluser.jsp">Customers</a>
                    </li>
                    
                    <!-- Admin Dropdown -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="navbarDropdown" 
                           role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-person-circle me-1"></i> <c:out value="${user.username}"/>
                            <span class="badge badge-admin ms-2">Admin</span>
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

    <!-- Main Content -->
    <main class="container my-4">
        <div class="row mb-4">
            <div class="col-12 col-md-6">
                <h2 class="fw-bold mb-2"><i class="bi bi-cart-check"></i> Order Management</h2>
                <p class="text-muted">View and manage all customer orders</p>
            </div>
        </div>
        
        
        
        <% if(orders != null && !orders.isEmpty()) { %>
            <div class="table-responsive order-table">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>User ID</th>
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
                            <td>
                                <a href="alluser.jsp?userId=<%=order.getUser_id()%>" class="order-id-link">
                                    <%=order.getUser_id() %>
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
                                        <input type="hidden" name="user_id" value="<%=user.getUserId()%>"/>
                                        <input type="hidden" name="action" value="Confirm">
                                        <input type="hidden" name="csrfToken" value="<%= session.getAttribute("csrfToken") %>">
                                        <button type="submit" class="btn btn-success btn-sm">
                                            <i class="bi bi-check-lg me-1"></i> Confirm
                                        </button>
                                    </form>
                                    <form action="updateOrder" method="post">
                                        <input type="hidden" name="order_id" value="<%= order.getOrder_id() %>">
                                        <input type="hidden" name="user_id" value="<%=user.getUserId()%>"/>
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
                <p class="text-muted mb-4">There are currently no orders in the system.</p>
                <a href="foods.jsp" class="btn btn-primary">
                    <i class="bi bi-plus-lg me-1"></i> Add New Food Items
                </a>
            </div>
        <% } %>
    </main>

    <!-- Footer -->
    <footer class="footer py-4">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-4 mb-md-0">
                    <h5>McDonalds Admin</h5>
                    <p>Powerful restaurant management system to streamline your operations and boost efficiency.</p>
                </div>
                <div class="col-md-4 mb-4 mb-md-0 text-center">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="adminhome.jsp" class="footer-link">Dashboard</a></li>
                        <li><a href="foods.jsp" class="footer-link">Menu Management</a></li>
                        <li><a href="AdminOrder.jsp" class="footer-link">Order Management</a></li>
                        <li><a href="alluser.jsp" class="footer-link">Customer Management</a></li>
                    </ul>
                </div>
                <div class="col-md-4 text-center text-md-end">
                    <h5>Connect With Us</h5>
                    <a href="#" class="social-icon"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="social-icon"><i class="bi bi-instagram"></i></a>
                    <a href="#" class="social-icon"><i class="bi bi-twitter"></i></a>
                    <a href="#" class="social-icon"><i class="bi bi-linkedin"></i></a>
                </div>
            </div>
            <div class="text-center mt-4">
                <p class="mb-0">&copy; 2023 McDonalds. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Theme toggle functionality
        const themeToggle = document.getElementById('themeToggle');
        const themeIcon = document.getElementById('themeIcon');
        const body = document.body;
        
        // Check for saved theme preference or use preferred color scheme
        const savedTheme = localStorage.getItem('theme') || 
                         (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
        
        // Apply the saved theme
        if (savedTheme === 'dark') {
            body.classList.add('dark-mode');
            themeIcon.classList.replace('bi-moon-fill', 'bi-sun-fill');
        }
        
        // Toggle theme on button click
        themeToggle.addEventListener('click', () => {
            body.classList.toggle('dark-mode');
            
            if (body.classList.contains('dark-mode')) {
                themeIcon.classList.replace('bi-moon-fill', 'bi-sun-fill');
                localStorage.setItem('theme', 'dark');
            } else {
                themeIcon.classList.replace('bi-sun-fill', 'bi-moon-fill');
                localStorage.setItem('theme', 'light');
            }
        });
    </script>
</body>
</html>