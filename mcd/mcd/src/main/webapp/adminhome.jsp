<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mcd.models.Dto.*" %>
<%@ page import="com.mcd.models.Dao.*" %>
<%AdminDao adao=new AdminDaoImpli(); %>
<%int countOrder=adao.getTodayOrderCount(); %>
<%int countCustomer=adao.getTotalCustomer(); %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MoonChees | Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
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

        /* Hero Section */
        .hero {
            background: linear-gradient(135deg, var(--accent-color) 0%, white 100%);
            padding: 60px 0;
            position: relative;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80') center/cover;
            opacity: 0.1;
            z-index: 0;
        }

        .hero-content {
            position: relative;
            z-index: 1;
        }

        .hero h1 {
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 20px;
            font-size: 2.5rem;
        }

        .hero p {
            font-size: 1.2rem;
            color: var(--dark-color);
            margin-bottom: 30px;
            max-width: 600px;
        }

        .hero-image {
            border-radius: 15px;
            box-shadow: var(--shadow);
            transition: var(--transition);
            height: 100%;
            object-fit: cover;
        }

        .hero-image:hover {
            transform: scale(1.02);
        }

        /* Stats Section */
        .stats {
            padding: 60px 0;
        }

        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: var(--shadow);
            transition: var(--transition);
            height: 100%;
            border: none;
            text-align: center;
        }

        .stat-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
        }

        .stat-card i {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 15px;
        }

        .stat-card h3 {
            font-weight: 700;
            color: var(--primary-color);
            font-size: 2rem;
            margin-bottom: 10px;
        }

        .stat-card p {
            color: #666;
            margin-bottom: 20px;
        }

        /* Orders Table */
        .recent-orders {
            padding: 60px 0;
            background-color: #f9f9f9;
        }

        .table {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: var(--shadow);
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

        /* Footer */
        .footer {
            background-color: var(--dark-color);
            color: white;
            padding: 60px 0 30px;
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

        /* Buttons */
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            transition: var(--transition);
        }

        .btn-primary:hover {
            background-color: #e05a2b;
            border-color: #e05a2b;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 53, 0.3);
        }

        .btn-outline-primary {
            color: var(--primary-color);
            border-color: var(--primary-color);
            transition: var(--transition);
        }

        .btn-outline-primary:hover {
            background-color: var(--primary-color);
            color: white;
        }

        /* Theme Toggle */
        .theme-toggle-btn {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: var(--dark-color);
            transition: var(--transition);
            padding: 5px 10px;
        }

        .theme-toggle-btn:hover {
            color: var(--primary-color);
            transform: rotate(15deg);
        }

        /* Dark Mode */
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

        .dark-mode .hero {
            background: linear-gradient(135deg, #2a2a2a 0%, #1e1e1e 100%);
        }

        .dark-mode .hero h1 {
            color: var(--secondary-color);
        }

        .dark-mode .hero p {
            color: #bbb;
        }

        .dark-mode .stat-card {
            background-color: #2a2a2a;
            color: #e0e0e0;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
        }

        .dark-mode .stat-card p {
            color: #bbb;
        }

        .dark-mode .recent-orders {
            background-color: #1e1e1e;
        }

        .dark-mode .table {
            background-color: #2a2a2a;
            color: #e0e0e0;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
        }

        .dark-mode .table thead th {
            background-color: var(--primary-color);
        }

        .dark-mode .table tbody tr:hover {
            background-color: rgba(255, 107, 53, 0.1);
        }

        .dark-mode .footer {
            background-color: #1a1a1a;
        }

        .dark-mode .footer-link {
            color: #bbb;
        }

        /* Responsive Adjustments */
        @media (max-width: 1199px) {
            .hero h1 {
                font-size: 2.2rem;
            }
        }

        @media (max-width: 991px) {
            .hero {
                padding: 40px 0;
            }
            
            .hero h1 {
                font-size: 2rem;
            }
            
            .hero p {
                font-size: 1.1rem;
            }
            
            .stat-card {
                padding: 20px;
            }
            
            .stat-card i {
                font-size: 2rem;
            }
            
            .stat-card h3 {
                font-size: 1.8rem;
            }
        }

        @media (max-width: 767px) {
            body {
                padding-top: 60px;
            }
            
            .navbar-brand img {
                height: 35px;
            }
            
            .hero {
                text-align: center;
            }
            
            .hero h1 {
                font-size: 1.8rem;
            }
            
            .hero p {
                margin-left: auto;
                margin-right: auto;
            }
            
            .hero-image {
                margin-top: 30px;
                max-height: 300px;
            }
            
            .stats{
            
            margin-right:50px;
            
            }
            
            .stat-card {
                margin-bottom: 20px;
            }
            
            .table-responsive {
                overflow-x: auto;
            }
            
            .footer .col-md-4 {
                margin-bottom: 30px;
                text-align: center;
            }
            
            .footer-link {
                display: inline-block;
                margin: 0 10px 10px;
            }
        }

        @media (max-width: 575px) {
            .hero h1 {
                font-size: 1.6rem;
            }
            
            .hero p {
                font-size: 1rem;
            }
            
            .btn-lg {
                padding: 8px 16px;
                font-size: 0.9rem;
            }
            
            .stat-card {
                padding: 15px;
               
            }
            
            .stat-card i {
                font-size: 1.8rem;
            }
            
            .stat-card h3 {
                font-size: 1.5rem;
            }
            
            .table th, .table td {
                padding: 10px;
                font-size: 0.9rem;
            }
            
            .badge {
                padding: 5px 8px;
                font-size: 0.8rem;
            }
        }

        @media (max-width: 400px) {
            .navbar-brand img {
                height: 30px;
            }
            
            .hero h1 {
                font-size: 1.4rem;
            }
            
            .btn-lg {
                display: block;
                width: 100%;
                margin-bottom: 10px;
            }
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
    <header class="navbar navbar-expand-lg navbar-light fixed-top shadow">
        <div class="container">
            <!-- LOGO -->
            <a class="navbar-brand" href="adminhome.jsp">
                <img src="https://logos-world.net/wp-content/uploads/2020/04/McDonalds-Logo-700x394.png" alt="MoonChees Logo">
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
                        <a class="nav-link" href="adminComplaint.jsp">Queries</a>
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
                            <li><form action="Logout" method="post">
                                    <button type="submit" class="dropdown-item">Logout</button>
                                </form></li>
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

    <!-- Hero Section -->
    <section class="hero">
        <div class="container hero-content">
            <div class="row align-items-center">
                <div class="col-lg-6 mb-4 mb-lg-0">
                    <h1 class="animate__animated animate__fadeInDown">Welcome back, Admin!</h1>
                    <p class="animate__animated animate__fadeIn animate__delay-1s">Manage your restaurant with our powerful dashboard tools and analytics.</p>
                    <div class="d-flex flex-wrap gap-3 animate__animated animate__fadeIn animate__delay-2s">
                        <a href="foods.jsp" class="btn btn-primary btn-lg">Manage Menu</a>
                        <a href="orders.jsp" class="btn btn-outline-primary btn-lg">View Orders</a>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div id="heroCarousel" class="carousel slide" data-bs-ride="carousel">
                        <div class="carousel-inner rounded">
                            <div class="carousel-item active">
                                <img src="https://images.unsplash.com/photo-1555396273-367ea4eb4db5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1374&q=80" 
                                     class="d-block w-100 hero-image" alt="Restaurant Interior">
                            </div>
                            <div class="carousel-item">
                                <img src="https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" 
                                     class="d-block w-100 hero-image" alt="Chef Preparing Food">
                            </div>
                            <div class="carousel-item">
                                <img src="https://images.unsplash.com/photo-1544025162-d76694265947?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1469&q=80" 
                                     class="d-block w-100 hero-image" alt="Delicious Food">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Quick Stats Section -->
    <section class="stats container my-5">
        <div class="row">
            <div class="col-md-5 mb-4">
                <div class="stat-card animate__animated animate__fadeInUp">
                    <i class="bi bi-people"></i>
                    <h3><span id="customerCount">0</span></h3>
                    <p>Total Customers</p>
                    <a href="customers.jsp" class="btn btn-sm btn-outline-primary">View All</a>
                </div>
            </div>
            <div class="col-md-5 mb-4">
                <div class="stat-card animate__animated animate__fadeInUp animate__delay-1s">
                    <i class="bi bi-cart"></i>
                    <h3><span id="orderCount"></span></h3>
                    <p>Today's Orders</p>
                    <a href="AdminOrder.jsp" class="btn btn-sm btn-outline-success">Manage Orders</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Recent Orders Section -->
 <!--    <section class="recent-orders">
        <div class="container">
            <h2 class="text-center mb-4 animate__animated animate__fadeIn">Recent Orders</h2>
            <div class="table-responsive animate__animated animate__fadeIn animate__delay-1s">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>user ID</th>
                            <th>Order Date</th>
                            <th>Price</th>
                            <th>Status</th>
                            <th>Paymentmethod</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${recentOrders}" var="order">
                            <tr>
                                <td>${order.id}</td>
                                <td>${order.customerName}</td>
                                <td>${order.itemCount} items</td>
                                <td>$${order.totalAmount}</td>
                                <td>
                                    <span class="badge ${order.status == 'Delivered' ? 'bg-success' : 
                                        order.status == 'Processing' ? 'bg-warning' : 'bg-danger'}">
                                        ${order.status}
                                    </span>
                                </td>
                                <td>
                                    <a href="orderdetails.jsp?id=${order.id}" class="btn btn-sm btn-primary">View</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="text-center mt-4 animate__animated animate__fadeIn animate__delay-2s">
                <a href="orders.jsp" class="btn btn-outline-primary">View All Orders</a>
            </div>
        </div>
    </section>-->

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 mb-4 mb-lg-0">
                    <h5>MoonChees Admin</h5>
                    <p>Powerful restaurant management system to streamline your operations and boost efficiency.</p>
                </div>
                <div class="col-lg-4 mb-4 mb-lg-0 text-center">
                    <h5>Quick Links</h5>
                    <a href="adminhome.jsp" class="footer-link">home</a>
                    <a href="foods.jsp" class="footer-link">Foods</a>
                    <a href="AdminOrder.jsp" class="footer-link">Orders</a>
                    <a href="alluser.jsp" class="footer-link">Customer</a>
                </div>
                <div class="col-lg-4 text-center text-lg-end">
                    <h5>Support</h5>
                    <p><i class="bi bi-envelope me-2"></i> admin@moonchees.com</p>
                    <p><i class="bi bi-telephone me-2"></i> +1 (555) 123-4567</p>
                </div>
            </div>
            <div class="text-center mt-5">
                <p>&copy; 2023 MoonChees. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <!-- JavaScript Libraries -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <!-- Custom Scripts -->
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
            
            // Toggle theme
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
            
            // Animate stats counting
            function animateValue(id, start, end, duration) {
                const obj = document.getElementById(id);
                let startTimestamp = null;
                const step = (timestamp) => {
                    if (!startTimestamp) startTimestamp = timestamp;
                    const progress = Math.min((timestamp - startTimestamp) / duration, 1);
                    obj.innerHTML = Math.floor(progress * (end - start) + start);
                    if (progress < 1) {
                        window.requestAnimationFrame(step);
                    }
                };
                window.requestAnimationFrame(step);
            }
            
            // Example values - replace with actual data from your backend
            animateValue("customerCount", 0, <%= countCustomer%>, 2000);
            animateValue("orderCount", 0, <%= countOrder%> , 1500);
            
            // Initialize carousel
            const heroCarousel = new bootstrap.Carousel(document.getElementById('heroCarousel'), {
                interval: 3000,
                ride: 'carousel'
            });
        });
    </script>
</body>
</html>