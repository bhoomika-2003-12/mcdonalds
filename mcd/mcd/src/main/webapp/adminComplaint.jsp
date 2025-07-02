<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mcd.models.Dto.*" %>
<%@page import="java.util.*" %>
<%@ page import="com.mcd.models.Dao.*" %>
<% 
AdminDao adao = new AdminDaoImpli();
User user = (User) session.getAttribute("pass");%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - View Complaints</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #ff6b35;
            --secondary-color: #f7c59f;
            --accent-color: #efefd0;
            --dark-color: #1a1a1a;
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
            background-color: rgba(255, 107, 53, 0.1);
        }

        .dropdown-menu {
            border: none;
            box-shadow: var(--shadow);
            border-radius: 10px;
        }

        .dropdown-item {
            padding: 8px 15px;
            transition: var(--transition);
        }

        .dropdown-item:hover {
            background-color: var(--secondary-color);
            color: var(--dark-color);
        }

        /* Main Content */
        .main-content {
            min-height: calc(100vh - 180px);
        }

        /* Table Styles */
        .table-responsive {
            border-radius: 10px;
            overflow: hidden;
        }

        .table thead th {
            background-color: var(--primary-color);
            color: white;
            font-weight: 600;
            padding: 15px;
            border: none;
        }

        .table tbody tr {
            transition: var(--transition);
        }

        .table tbody tr:hover {
            background-color: rgba(255, 107, 53, 0.05);
        }

        .badge {
            padding: 8px 12px;
            font-weight: 500;
            border-radius: 20px;
        }

        .bg-success {
            background-color: var(--success-color) !important;
        }

        .bg-warning {
            background-color: var(--warning-color) !important;
            color: var(--dark-color);
        }

        .bg-danger {
            background-color: var(--danger-color) !important;
        }

        .bg-info {
            background-color: var(--info-color) !important;
        }

        /* Action Buttons */
        .btn-group-sm .btn {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }

        /* Footer */
        .footer {
            background-color: var(--dark-color);
            color: white;
            padding: 40px 0 20px;
            margin-top: 40px;
        }

        .footer h5 {
            font-weight: 600;
            margin-bottom: 20px;
            color: var(--secondary-color);
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

        .footer p {
            color: #bbb;
            margin-bottom: 10px;
        }

        /* Dark Mode Styles */
        body.dark-mode {
            background-color: #121212;
            color: #e0e0e0;
        }

        .dark-mode .navbar {
            background-color: #1e1e1e !important;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
        }

        .dark-mode .nav-link {
            color: #e0e0e0 !important;
        }

        .dark-mode .card {
            background-color: #2a2a2a;
            color: #e0e0e0;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
        }

        .dark-mode .table {
            background-color: #2a2a2a;
            color: #e0e0e0;
        }

        .dark-mode .table thead th {
            background-color: var(--primary-color);
        }

        .dark-mode .table tbody tr:hover {
            background-color: rgba(255, 107, 53, 0.1);
        }

        .dark-mode .text-muted {
            color: #8a8a8a !important;
        }

        /* Responsive Adjustments */
        @media (max-width: 767px) {
            body {
                padding-top: 60px;
            }
            
            .navbar-brand img {
                height: 35px;
            }
            
            .table-responsive {
                overflow-x: auto;
            }
            
            .btn-group {
                display: flex;
                flex-direction: column;
                gap: 5px;
            }
        }

        @media (max-width: 575px) {
            .table th, .table td {
                padding: 10px;
                font-size: 0.9rem;
            }
            
            .badge {
                padding: 5px 8px;
                font-size: 0.8rem;
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
                <img src="https://logos-world.net/wp-content/uploads/2020/04/McDonalds-Logo-700x394.png" alt="McDonalds Logo">
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
                        <a class="nav-link" href="AdminOrder.jsp">Orders</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="adminComplaint.jsp">Queries</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="alluser.jsp">Customers</a>
                    </li>
                    
                    <!-- Admin Dropdown -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="navbarDropdown" 
                           role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-person-circle me-1"></i> ${user.username}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="profile.jsp"><i class="bi bi-person me-2"></i>Profile</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <form action="Logout" method="post">
                                    <button type="submit" class="dropdown-item">Logout</button>
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
    <main class="main-content">
        <div class="container mt-5">
            <div class="row mb-4">
                <div class="col-md-6">
                    <h2><i class="bi bi-exclamation-triangle"></i> Customer Queries</h2>
                </div>
            </div>

            <!-- Success/Error Messages -->
            <% 
            String success = (String) request.getAttribute("success");
            String error = (String) request.getAttribute("error");
            if (success != null) { %>
                <div class="alert alert-success alert-dismissible fade show">
                    <%= success %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } 
            if (error != null) { %>
                <div class="alert alert-danger alert-dismissible fade show">
                    <%= error %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>

            <!-- Complaints Table -->
            <div class="card shadow-sm mb-5">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Customer ID</th>
                                    <th>Subject</th>
                                    <th>Description</th>
                                    <th>Submitted Date</th>
                                    <th>Resolved Date</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                List<Complaints> complaints = adao.getAllComplaints();
                                if (complaints != null && !complaints.isEmpty()) {
                                    for (Complaints complaint : complaints) { 
                                %>
                                <tr>
                                    <td><%= complaint.getComplaintId() %></td>
                                    <td>
                                        <a href="alluser.jsp?userId=<%= complaint.getUserId() %>" class="text-decoration-none">
                                            <%= complaint.getUserId() %>
                                        </a>
                                    </td>
                                    <td><%= complaint.getSubjecct() %></td>
                                    <td><%= complaint.getDesc() %></td>
                                    <td><%= complaint.getDate() != null ? complaint.getDate() : "N/A" %></td>
                                    <td><%= complaint.getResloveDate() != null ? complaint.getResloveDate() : "N/A" %></td>
                                    <td>
                                        <span class="badge rounded-pill 
                                            <%= "Pending".equals(complaint.getStatus()) ? "bg-warning" : 
                                                "Resolved".equals(complaint.getStatus()) ? "bg-success" : 
                                                "Rejected".equals(complaint.getStatus()) ? "bg-danger" : "bg-info" %>">
                                            <%= complaint.getStatus() %>
                                        </span>
                                    </td>
                                    <td>
                                        <% if("Pending".equalsIgnoreCase(complaint.getStatus()) || "Processing".equalsIgnoreCase(complaint.getStatus())) { %>
                                        <div class="btn-group btn-group-sm" role="group">
                                            <form action="updateComplaint" method="post">
                                                <input type="hidden" name="complaint_Id" value="<%= complaint.getComplaintId() %>">
                                                <input type="hidden" name="user_id" value="<%= complaint.getUserId() %>">
                                                <input type="hidden" name="action" value="Resolved">
                                                <input type="submit" class="btn btn-success btn-sm" value="Resolve" />
                                            </form>
                                            <form action="updateComplaint" method="post">
                                                <input type="hidden" name="complaint_Id" value="<%= complaint.getComplaintId() %>">
                                                <input type="hidden" name="user_id" value="<%= complaint.getUserId() %>">
                                                <input type="hidden" name="action" value="Rejected">
                                                <input type="submit" class="btn btn-danger btn-sm" value="Reject"/>
                                            </form>
                                        </div>
                                        <% } else { %>
                                        <span class="text-muted">No actions available</span>
                                        <% } %>
                                    </td>
                                </tr>
                                <% } 
                                } else { %>
                                <tr>
                                    <td colspan="8" class="text-center text-muted py-4">No complaints found</td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 mb-4 mb-lg-0">
                    <h5>McDonalds Admin</h5>
                    <p>Powerful restaurant management system to streamline your operations and boost efficiency.</p>
                </div>
                <div class="col-lg-4 mb-4 mb-lg-0 text-center">
                    <h5>Quick Links</h5>
                    <a href="adminhome.jsp" class="footer-link">Home</a>
                    <a href="foods.jsp" class="footer-link">Foods</a>
                    <a href="AdminOrder.jsp" class="footer-link">Orders</a>
                    <a href="alluser.jsp" class="footer-link">Customers</a>
                </div>
                <div class="col-lg-4 text-center text-lg-end">
                    <h5>Support</h5>
                    <p><i class="bi bi-envelope me-2"></i> admin@mcdonalds.com</p>
                    <p><i class="bi bi-telephone me-2"></i> +1 (555) 123-4567</p>
                </div>
            </div>
            <div class="text-center mt-4">
                <p>&copy; 2023 McDonalds. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Theme Toggle Script -->
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