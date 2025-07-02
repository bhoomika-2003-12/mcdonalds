<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Delight | Food Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #ff6b6b;
            --primary-light: #ff8e8e;
            --secondary-color: #ffa502;
            --accent-color: #70a1ff;
            --dark-color: #2f3542;
            --light-color: #f8f9fa;
            --light-gray: #e9ecef;
            --medium-gray: #adb5bd;
            --success-color: #2ed573;
            --danger-color: #ff4757;
            --warning-color: #ffa502;
            --dark-bg: #1a1e23;
            --darker-bg: #15181d;
            --dark-text: #f5f6fa;
            --card-shadow: 0 10px 30px -15px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            --border-radius: 12px;
            --navbar-height: 70px;
        }
        
        body {
            font-family: 'Poppins', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, 
                        Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
            padding-top: var(--navbar-height);
            background-color: var(--light-color);
            color: var(--dark-color);
            transition: var(--transition);
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Navbar Styles */
        .navbar {
            background-color: #fff !important;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            padding: 0.5rem 0;
            transition: var(--transition);
            height: var(--navbar-height);
        }

        .navbar-brand img {
            max-width: 180px;
            height: auto;
            transition: var(--transition);
        }

        .navbar .nav-link {
            color: var(--dark-color) !important;
            font-weight: 500;
            padding: 0.5rem 1rem;
            margin: 0 0.25rem;
            border-radius: var(--border-radius);
            transition: var(--transition);
            position: relative;
            font-size: 0.95rem;
        }

        .navbar .nav-link:hover,
        .navbar .nav-link.active {
            color: var(--primary-color) !important;
            background: rgba(255, 107, 107, 0.1);
        }

        .navbar .nav-link.active:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 1rem;
            right: 1rem;
            height: 3px;
            background: var(--primary-color);
            border-radius: 3px 3px 0 0;
        }

        .navbar-toggler {
            border: none;
            padding: 0.5rem;
            outline: none;
        }

        .navbar-toggler:focus {
            box-shadow: none;
        }

        /* Main Content */
        main {
            flex: 1;
            padding-bottom: 2rem;
        }

        /* Dashboard Section */
        .dashboard-header {
            text-align: center;
            margin: 3rem 0 2.5rem;
            position: relative;
            padding: 0 1rem;
        }

        .dashboard-header h2 {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 1rem;
            position: relative;
            display: inline-block;
            line-height: 1.2;
        }

        .dashboard-header h2:after {
            content: '';
            position: absolute;
            bottom: -0.75rem;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            border-radius: 2px;
        }

        .dashboard-header p {
            color: var(--medium-gray);
            font-size: 1.1rem;
            max-width: 700px;
            margin: 0 auto;
            line-height: 1.7;
        }

        /* Card Grid */
        .card-grid {
            display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 350px)); /* Set a max width for cards */
        gap: 2rem;
        padding: 0 1rem;
        justify-content: center; /* This will center the grid items */
        max-width: 800px; /* Adjust based on your design needs */
        margin: 0 auto; /* Center the grid container */
        }

        /* Card Styles */
        .dashboard-card {
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: var(--transition);
            border: none;
            box-shadow: var(--card-shadow);
            background-color: #fff;
            color: var(--dark-color);
            border-radius: var(--border-radius);
            overflow: hidden;
            position: relative;
            margin-bottom: 0;
        }

        .dashboard-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px -5px rgba(0, 0, 0, 0.1);
        }

        .card-img-container {
            height: 200px;
            overflow: hidden;
            position: relative;
        }

        .dashboard-card img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: var(--transition);
        }

        .dashboard-card:hover img {
            transform: scale(1.05);
        }

        .card-body {
            padding: 1.75rem;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }

        .dashboard-card h3 {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: var(--primary-color);
        }

        .dashboard-card p {
            flex-grow: 1;
            margin-bottom: 1.5rem;
            color: var(--medium-gray);
            line-height: 1.7;
        }

        .card-icon {
            position: absolute;
            top: 1.25rem;
            right: 1.25rem;
            background: rgba(255, 255, 255, 0.95);
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: var(--primary-color);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: var(--transition);
            z-index: 2;
        }

        .dashboard-card:hover .card-icon {
            transform: scale(1.1) rotate(10deg);
            background: var(--primary-color);
            color: white;
        }

        /* Button Styles */
        .btn-custom {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border-radius: 10px;
            padding: 0.75rem 1.5rem;
            border: none;
            transition: var(--transition);
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            width: fit-content;
            box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
        }

        .btn-custom:hover {
            background: linear-gradient(135deg, var(--primary-light), #ff914d);
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(255, 107, 107, 0.4);
            color: white;
        }

        .btn-custom i {
            margin-right: 0.5rem;
            font-size: 1.1rem;
        }

        .btn-danger {
            background-color: var(--danger-color);
            border: none;
            padding: 0.65rem 1.25rem;
            border-radius: 10px;
            transition: var(--transition);
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            box-shadow: 0 4px 15px rgba(255, 71, 87, 0.2);
        }

        .btn-danger:hover {
            background-color: #ff3f3f;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(255, 71, 87, 0.3);
        }

        .btn-danger i {
            margin-right: 0.5rem;
        }

        /* Footer Styles */
        .footer {
            background-color: #fff;
            color: var(--dark-color);
            padding: 3rem 0 1.5rem;
            margin-top: 3rem;
            border-top: 1px solid rgba(0, 0, 0, 0.05);
        }

        .footer h5 {
            font-size: 1.2rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            color: var(--primary-color);
            position: relative;
            display: inline-block;
        }

        .footer h5:after {
            content: '';
            position: absolute;
            bottom: -0.5rem;
            left: 0;
            width: 40px;
            height: 3px;
            background: var(--primary-color);
            border-radius: 3px;
        }

        .footer-link {
            color: var(--dark-color);
            text-decoration: none;
            transition: var(--transition);
            display: inline-block;
            margin-bottom: 0.75rem;
            position: relative;
            font-weight: 500;
        }

        .footer-link:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 1px;
            background: var(--primary-color);
            transition: var(--transition);
        }

        .footer-link:hover {
            color: var(--primary-color);
            transform: translateX(5px);
        }

        .footer-link:hover:after {
            width: 100%;
        }

        .social-icon {
            color: var(--dark-color);
            font-size: 1.25rem;
            margin: 0 0.75rem 1rem 0;
            transition: var(--transition);
            display: inline-block;
        }

        .social-icon:hover {
            color: var(--primary-color);
            transform: translateY(-5px) scale(1.1);
        }

        /* Dark Mode Styles */
        body.dark-mode {
            background-color: var(--dark-bg);
            color: var(--dark-text);
        }

        .dark-mode .navbar {
            background-color: var(--darker-bg) !important;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
        }

        .dark-mode .nav-link {
            color: var(--dark-text) !important;
        }

        .dark-mode .nav-link:hover,
        .dark-mode .nav-link.active {
            color: var(--primary-color) !important;
            background: rgba(255, 107, 107, 0.2);
        }

        .dark-mode .dashboard-card {
            background-color: var(--darker-bg) !important;
            color: var(--dark-text);
            box-shadow: 0 10px 30px -15px rgba(0, 0, 0, 0.4);
            border: 1px solid rgba(255, 255, 255, 0.05);
        }

        .dark-mode .dashboard-card h3 {
            color: var(--primary-color);
        }

        .dark-mode .dashboard-card p {
            color: var(--medium-gray);
        }

        .dark-mode .card-icon {
            background: rgba(30, 34, 39, 0.9);
            color: var(--primary-color);
        }

        .dark-mode .dashboard-card:hover .card-icon {
            background: var(--primary-color);
            color: white;
        }

        .dark-mode .dashboard-header p {
            color: var(--medium-gray);
        }

        .dark-mode .footer {
            background-color: var(--darker-bg);
            color: var(--dark-text);
            border-top-color: rgba(255, 255, 255, 0.05);
        }

        .dark-mode .footer-link {
            color: var(--dark-text);
        }

        .dark-mode .footer-link:hover {
            color: var(--primary-color);
        }

        .dark-mode .social-icon {
            color: var(--dark-text);
        }

        .dark-mode .social-icon:hover {
            color: var(--primary-color);
        }

        /* Theme Toggle */
        .theme-toggle-btn {
            background: none;
            border: none;
            font-size: 1.4rem;
            cursor: pointer;
            color: var(--dark-color);
            transition: var(--transition);
            padding: 0.5rem;
            border-radius: 50%;
            outline: none;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .theme-toggle-btn:hover {
            background: rgba(0, 0, 0, 0.05);
            transform: rotate(30deg);
        }

        .dark-mode .theme-toggle-btn {
            color: var(--secondary-color);
        }

        .dark-mode .theme-toggle-btn:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        /* Responsive Adjustments */
        @media (max-width: 1199.98px) {
            .dashboard-header h2 {
                font-size: 2.2rem;
            }
            
            .card-img-container {
                height: 180px;
            }
        }

        @media (max-width: 991.98px) {
            .navbar-brand img {
                max-width: 160px;
            }
            
            .dashboard-header {
                margin: 2.5rem 0 2rem;
            }
            
            .dashboard-header h2 {
                font-size: 2rem;
            }
            
            .card-grid {
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 1.5rem;
            }
        }

        @media (max-width: 767.98px) {
            :root {
                --navbar-height: 65px;
            }
            
            .navbar-brand img {
                max-width: 140px;
            }
            
            .dashboard-header {
                margin: 2rem 0 1.5rem;
            }
            
            .dashboard-header h2 {
                font-size: 1.8rem;
            }
            
            .dashboard-header p {
                font-size: 1rem;
            }
            
            .card-img-container {
                height: 160px;
            }
            
            .card-body {
                padding: 1.5rem;
            }
            
            .dashboard-card h3 {
                font-size: 1.3rem;
            }
            
            .footer .col-md-4 {
                margin-bottom: 2rem;
                text-align: center !important;
            }
            
            .footer h5 {
                display: inline-block;
            }
            
            .footer h5:after {
                left: 50%;
                transform: translateX(-50%);
            }
        }

        @media (max-width: 575.98px) {
            :root {
                --navbar-height: 60px;
            }
            
            .navbar .nav-item {
                margin: 0.25rem 0;
            }
            
            .navbar .nav-link {
                padding: 0.5rem 0.75rem;
                font-size: 0.9rem;
                margin: 0;
            }
            
            .dashboard-header h2 {
                font-size: 1.6rem;
            }
            
            .card-grid {
                grid-template-columns: 1fr;
                gap: 1.25rem;
            }
            
            .card-img-container {
                height: 150px;
            }
            
            .card-body {
                padding: 1.25rem;
            }
            
            .dashboard-card h3 {
                font-size: 1.25rem;
                margin-bottom: 0.75rem;
            }
            
            .card-icon {
                width: 40px;
                height: 40px;
                font-size: 1.2rem;
            }
            
            .theme-toggle-btn {
                font-size: 1.2rem;
                width: 36px;
                height: 36px;
            }
            
            .footer {
                padding: 2rem 0 1rem;
                margin-top: 2rem;
            }
        }

        @media (max-width: 400px) {
            .navbar-brand img {
                max-width: 120px;
            }
            
            .dashboard-header h2 {
                font-size: 1.5rem;
            }
            
            .card-img-container {
                height: 140px;
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
    <header class="navbar navbar-expand-lg navbar-light fixed-top shadow-sm">
        <div class="container">
            <!-- LOGO -->
            <a class="navbar-brand" href="admin.jsp">
                <img src="https://logos-world.net/wp-content/uploads/2020/04/McDonalds-Logo-700x394.png" class="img-fluid" alt="Food Delight Logo">
            </a>

            <!-- Mobile Toggle Button -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" 
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Navbar Items -->
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item">
                        <a class="nav-link" href="foods.jsp"><i class="bi bi-egg-fried me-1"></i>Food Menu</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="AdminOrder.jsp"><i class="bi bi-receipt me-1"></i>Orders</a>
                    </li>
                    <li class="nav-item">
                    	<a class="nav-link" href="adminComplaint.jsp">Queries</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="alluser.jsp"><i class="bi bi-people me-1"></i>Customers</a>
                    </li>
                    
                    <!-- Theme Toggle -->
                    <li class="nav-item ms-2">
                        <button id="themeToggle" class="btn theme-toggle-btn" aria-label="Toggle theme">
                            <i id="themeIcon" class="bi bi-moon-fill"></i>
                        </button>
                    </li>
                    
                    <!-- Logout Button -->
                    <li class="nav-item ms-2">
                        <form action="Logout" method="post">
                                    <button type="submit" class="dropdown-item">Logout</button>
                                </form>
                    </li>
                </ul>
            </div>
        </div>
    </header>

    <!-- Dashboard Section -->
    <main class="container">
        <div class="dashboard-header animate__animated animate__fadeIn">
            <h2>Food Dashboard</h2>
            <p>Manage your restaurant's food menu from one convenient location</p>
        </div>

        <div class="card-grid animate__animated animate__fadeInUp">
            <!-- Add Food Card -->
            <div class="dashboard-card">
                <div class="card-img-container">
                    <img src="https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80" 
                         alt="Add Food">
                    <div class="card-icon">
                        <i class="bi bi-plus-lg"></i>
                    </div>
                </div>
                <div class="card-body">
                    <h3>Add New Food</h3>
                    <p>Introduce new dishes to your menu with detailed descriptions, images, and pricing information.</p>
                    <a href="addFood.jsp" class="btn btn-custom">
                        <i class="bi bi-plus-circle"></i> Add Food
                    </a>
                </div>
            </div>

            <!-- Manage Food Card -->
            <div class="dashboard-card">
                <div class="card-img-container">
                    <img src="https://images.unsplash.com/photo-1555244162-803834f70033?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" 
                         alt="Manage Food">
                    <div class="card-icon">
                        <i class="bi bi-pencil-square"></i>
                    </div>
                </div>
                <div class="card-body">
                    <h3>Manage Food Menu</h3>
                    <p>View, edit, or remove existing menu items. Update prices, descriptions, and availability.</p>
                    <a href="showFood.jsp" class="btn btn-custom">
                        <i class="bi bi-list-ul"></i> Manage Menu
                    </a>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-4 mb-md-0 text-center text-md-start">
                    <h5>About Food Delight</h5>
                    <p class="mt-3">Delivering culinary excellence since 2015. Our mission is to bring joy through delicious, high-quality food prepared with love and care.</p>
                    <div class="mt-3">
                        <img src="https://via.placeholder.com/150x50?text=Food+Delight" alt="Logo" style="max-width: 150px; opacity: 0.8;">
                    </div>
                </div>

                <div class="col-md-4 mb-4 mb-md-0 text-center">
                    <h5>Quick Links</h5>
                    <div class="d-flex flex-column mt-3">
                        <a href="adminhome.jsp" class="footer-link"><i class="bi bi-speedometer2 me-2"></i>home</a>
                        <a href="foods.jsp" class="footer-link"><i class="bi bi-egg-fried me-2"></i>Food Menu</a>
                        <a href="adminOrder.jsp" class="footer-link"><i class="bi bi-receipt me-2"></i>Orders</a>
                        <a href="alluser.jsp" class="footer-link"><i class="bi bi-people me-2"></i>Customers</a>
                    </div>
                </div>

                <div class="col-md-4 text-center text-md-end">
                    <h5>Connect With Us</h5>
                    <div class="mt-3">
                        <a href="#" class="social-icon" aria-label="Facebook"><i class="bi bi-facebook"></i></a>
                        <a href="#" class="social-icon" aria-label="Instagram"><i class="bi bi-instagram"></i></a>
                        <a href="#" class="social-icon" aria-label="Twitter"><i class="bi bi-twitter"></i></a>
                        <a href="#" class="social-icon" aria-label="YouTube"><i class="bi bi-youtube"></i></a>
                    </div>
                    <div class="mt-4">
                        <h6>Contact Support</h6>
                        <p class="mt-2 mb-1"><i class="bi bi-envelope me-2"></i>support@fooddelight.com</p>
                        <p><i class="bi bi-telephone me-2"></i>+1 (555) 123-4567</p>
                    </div>
                </div>
            </div>

            <div class="text-center mt-5 pt-3 border-top">
                <p class="mb-0">&copy; 2025 Food Delight. All rights reserved. | <a href="#" class="footer-link">Privacy Policy</a> | <a href="#" class="footer-link">Terms of Service</a></p>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const themeToggle = document.getElementById("themeToggle");
            const themeIcon = document.getElementById("themeIcon");
            const body = document.body;

            // Check for saved theme preference or use preferred color scheme
            const prefersDarkScheme = window.matchMedia("(prefers-color-scheme: dark)");
            const currentTheme = localStorage.getItem("theme");
            
            if (currentTheme === "dark" || (!currentTheme && prefersDarkScheme.matches)) {
                body.classList.add("dark-mode");
                themeIcon.classList.replace("bi-moon-fill", "bi-sun-fill");
                localStorage.setItem("theme", "dark");
            }

            // Toggle theme on button click
            themeToggle.addEventListener("click", function () {
                body.classList.toggle("dark-mode");
                
                if (body.classList.contains("dark-mode")) {
                    themeIcon.classList.replace("bi-moon-fill", "bi-sun-fill");
                    localStorage.setItem("theme", "dark");
                } else {
                    themeIcon.classList.replace("bi-sun-fill", "bi-moon-fill");
                    localStorage.setItem("theme", "light");
                }
            });

            // Listen for system theme changes
            prefersDarkScheme.addListener(e => {
                if (!localStorage.getItem("theme")) {
                    if (e.matches) {
                        body.classList.add("dark-mode");
                        themeIcon.classList.replace("bi-moon-fill", "bi-sun-fill");
                    } else {
                        body.classList.remove("dark-mode");
                        themeIcon.classList.replace("bi-sun-fill", "bi-moon-fill");
                    }
                }
            });
        });
    </script>
</body>
</html>