<%@page import="com.mcd.models.Dao.AdminDaoImpli"%>
<%@page import="com.mcd.models.Dao.AdminDao"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mcd.models.Dto.User"%>

<%
// Initialize DAO
AdminDao adao = new AdminDaoImpli();

// Check if search form was submitted
String searchId = request.getParameter("userId");
ArrayList<User> usersToDisplay = null;
User singleUser = null;
String errorMessage = null;

if (searchId != null && !searchId.trim().isEmpty()) {
    // SEARCH BY ID MODE
    try {
        int userId = Integer.parseInt(searchId);
        singleUser = adao.getUser(userId);
        if (singleUser == null) {
            errorMessage = "No user found with ID: " + userId;
        }
    } catch (NumberFormatException e) {
        errorMessage = "Please enter a valid numeric ID";
    }
} else {
    // SHOW ALL USERS MODE
    usersToDisplay = adao.getAllUser();
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Delight | Customers</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #e63946;
            --primary-light: #ff6b7b;
            --primary-dark: #c1121f;
            --dark-color: #1d3557;
            --light-color: #f8f9fa;
        }
        
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            color: #333;
            padding-top: 60px;
        }
        
        /* Navbar */
        .navbar {
            background-color: #fff !important;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .navbar-brand img {
            height: 40px;
        }
        
        /* Main Content */
        .user-list {
            padding: 2rem 0;
        }
        
        .page-title {
            font-weight: 700;
            margin-bottom: 2rem;
            color: var(--primary-color);
        }
        
        /* Search Box */
        .search-container {
            max-width: 500px;
            margin: 0 auto 2rem;
        }
        
        /* Table Styling */
        .table-responsive {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
        }
        
        .table {
            margin-bottom: 0;
        }
        
        .table thead {
            background-color: var(--primary-color);
            color: white;
        }
        
        .table th {
            font-weight: 600;
            padding: 1rem;
        }
        
        .table td {
            vertical-align: middle;
            padding: 0.75rem 1rem;
        }
        
        /* Responsive table cells */
        .table td:before {
            content: attr(data-label);
            font-weight: bold;
            display: none;
        }
        
        /* Action Buttons */
        .btn-action {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }
        
        /* Alert Messages */
        .alert-message {
            padding: 0.75rem 1.25rem;
            margin-bottom: 1rem;
            border-radius: 0.25rem;
        }
        
        .alert-success {
            background-color: #d4edda;
            color: #155724;
        }
        
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
        }
        
        /* Footer */
        .footer {
            background-color: #fff;
            padding: 2rem 0;
            margin-top: 3rem;
            border-top: 1px solid rgba(0,0,0,0.1);
        }
        
        .footer h5 {
            font-weight: 600;
            margin-bottom: 1rem;
        }
        
        .footer-link {
            color: #6c757d;
            text-decoration: none;
            transition: color 0.2s;
        }
        
        .footer-link:hover {
            color: var(--primary-color);
        }
        
        .social-icon {
            color: #6c757d;
            font-size: 1.25rem;
            margin-right: 1rem;
            transition: color 0.2s;
        }
        
        .social-icon:hover {
            color: var(--primary-color);
        }
        
        /* Dark Mode */
        body.dark-mode {
            background-color: #121212;
            color: #e0e0e0;
        }
        
        body.dark-mode .navbar,
        body.dark-mode .footer {
            background-color: #1e1e1e !important;
            color: #e0e0e0;
        }
        
        body.dark-mode .table {
            background-color: #1e1e1e;
            color: #e0e0e0;
        }
        
        body.dark-mode .table thead {
            background-color: var(--primary-dark);
        }
        
        body.dark-mode .footer-link,
        body.dark-mode .social-icon {
            color: #aaa;
        }
        
        body.dark-mode .footer-link:hover,
        body.dark-mode .social-icon:hover {
            color: var(--primary-light);
        }
        
        /* No results message */
        .no-results {
            text-align: center;
            padding: 2rem;
            color: #6c757d;
        }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            /* Stack navbar items */
            .navbar-nav {
                padding-top: 1rem;
            }
            
            .nav-item {
                margin-bottom: 0.5rem;
            }
            
            /* Adjust search form */
            .search-container {
                padding: 0 15px;
            }
            
            .input-group {
                flex-direction: column;
            }
            
            .input-group input,
            .input-group button,
            .input-group a {
                width: 100%;
                margin-bottom: 0.5rem;
            }
            
            /* Make table responsive */
            .table-responsive {
                overflow-x: auto;
                -webkit-overflow-scrolling: touch;
            }
            
            /* Stack footer columns */
            .footer .col-md-4 {
                margin-bottom: 2rem;
                text-align: center !important;
            }
            
            /* Adjust table for small screens */
            @media (max-width: 576px) {
                .table thead {
                    display: none;
                }
                
                .table tr {
                    display: block;
                    margin-bottom: 1rem;
                    border: 1px solid #dee2e6;
                    border-radius: 0.25rem;
                }
                
                .table td {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    border-bottom: 1px solid #dee2e6;
                }
                
                .table td:before {
                    display: inline-block;
                    margin-right: 1rem;
                }
                
                .table td:last-child {
                    border-bottom: none;
                }
                
                body.dark-mode .table tr {
                    border-color: #444;
                }
                
                body.dark-mode .table td {
                    border-color: #444;
                }
                
                /* Add data labels for responsive table */
                .table td[data-label]::before {
                    content: attr(data-label) ": ";
                    font-weight: bold;
                }
            }
        }
    </style>
</head>
<body>
    <!-- Header Section -->
    <header class="navbar navbar-expand-lg navbar-light fixed-top shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold" href="adminhome.jsp">
                <img src="https://logos-world.net/wp-content/uploads/2020/04/McDonalds-Logo-700x394.png" alt="Food Delight Logo">
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto d-flex align-items-center">
                    <li class="nav-item mx-2"><a class="nav-link" href="adminhome.jsp">Home</a></li>
                    <li class="nav-item mx-2"><a class="nav-link" href="foods.html">Foods</a></li>
                    <li class="nav-item mx-2"><a class="nav-link" href="adminComplaint.jsp">Queries</a></li>
                    <li class="nav-item mx-2"><a class="nav-link" href="AdminOrder.jsp">Orders</a></li>
                    <li class="nav-item mx-2"><a class="nav-link active" href="alluser.jsp">Customers</a></li>
                    
                    <li class="nav-item mx-2">
                        <button id="themeToggle" class="btn theme-toggle-btn" aria-label="Toggle dark mode">
                            <i id="themeIcon" class="bi bi-moon-fill"></i>
                        </button>
                    </li>
                    
                    <li class="nav-item mx-2">
                        <form action="Logout" method="post">
                                    <button type="submit" class="dropdown-item">Logout</button>
                                </form>
                    </li>
                </ul>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="container user-list">
        <h1 class="text-center page-title">Customer Details</h1>
        
        <% if (errorMessage != null) { %>
            <div class="alert alert-danger"><%= errorMessage %></div>
        <% } %>
        
        <!-- Search Form -->
        <div class="search-container">
            <form class="input-group mb-4" method="GET">
                <input type="number" name="userId" class="form-control" 
                       placeholder="Enter user ID" 
                       value="<%= searchId != null ? searchId : "" %>"
                       aria-label="User ID">
                <button class="btn btn-primary" type="submit">
                    <i class="bi bi-search"></i> <span class="d-none d-md-inline">Search</span>
                </button>
                <a href="alluser.jsp" class="btn btn-outline-secondary">Show All</a>
            </form>
        </div>
        
        <!-- Users Table -->
        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Date of Birth</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (searchId != null && !searchId.trim().isEmpty()) { 
                        // SEARCH RESULT MODE
                        if (singleUser != null) { %>
                            <tr>
                                <td data-label="ID"><%= singleUser.getUserId() %></td>
                                <td data-label="Name"><%= singleUser.getName() %></td>
                                <td data-label="Email"><%= singleUser.getEmail() %></td>
                                <td data-label="Phone"><%= singleUser.getPhone() %></td>
                                <td data-label="DOB"><%= singleUser.getDob() != null ? singleUser.getDob() : "N/A" %></td>
                                <td data-label="Actions">
                                    <form action="deleteuser" method="POST" onsubmit="return confirm('Delete this user?')">
                                        <input type="hidden" name="userId" value="<%= singleUser.getUserId() %>">
                                        <button type="submit" class="btn btn-danger btn-sm">
                                            <i class="bi bi-trash"></i> <span class="d-none d-sm-inline">Delete</span>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    <% } else { 
                        // ALL USERS MODE
                        if (usersToDisplay != null && !usersToDisplay.isEmpty()) {
                            for (User user : usersToDisplay) { %>
                                <tr>
                                    <td data-label="ID"><%= user.getUserId() %></td>
                                    <td data-label="Name"><%= user.getName() %></td>
                                    <td data-label="Email"><%= user.getEmail() %></td>
                                    <td data-label="Phone"><%= user.getPhone() %></td>
                                    <td data-label="DOB"><%= user.getDob() != null ? user.getDob() : "N/A" %></td>
                                    <td data-label="Actions">
                                        <form action="deleteuser" method="POST" onsubmit="return confirm('Delete this user?')">
                                            <input type="hidden" name="userId" value="<%= user.getUserId() %>">
                                            <button type="submit" class="btn btn-danger btn-sm">
                                                <i class="bi bi-trash"></i> <span class="d-none d-sm-inline">Delete</span>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            <% } 
                        } else { %>
                            <tr>
                                <td colspan="6" class="text-center py-4">No users found</td>
                            </tr>
                        <% } 
                    } %>
                </tbody>
            </table>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-4">
                    <h5>About Us</h5>
                    <p>Food Delight is your go-to platform for delicious meals, offering a wide variety of dishes crafted with love.</p>
                </div>
                
                <div class="col-md-4 mb-4 text-center">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="adminhome.jsp" class="footer-link">Home</a></li>
                        <li><a href="foods.jsp" class="footer-link">Foods</a></li>
                        <li><a href="Adminorder.jsp" class="footer-link">Orders</a></li>
                        <li><a href="alluser.jsp" class="footer-link">Customers</a></li>
                    </ul>
                </div>
                
                <div class="col-md-4 mb-4 text-md-end text-center">
                    <h5>Follow Us</h5>
                    <a href="#" class="social-icon" aria-label="Facebook"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="social-icon" aria-label="Instagram"><i class="bi bi-instagram"></i></a>
                    <a href="#" class="social-icon" aria-label="Twitter"><i class="bi bi-twitter"></i></a>
                    <a href="#" class="social-icon" aria-label="YouTube"><i class="bi bi-youtube"></i></a>
                </div>
            </div>
            
            <div class="text-center mt-4">
                <p class="mb-0">&copy; 2025 Food Delight. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Theme Toggle Functionality
        document.addEventListener("DOMContentLoaded", function() {
            const themeToggle = document.getElementById("themeToggle");
            const themeIcon = document.getElementById("themeIcon");
            const body = document.body;

            // Load theme from localStorage
            if (localStorage.getItem("theme") === "dark") {
                body.classList.add("dark-mode");
                themeIcon.classList.replace("bi-moon-fill", "bi-sun-fill");
            }

            // Toggle theme on button click
            themeToggle.addEventListener("click", function() {
                body.classList.toggle("dark-mode");

                if (body.classList.contains("dark-mode")) {
                    themeIcon.classList.replace("bi-moon-fill", "bi-sun-fill");
                    localStorage.setItem("theme", "dark");
                } else {
                    themeIcon.classList.replace("bi-sun-fill", "bi-moon-fill");
                    localStorage.setItem("theme", "light");
                }
            });
            
            // Auto-dismiss alerts after 5 seconds
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                setTimeout(() => {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                }, 5000);
            });
        });
    </script>
</body>
</html>