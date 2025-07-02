<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Delight | Add Food</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <style>
        :root {
            --primary-color: #ff6b6b;
            --secondary-color: #ffa502;
            --accent-color: #70a1ff;
            --dark-color: #2f3542;
            --light-color: #f8f9fa;
            --success-color: #2ed573;
            --danger-color: #ff4757;
            --dark-bg: #1e272e;
            --dark-text: #f5f6fa;
            --card-shadow: 0 10px 30px -15px rgba(0, 0, 0, 0.2);
            --transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
        }
        
        body {
            font-family: 'Poppins', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, 
                        Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
            padding-top: 70px;
            background-color: var(--light-color);
            color: var(--dark-color);
            transition: var(--transition);
            line-height: 1.6;
        }

        /* Navbar Styles */
        .navbar {
            background-color: #fff !important;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            padding: 12px 0;
            transition: var(--transition);
        }

        .navbar-brand img {
            max-width: 160px;
            height: auto;
            transition: var(--transition);
        }

        .navbar .nav-link {
            color: var(--dark-color) !important;
            font-weight: 500;
            padding: 8px 15px;
            margin: 0 5px;
            border-radius: 8px;
            transition: var(--transition);
            position: relative;
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
            left: 15px;
            right: 15px;
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
        .food-add-section {
            max-width: 700px;
            margin: 40px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 16px;
            box-shadow: var(--card-shadow);
            transform: translateY(0);
            transition: var(--transition);
        }

        .food-add-section:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px -10px rgba(0, 0, 0, 0.15);
        }

        .food-add-section h2 {
            text-align: center;
            margin-bottom: 30px;
            color: var(--primary-color);
            font-size: 2rem;
            font-weight: 700;
            position: relative;
            padding-bottom: 15px;
        }

        .food-add-section h2:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            border-radius: 2px;
        }

        /* Form Styles */
        .form-label {
            font-weight: 500;
            margin-bottom: 10px;
            font-size: 0.95rem;
            color: var(--dark-color);
        }

        .form-control {
            padding: 12px 18px;
            border-radius: 10px;
            border: 2px solid #e0e0e0;
            transition: var(--transition);
            font-size: 0.95rem;
            height: auto;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(255, 107, 107, 0.25);
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        select.form-control {
            appearance: none;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%23343a40' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M2 5l6 6 6-6'/%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 0.75rem center;
            background-size: 16px 12px;
        }

        /* Button Styles */
        .btn-custom {
            display: block;
            width: 100%;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border-radius: 10px;
            padding: 14px;
            border: none;
            transition: var(--transition);
            font-weight: 600;
            cursor: pointer;
            margin-top: 25px;
            font-size: 1rem;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            position: relative;
            overflow: hidden;
        }

        .btn-custom:hover {
            background: linear-gradient(135deg, #ff5252, #ff7f50);
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(255, 107, 107, 0.3);
        }

        .btn-custom:active {
            transform: translateY(-1px);
        }

        .btn-custom:after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 5px;
            height: 5px;
            background: rgba(255, 255, 255, 0.5);
            opacity: 0;
            border-radius: 100%;
            transform: scale(1, 1) translate(-50%);
            transform-origin: 50% 50%;
        }

        .btn-custom:focus:not(:active)::after {
            animation: ripple 1s ease-out;
        }

        @keyframes ripple {
            0% {
                transform: scale(0, 0);
                opacity: 0.5;
            }
            100% {
                transform: scale(20, 20);
                opacity: 0;
            }
        }

        .btn-danger {
            background-color: var(--danger-color);
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
            transition: var(--transition);
            font-size: 0.95rem;
            font-weight: 500;
        }

        .btn-danger:hover {
            background-color: #ff3f3f;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 71, 87, 0.3);
        }

        /* Footer Styles */
        .footer {
            background-color: #fff;
            color: var(--dark-color);
            padding: 40px 0 20px;
            border-top: 1px solid rgba(0, 0, 0, 0.05);
            font-size: 0.95rem;
            margin-top: 60px;
        }

        .footer h5 {
            font-size: 1.2rem;
            font-weight: 700;
            margin-bottom: 20px;
            color: var(--primary-color);
            position: relative;
            display: inline-block;
        }

        .footer h5:after {
            content: '';
            position: absolute;
            bottom: -8px;
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
            margin-bottom: 10px;
            font-size: 0.95rem;
            position: relative;
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
            font-size: 20px;
            margin: 0 10px 15px;
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
            background-color: #1a1a1a !important;
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

        .dark-mode .food-add-section {
            background-color: #2d3436 !important;
            color: var(--dark-text);
            box-shadow: 0 10px 30px -15px rgba(0, 0, 0, 0.4);
        }

        .dark-mode .form-control {
            background-color: #3d3d3d !important;
            color: var(--dark-text) !important;
            border-color: #4d4d4d !important;
        }

        .dark-mode .form-control::placeholder {
            color: #aaa !important;
        }

        .dark-mode .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(255, 107, 107, 0.25);
        }

        .dark-mode .form-label {
            color: var(--dark-text);
        }

        .dark-mode .footer {
            background-color: #1a1a1a;
            color: var(--dark-text);
            border-top-color: #333;
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
            padding: 8px 12px;
            border-radius: 8px;
            outline: none;
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

        /* Message Styles */
        .alert-message {
            max-width: 700px;
            margin: 25px auto;
            padding: 18px;
            border-radius: 12px;
            text-align: center;
            font-size: 0.95rem;
            font-weight: 500;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .alert-message i {
            margin-right: 10px;
            font-size: 1.2rem;
        }

        .success-message {
            background-color: rgba(46, 213, 115, 0.2);
            color: #155724;
            border: 1px solid rgba(46, 213, 115, 0.3);
        }

        .success-message i {
            color: var(--success-color);
        }

        .fail-message {
            background-color: rgba(255, 71, 87, 0.2);
            color: #721c24;
            border: 1px solid rgba(255, 71, 87, 0.3);
        }

        .fail-message i {
            color: var(--danger-color);
        }

        /* Floating Animation */
        .floating {
            animation: floating 3s ease-in-out infinite;
        }

        @keyframes floating {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
            100% { transform: translateY(0px); }
        }

        /* Responsive Adjustments */
        @media (max-width: 992px) {
            .navbar-brand img {
                max-width: 140px;
            }
        }

        @media (max-width: 768px) {
            body {
                padding-top: 65px;
            }
            
            .navbar-brand img {
                max-width: 130px;
            }
            
            .food-add-section {
                margin: 30px 20px;
                padding: 25px;
            }
            
            .food-add-section h2 {
                font-size: 1.8rem;
                margin-bottom: 25px;
            }
            
            .footer .col-md-4 {
                margin-bottom: 25px;
                text-align: center;
            }
            
            .footer h5 {
                display: inline-block;
            }
            
            .footer h5:after {
                left: 50%;
                transform: translateX(-50%);
            }
            
            .footer .text-end {
                text-align: center !important;
            }
        }

        @media (max-width: 576px) {
            body {
                padding-top: 60px;
            }
            
            .navbar .nav-item {
                margin: 5px 0;
            }
            
            .navbar .nav-link {
                padding: 8px 12px;
                font-size: 0.9rem;
            }
            
            .food-add-section {
                margin: 20px 15px;
                padding: 20px;
            }
            
            .food-add-section h2 {
                font-size: 1.6rem;
            }
            
            .form-control {
                padding: 10px 15px;
                font-size: 0.9rem;
            }
            
            .btn-custom {
                padding: 12px;
                font-size: 0.95rem;
            }
            
            .btn-danger {
                padding: 8px 15px;
                font-size: 0.9rem;
            }
            
            .theme-toggle-btn {
                font-size: 1.3rem;
                padding: 6px 10px;
            }
            
            .footer {
                padding: 30px 0 20px;
            }
            
            .footer h5 {
                font-size: 1.1rem;
            }
        }

        @media (max-width: 400px) {
            .navbar-brand img {
                max-width: 120px;
            }
            
            .food-add-section {
                margin: 15px 10px;
                padding: 20px 15px;
            }
            
            .food-add-section h2 {
                font-size: 1.4rem;
            }
            
            .form-label {
                font-size: 0.9rem;
            }
            
            .btn-custom {
                font-size: 0.9rem;
                padding: 10px;
            }
            
            .alert-message {
                margin: 20px 15px;
                padding: 15px;
                font-size: 0.9rem;
            }
        }
    </style>
</head>

<body>
<% String pass=(String)request.getAttribute("success"); %>
<% String fail=(String)request.getAttribute("fail"); %>

    <!-- Header Section -->
    <header class="navbar navbar-expand-lg navbar-light bg-light fixed-top shadow-sm">
        <div class="container">
            <!-- LOGO -->
            <a class="navbar-brand" href="admin.jsp">
                <img src="https://logos-world.net/wp-content/uploads/2020/04/McDonalds-Logo-700x394.png" alt="Logo" class="img-fluid floating">
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
                        <a class="nav-link" href="admin.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="foods.jsp">Foods</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="orders.jsp">Orders</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="customers.jsp">Customers</a>
                    </li>
                    
                    <!-- Theme Toggle -->
                    <li class="nav-item">
                        <button id="themeToggle" class="btn theme-toggle-btn" aria-label="Toggle theme">
                            <i id="themeIcon" class="bi bi-moon-fill"></i>
                        </button>
                    </li>
                    
                    <!-- Logout Button -->
                    <li class="nav-item ms-2">
                        <a href="login.jsp" class="btn btn-danger">
                            <i class="bi bi-box-arrow-right me-1"></i>Logout
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </header>
    
    <!-- Messages -->
    <%if(pass!=null){ %>
    <div class="alert-message success-message animate__animated animate__fadeIn">
        <i class="bi bi-check-circle-fill"></i>
        <span><%=pass %></span>
    </div>
    <%} %>
    
    <%if(fail!=null){ %>
    <div class="alert-message fail-message animate__animated animate__fadeIn">
        <i class="bi bi-exclamation-triangle-fill"></i>
        <span><%=fail %></span>
    </div>
    <%} %>
    
    <!-- Add Food Form -->
    <section class="food-add-section animate__animated animate__fadeInUp">
        <h2>Add New Food Item</h2>
        <form action="AddFoodServlet" method="post">
            <div class="mb-4">
                <label for="foodImage" class="form-label">Food Image URL</label>
                <input type="text" class="form-control" id="foodImage" name="foodImage" required 
                       placeholder="https://example.com/image.jpg">
                <small class="text-muted">Provide a direct URL to the food image</small>
            </div>

            <div class="mb-4">
                <label for="foodName" class="form-label">Food Name</label>
                <input type="text" class="form-control" id="foodName" name="foodName" required 
                       placeholder="e.g., Margherita Pizza">
            </div>

            <div class="mb-4">
                <label for="foodDescription" class="form-label">Description</label>
                <textarea class="form-control" id="foodDescription" name="foodDescription" rows="3" required 
                          placeholder="Describe the food item in detail..."></textarea>
            </div>

            <div class="row g-3 mb-4">
                <div class="col-md-6">
                    <label for="foodType" class="form-label">Food Type</label>
                    <select class="form-control" id="foodType" name="foodType" required>
                        <option value="" disabled selected>Select Type</option>
                        <option value="Veg">Vegetarian</option>
                        <option value="Non-Veg">Non-Vegetarian</option>
                        <option value="Vegan">Vegan</option>
                    </select>
                </div>

                <div class="col-md-6">
                    <label for="foodCategory" class="form-label">Food Category</label>
                    <select class="form-control" id="foodCategory" name="foodCategory" required>
                        <option value="" disabled selected>Select Category</option>
                        <option value="Starter">Starter</option>
                        <option value="Main Course">Main Course</option>
                        <option value="Dessert">Dessert</option>
                        <option value="Beverage">Beverage</option>
                        <option value="Salad">Salad</option>
                        <option value="Soup">Soup</option>
                    </select>
                </div>
            </div>

            <div class="mb-4">
                <label for="foodPrice" class="form-label">Price (₹)</label>
                <div class="input-group">
                    <span class="input-group-text">₹</span>
                    <input type="number" step="0.01" min="0" class="form-control" id="foodPrice" 
                           name="foodPrice" required placeholder="199.00">
                </div>
            </div>

            <button type="submit" class="btn btn-custom">
                <i class="bi bi-plus-circle me-2"></i>Add Food Item
            </button>
        </form>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-4 mb-md-0 text-center text-md-start">
                    <h5>About Food Delight</h5>
                    <p class="mt-3">Delivering culinary excellence since 2015. Our mission is to bring joy through delicious, high-quality food prepared with love and care.</p>
                    <div class="mt-3">
                        <img src="Assets/Logo/logo-transparent-png.png" alt="Logo" style="max-width: 140px; opacity: 0.8;">
                    </div>
                </div>

                <div class="col-md-4 mb-4 mb-md-0 text-center">
                    <h5>Quick Links</h5>
                    <div class="d-flex flex-column mt-3">
                        <a href="admin.jsp" class="footer-link">Dashboard</a>
                        <a href="foods.jsp" class="footer-link">Manage Menu</a>
                        <a href="orders.jsp" class="footer-link">View Orders</a>
                        <a href="customers.jsp" class="footer-link">Customer List</a>
                        <a href="#" class="footer-link">Reports</a>
                    </div>
                </div>

                <div class="col-md-4 text-center text-md-end">
                    <h5>Connect With Us</h5>
                    <div class="mt-3">
                        <a href="#" class="social-icon" aria-label="Facebook"><i class="bi bi-facebook"></i></a>
                        <a href="#" class="social-icon" aria-label="Instagram"><i class="bi bi-instagram"></i></a>
                        <a href="#" class="social-icon" aria-label="Twitter"><i class="bi bi-twitter"></i></a>
                        <a href="#" class="social-icon" aria-label="YouTube"><i class="bi bi-youtube"></i></a>
                        <a href="#" class="social-icon" aria-label="LinkedIn"><i class="bi bi-linkedin"></i></a>
                    </div>
                    <div class="mt-4">
                        <h6>Subscribe to Newsletter</h6>
                        <div class="input-group mt-2">
                            <input type="email" class="form-control" placeholder="Your email" aria-label="Your email">
                            <button class="btn btn-sm btn-outline-primary" type="button">Subscribe</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="text-center mt-5 pt-3 border-top">
                <p class="mb-0">&copy; 2025 Food Delight. All rights reserved. | <a href="#" class="footer-link">Privacy Policy</a> | <a href="#" class="footer-link">Terms of Service</a></p>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
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

            // Form validation
            const form = document.querySelector("form");
            if (form) {
                form.addEventListener("submit", function(e) {
                    const priceInput = document.getElementById("foodPrice");
                    if (priceInput && parseFloat(priceInput.value) <= 0) {
                        e.preventDefault();
                        Swal.fire({
                            icon: 'error',
                            title: 'Invalid Price',
                            text: 'Please enter a valid price greater than 0',
                            confirmButtonColor: 'var(--primary-color)'
                        });
                    }
                });
            }

            // Add animation to success/error messages
            const messages = document.querySelectorAll(".alert-message");
            messages.forEach(msg => {
                setTimeout(() => {
                    msg.classList.add("animate__fadeOut");
                    setTimeout(() => msg.remove(), 1000);
                }, 5000);
            });
        });
    </script>
</body>
</html>