<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mcd.models.Dto.User" %>
<%@ page import="com.mcd.models.Dto.Food" %>
<%@ page import="com.mcd.models.Dao.AdminDao" %>
<%@ page import="com.mcd.models.Dao.AdminDaoImpli" %>
<%@ page import="java.util.ArrayList" %>

<%
// Check if user is logged in
User user = (User) session.getAttribute("pass");
boolean isLoggedIn = user != null;
String username = isLoggedIn ? user.getName() : "Guest";

// Fetch food items from database
AdminDao adao = new AdminDaoImpli();
ArrayList<Food> foodlist = adao.getAllFood();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MoonChees | Delicious Menu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #e63946;
            --primary-light: #ff6b7b;
            --primary-dark: #c1121f;
            --secondary-color: #f1faee;
            --accent-color: #a8dadc;
            --dark-color: #1d3557;
            --light-color: #f8f9fa;
            --success-color: #2a9d8f;
            --warning-color: #f4a261;
            --danger-color: #e76f51;
            --card-shadow: 0 10px 30px -15px rgba(0, 0, 0, 0.1);
            --card-hover-shadow: 0 15px 35px rgba(0,0,0,0.15);
            --transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            --border-radius: 12px;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #fef6f6;
            padding-top: 80px;
            margin: 0;
            color: #333;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .container {
            max-width: 1400px;
            padding: 0 20px;
        }

        /* Navbar Styles */
        .navbar {
            background-color: #fff !important;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.08);
            padding: 12px 0;
            transition: all 0.3s ease;
        }

        .navbar-scrolled {
            padding: 8px 0;
            box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);
        }

        .nav-link {
            font-weight: 500;
        }

        /* Hero Section */
        .hero {
            background: linear-gradient(135deg, rgba(230,57,70,0.08) 0%, rgba(241,250,238,0.6) 100%);
            padding: 80px 0 40px;
            margin-bottom: 20px;
            position: relative;
            overflow: hidden;
        }

        .hero-content {
            padding-right: 30px;
            position: relative;
            z-index: 2;
        }

        .hero h1 {
            font-weight: 700;
            margin-bottom: 20px;
        }

        .hero h1 span {
            color: var(--primary-color);
        }

        .hero p {
            font-size: 1.1rem;
            margin-bottom: 25px;
        }

        .hero-actions {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            margin-top: 20px;
        }

        .btn-hero {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: white;
            padding: 12px 28px;
            border-radius: 50px;
            border: none;
            font-weight: 500;
            transition: var(--transition);
        }

        .btn-hero:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(230, 57, 70, 0.3);
        }

        /* Food Grid */
        .food-grid-container {
            width: 100%;
            padding: 0 15px;
            margin: 0 auto;
        }
        
        .food-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 30px;
            width: 100%;
            justify-items: center;
            padding: 20px 0;
        }
        
        .food-card {
            width: 100%;
            max-width: 320px;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            overflow: hidden;
            transition: var(--transition);
            display: flex;
            flex-direction: column;
            height: 100%;
            border: 1px solid rgba(0,0,0,0.05);
        }

        .food-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--card-hover-shadow);
        }

        .food-image-container {
            height: 220px;
            overflow: hidden;
            position: relative;
        }

        .food-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .food-card:hover .food-image {
            transform: scale(1.1);
        }

        .food-details {
            padding: 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .food-details h3 {
            font-size: 1.25rem;
            margin-bottom: 10px;
            color: var(--dark-color);
        }

        .food-details p {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 15px;
            flex-grow: 1;
        }

        .food-price {
            font-size: 1.25rem;
            font-weight: 600;
        }

        /* Improved Quantity and Add to Cart Section */
        .food-actions {
            display: flex;
            gap: 10px;
            align-items: center;
            margin-top: 15px;
        }

        .quantity-selector {
            display: flex;
            align-items: center;
            background: #f8f9fa;
            border-radius: 8px;
            padding: 5px;
            border: 1px solid #eee;
        }

        .quantity-btn {
            width: 30px;
            height: 30px;
            border: none;
            background: #fff;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .quantity-btn:hover {
            background: #e9ecef;
        }

        .quantity-input {
            width: 40px;
            text-align: center;
            border: none;
            background: transparent;
            font-weight: 600;
            -moz-appearance: textfield;
        }

        .quantity-input::-webkit-outer-spin-button,
        .quantity-input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        .add-to-cart-btn {
            flex-grow: 1;
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: white;
            border: none;
            border-radius: 8px;
            padding: 8px 15px;
            font-weight: 500;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .add-to-cart-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(230, 57, 70, 0.2);
        }

        /* Carousel Improvements */
        .hero-carousel {
            height: 400px;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .carousel-item img {
            object-fit: cover;
            height: 100%;
            width: 100%;
        }

        .carousel-control-prev, 
        .carousel-control-next {
            width: 40px;
            height: 40px;
            background: rgba(0,0,0,0.2);
            border-radius: 50%;
            top: 50%;
            transform: translateY(-50%);
            opacity: 0.8;
            transition: all 0.3s;
        }

        .carousel-control-prev:hover, 
        .carousel-control-next:hover {
            background: rgba(0,0,0,0.4);
            opacity: 1;
        }

        /* Footer */
        footer {
            margin-top: auto;
        }

        /* Responsive fixes */
        @media (max-width: 1200px) {
            .food-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            }
            
            .hero-carousel {
                height: 350px;
            }
        }

        @media (max-width: 992px) {
            .hero {
                padding: 60px 0 30px;
            }
            
            .hero-content {
                padding-right: 0;
                margin-bottom: 30px;
            }
            
            .hero-carousel {
                height: 300px;
            }
        }

        @media (max-width: 768px) {
            .hero {
                text-align: center;
            }
            
            .hero-actions {
                justify-content: center;
            }
            
            .hero-actions .btn {
                width: auto;
                margin: 5px;
            }
            
            .food-grid {
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            }

            .navbar-brand img {
                width: 150px;
            }
            
            .hero-carousel {
                height: 250px;
            }
        }

        @media (max-width: 576px) {
            body {
                padding-top: 70px;
            }
            
            .hero h1 {
                font-size: 1.8rem;
            }
            
            .hero p {
                font-size: 1rem;
            }
            
            .hero-actions {
                flex-direction: column;
                align-items: center;
            }
            
            .hero-actions .btn {
                width: 100%;
                max-width: 250px;
            }
            
            .food-grid {
                grid-template-columns: 1fr;
            }

            .food-card {
                max-width: 100%;
            }
            
            .hero-carousel {
                height: 200px;
            }
        }

        /* Accessibility improvements */
        a:focus, button:focus {
            outline: 2px solid var(--primary-color);
            outline-offset: 2px;
        }

        /* Skip to content link */
        .skip-link {
            position: absolute;
            top: -40px;
            left: 0;
            background: var(--primary-color);
            color: white;
            padding: 8px;
            z-index: 100;
            transition: top 0.3s;
        }

        .skip-link:focus {
            top: 0;
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
    <!-- Skip to content link for accessibility -->
    <a href="#main-content" class="skip-link">Skip to main content</a>

    <!-- Header/Navbar -->
    <header class="navbar navbar-expand-lg navbar-light fixed-top shadow-sm">
        <div class="container">
            <a class="navbar-brand" href="home.jsp" aria-label="MoonChees Home">
                <img src="https://logos-world.net/wp-content/uploads/2020/04/McDonalds-Logo-700x394.png" alt="MoonChees Logo" width="180">
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="userhome.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="menu.jsp">Menu</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="about.jsp">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="contact.jsp">Contact</a>
                    </li>
                    
                    <% if(isLoggedIn) { %>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="navbarDropdown" 
                           role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-person-circle me-1"></i> <c:out value="${user.username}"/>
                            <span class="badge badge-admin ms-2">User</span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="profile.jsp">Profile</a></li>
                            <li><a class="dropdown-item" href="myorder.jsp">My Orders</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <form action="Logout" method="post">
                                    <button type="submit" class="dropdown-item">Logout</button>
                                </form>
                            </li>
                        </ul>
                    </li>
                    <li class="nav-item ms-2">
                        <a class="btn btn-outline-primary" href="cart.jsp">
                            <i class="bi bi-cart3"></i> Cart
                        </a>
                    </li>
                    <% } else { %>
                    <li class="nav-item ms-2">
                        <a class="btn btn-primary" href="login.jsp">Login</a>
                    </li>
                    <% } %>
                </ul>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main id="main-content">
        <!-- Hero Section with Carousel -->
        <section class="hero">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6 hero-content">
                        <h1 class="animate__animated animate__fadeInDown">Hey <span><%= username %></span>, Welcome to MoonChees!</h1>
                        <p class="animate__animated animate__fadeIn animate__delay-1s">Discover our delicious selection of gourmet dishes made with the freshest ingredients.</p>
                        <div class="hero-actions animate__animated animate__fadeInUp animate__delay-1s">
                            <a href="#menu" class="btn btn-hero">
                                <i class="bi bi-egg-fried me-2"></i>Explore Menu
                            </a>
                            <% if(isLoggedIn) { %>
                            <a href="profile.jsp" class="btn btn-outline-primary">
                                <i class="bi bi-person-circle me-2"></i>Profile
                            </a>
                            <% } %>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div id="heroCarousel" class="carousel slide hero-carousel" data-bs-ride="carousel">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <img src="https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80" 
                                         class="d-block w-100" 
                                         alt="Delicious Food">
                                </div>
                                <div class="carousel-item">
                                    <img src="https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80" 
                                         class="d-block w-100" 
                                         alt="Healthy Food">
                                </div>
                                <div class="carousel-item">
                                    <img src="https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80" 
                                         class="d-block w-100" 
                                         alt="Fresh Salad">
                                </div>
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Menu Section -->
        <div class="container" id="menu">
            <div class="text-center mb-5">
                <h2 class="display-5 fw-bold">Our Delicious Menu</h2>
                <p class="lead">Explore our wide selection of mouth-watering dishes</p>
            </div>
            
            <div class="food-grid-container">
                <% if(foodlist != null && !foodlist.isEmpty()) { %>
                <div class="food-grid">
                    <% for(Food food : foodlist) { %>
                    <div class="food-card animate__animated animate__fadeInUp">
                        <div class="food-image-container">
                            <img src="<%= food.getFood_image() %>" 
                                 class="food-image"
                                 alt="<%= food.getFood_name() %>">
                        </div>
                        <div class="food-details">
                            <h3><%= food.getFood_name() %></h3>
                            <p><%= food.getFood_desc() %></p>
                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <span class="badge bg-primary"><%= food.getFood_category() %></span>
                                <span class="h5 text-danger">₹<%= String.format("%.2f", food.getFood_price()) %></span>
                            </div>
                            <% if(isLoggedIn) { %>
                            <form action="AddToCart" method="post" class="mt-3">
                                <input type="hidden" name="fid" value="<%= food.getFood_id() %>">
                                <input type="hidden" name="uid" value="<%= user.getUserId() %>">
                                <div class="food-actions">
                                    <div class="quantity-selector">
                                        <button type="button" class="quantity-btn minus" onclick="adjustQuantity(this, -1)">-</button>
                                        <input type="number" name="quantity" value="1" min="1" max="10" class="quantity-input">
                                        <button type="button" class="quantity-btn plus" onclick="adjustQuantity(this, 1)">+</button>
                                    </div>
                                    <button type="submit" class="add-to-cart-btn">
                                        <i class="bi bi-cart-plus"></i> Add
                                    </button>
                                </div>
                            </form>
                            <% } else { %>
                            <button class="add-to-cart-btn w-100 mt-3" onclick="showLoginPrompt()">
                                <i class="bi bi-cart-plus"></i> Add to Cart
                            </button>
                            <% } %>
                        </div>
                    </div>
                    <% } %>
                </div>
                <% } else { %>
                <div class="col-12 text-center py-5">
                    <i class="bi bi-emoji-frown display-4 text-muted"></i>
                    <h3 class="mt-3">No food items available</h3>
                    <p>We're currently updating our menu. Please check back later.</p>
                </div>
                <% } %>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-dark text-white py-5 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-4">
                    <h5>MoonChees</h5>
                    <p>Delicious food made with love since 2023.</p>
                </div>
                <div class="col-md-4 mb-4">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="userhome.jsp" class="text-white">Home</a></li>
                        <li><a href="menu.jsp" class="text-white">Menu</a></li>
                        <li><a href="about.jsp" class="text-white">About</a></li>
                        <li><a href="contact.jsp" class="text-white">Contact</a></li>
                    </ul>
                </div>
                <div class="col-md-4 mb-4">
                    <h5>Contact</h5>
                    <p><i class="bi bi-geo-alt me-2"></i> 123 Food Street, Food City</p>
                    <p><i class="bi bi-envelope me-2"></i> contact@moonchees.com</p>
                    <p><i class="bi bi-telephone me-2"></i> +91 1234567890</p>
                </div>
            </div>
            <hr class="my-4 bg-light">
            <div class="text-center">
                <p>&copy; 2023 MoonChees. All rights reserved.</p>
                <div class="social-icons mt-3">
                    <a href="#" class="text-white me-3" aria-label="Facebook"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="text-white me-3" aria-label="Instagram"><i class="bi bi-instagram"></i></a>
                    <a href="#" class="text-white me-3" aria-label="Twitter"><i class="bi bi-twitter"></i></a>
                    <a href="#" class="text-white" aria-label="LinkedIn"><i class="bi bi-linkedin"></i></a>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Navbar scroll effect
        window.addEventListener('scroll', function() {
            const navbar = document.querySelector('.navbar');
            if (window.scrollY > 50) {
                navbar.classList.add('navbar-scrolled');
            } else {
                navbar.classList.remove('navbar-scrolled');
            }
        });

        // Login prompt function
        function showLoginPrompt() {
            if(confirm('Please login to add items to your cart. Would you like to go to the login page now?')) {
                window.location.href = 'login.jsp?redirect=' + encodeURIComponent(window.location.pathname);
            }
        }

        // Quantity adjustment function
        function adjustQuantity(button, change) {
            const container = button.closest('.quantity-selector');
            const input = container.querySelector('.quantity-input');
            let value = parseInt(input.value) + change;
            
            // Ensure value stays within min/max bounds
            value = Math.max(parseInt(input.min || 1), Math.min(value, parseInt(input.max || 10)));
            input.value = value;
        }

        // Initialize tooltips
        document.addEventListener('DOMContentLoaded', function() {
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });
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

        // Initialize carousel with interval
        document.addEventListener('DOMContentLoaded', function() {
            var heroCarousel = new bootstrap.Carousel(document.getElementById('heroCarousel'), {
                interval: 3000,
                ride: 'carousel'
            });
        });
    </script>
</body>
</html>