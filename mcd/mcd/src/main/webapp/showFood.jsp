<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mcd.models.Dto.*" %>
<%@ page import="com.mcd.models.Dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>McDonald's Food Items</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
<style>
    body {
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding-top: 60px;
        background-color: #f8f8f8;
        min-height: 100vh;
        transition: all 0.3s ease;
    }

    /* Navbar Styles */
    .navbar {
        background-color: #fff !important;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    }

    .navbar .nav-link {
        color: #333 !important;
        font-weight: 500;
        margin-right: 30px;
        transition: color 0.3s ease;
    }

    .navbar .nav-link:hover {
        color: #da291c !important;
    }

    .container {
        width: 90%;
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }

    h1 {
        color: #da291c;
        text-align: center;
        margin: 20px 0 30px;
        font-size: 2.2rem;
    }

    .message {
        text-align: center;
        padding: 15px 25px;
        border-radius: 8px;
        max-width: 800px;
        margin: 0 auto 20px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .success {
        background-color: #d4edda;
        color: #155724;
    }

    .error {
        background-color: #f8d7da;
        color: #721c24;
    }

    .food-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        justify-content: center;
        gap: 30px;
        width: 100%;
    }

    .food-card {
        background: white;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        overflow: hidden;
        transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        max-width: 320px;
        margin: 0 auto;
        width: 100%;
        position: relative;
        transform-origin: center bottom;
        will-change: transform;
    }

    .food-card:hover {
        transform: scale(1.05) translateY(-10px);
        box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        z-index: 10;
    }

    .food-image-container {
        height: 200px;
        overflow: hidden;
        position: relative;
    }

    .food-image {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        transform-origin: center center;
    }

    .food-card:hover .food-image {
        transform: scale(1.1);
    }

    .food-details {
        padding: 20px;
        position: relative;
        z-index: 2;
        background: white;
    }

    .food-name {
        font-size: 1.25rem;
        font-weight: bold;
        color: #da291c;
        margin: 0 0 10px 0;
        transition: color 0.3s ease;
    }

    .food-card:hover .food-name {
        color: #b82218;
    }

    .food-desc {
        color: #555;
        font-size: 0.95rem;
        margin: 0 0 12px 0;
        line-height: 1.4;
    }

    .food-meta {
        display: flex;
        justify-content: space-between;
        color: #666;
        font-size: 0.85rem;
        margin-bottom: 15px;
        padding: 10px 0;
        border-top: 1px solid #eee;
        border-bottom: 1px solid #eee;
    }

    .food-price {
        font-size: 1.4rem;
        color: #da291c;
        font-weight: bold;
        margin: 10px 0 15px;
        transition: transform 0.3s ease;
    }

    .food-card:hover .food-price {
        transform: scale(1.05);
    }

    .action-buttons {
        display: flex;
        gap: 10px;
    }

    .btn {
        padding: 10px 15px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-weight: bold;
        transition: all 0.3s;
        flex: 1;
        text-align: center;
        text-decoration: none;
        font-size: 0.9rem;
        transform: translateY(0);
    }

    .food-card:hover .btn {
        transform: translateY(-2px);
    }

    .btn-update {
        background-color: #ffc72c;
        color: #27251f;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .btn-update:hover {
        background-color: #e6b400;
        box-shadow: 0 4px 8px rgba(0,0,0,0.2);
    }

    .btn-delete {
        background-color: #da291c;
        color: white;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .btn-delete:hover {
        background-color: #b82218;
        box-shadow: 0 4px 8px rgba(0,0,0,0.2);
    }

    .no-items {
        text-align: center;
        padding: 50px;
        color: #666;
        font-size: 1.2rem;
        background: white;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        width: 100%;
        margin: 0 auto;
    }

    /* Footer Styles */
    .footer {
        background-color: #fff;
        color: #333;
        padding: 40px 0;
        font-size: 16px;
        border-top: 2px solid #ddd;
        margin-top: 50px;
    }

    .footer h5 {
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 15px;
    }

    .footer-link {
        color: #333;
        text-decoration: none;
        transition: color 0.3s ease;
    }

    .footer-link:hover {
        color: #da291c;
    }

    .social-icon {
        color: #333;
        font-size: 20px;
        margin-left: 10px;
        transition: color 0.3s ease;
    }

    .social-icon:hover {
        color: #da291c;
    }

    @media (max-width: 768px) {
        .food-grid {
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
        }
        
        .navbar .nav-link {
            margin-right: 15px;
        }
    }

    @media (max-width: 480px) {
        .food-grid {
            grid-template-columns: 1fr;
            gap: 15px;
        }
        
        .container {
            width: 95%;
            padding: 10px;
        }
        
        .food-card:hover {
            transform: scale(1.03) translateY(-5px);
        }
        
        .food-card:hover .food-image {
            transform: scale(1.05);
        }
        
        .footer {
            text-align: center;
        }
        
        .footer .col-md-4 {
            margin-bottom: 20px;
        }
    }
</style>
</head>
<body>
<!-- Header Section -->
<header class="navbar navbar-expand-lg shadow fixed-top">
    <div class="container">
        <!-- LOGO -->
        <a class="navbar-brand fw-bold" href="admin.jsp">
            <img src="https://logos-world.net/wp-content/uploads/2020/04/McDonalds-Logo-700x394.png" width="200" alt="Logo">
        </a>

        <!-- NAVBAR TOGGLER -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- NAVBAR ITEMS -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto d-flex align-items-center">
                <li class="nav-item mx-1"><a class="nav-link" href="admin.jsp">Home</a></li>
                <li class="nav-item mx-1"><a class="nav-link active" href="foods.jsp">Foods</a></li>
                <li class="nav-item mx-1"><a class="nav-link" href="orders.jsp">Orders</a></li>
                <li class="nav-item mx-1"><a class="nav-link" href="customers.jsp">Customers</a></li>
                
                <!-- LOGOUT BUTTON -->
                <li class="nav-item mx-2">
                    <a href="logout.jsp" class="btn btn-danger">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</header>

<div class="container">
    <h1>McDonald's Menu Management</h1>

    <%-- Display success/error messages if any --%>
    <% if(request.getAttribute("message") != null) { %>
        <div class="message <%= request.getAttribute("messageType") %>">
            <%= request.getAttribute("message") %>
        </div>
    <% } %>

    <% 
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    
    Food f = new Food(); 
    AdminDao adao = new AdminDaoImpli();
    ArrayList<Food> foodlist = adao.getAllFood(); 
    %>

    <div class="food-grid">
        <% if(foodlist != null && !foodlist.isEmpty()) { 
            for(Food food : foodlist) { %>
            <div class="food-card">
                <div class="food-image-container">
                    <img src="<%= food.getFood_image() %>" 
                         alt="<%= food.getFood_name() %>" 
                         class="food-image">
                </div>
                <div class="food-details">
                    <h3 class="food-name"><%= food.getFood_name() %></h3>
                    <p class="food-desc"><%= food.getFood_desc() %></p>
                    <div class="food-meta">
                        <span>Type: <%= food.getFood_type() %></span>
                        <span>Category: <%= food.getFood_category() %></span>
                    </div>
                    <div class="food-price">₹<%= String.format("%.2f", food.getFood_price()) %></div>
                    <div class="action-buttons">
                        <a href="updateFood.jsp?id=<%= food.getFood_id() %>" class="btn btn-update">Update</a>
                        <form action="DeleteFoodServlet" method="post" style="display:inline; margin:0; flex:1;">
                            <input type="hidden" name="foodId" value="<%= food.getFood_id() %>">
                            <button type="submit" class="btn btn-delete" onclick="return confirm('Are you sure you want to delete this item?')">Delete</button>
                        </form>
                    </div>
                </div>
            </div>
        <% } 
           } else { %>
            <div class="no-items">No food items found</div>
        <% } %>
    </div>
</div>

<!-- Footer -->
<footer class="footer py-4">
    <div class="container">
        <div class="row">
            <div class="col-md-4 text-start">
                <h5>About McDonald's</h5>
                <p>Quality ingredients, signature recipes, and a commitment to serving delicious food.</p>
            </div>
            <div class="col-md-4 text-center">
                <h5>Quick Links</h5>
                <ul class="list-unstyled">
                    <li><a href="admin.jsp" class="footer-link">Home</a></li>
                    <li><a href="foods.jsp" class="footer-link">Foods</a></li>
                    <li><a href="orders.jsp" class="footer-link">Orders</a></li>
                    <li><a href="customers.jsp" class="footer-link">Customers</a></li>
                </ul>
            </div>
            <div class="col-md-4 text-end">
                <h5>Follow Us</h5>
                <a href="#" class="social-icon"><i class="bi bi-facebook"></i></a>
                <a href="#" class="social-icon"><i class="bi bi-instagram"></i></a>
                <a href="#" class="social-icon"><i class="bi bi-twitter"></i></a>
            </div>
        </div>
        <div class="text-center mt-3">
            <p>&copy; 2023 McDonald's | All Rights Reserved</p>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Prevent form resubmission on page refresh
    if (window.history.replaceState) {
        window.history.replaceState(null, null, window.location.href);
    }
    
    // Add animation class when cards come into view
    document.addEventListener('DOMContentLoaded', function() {
        const cards = document.querySelectorAll('.food-card');
        
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = 1;
                    entry.target.style.transform = 'scale(1) translateY(0)';
                }
            });
        }, { threshold: 0.1 });
        
        cards.forEach(card => {
            card.style.opacity = 0;
            card.style.transform = 'scale(0.95) translateY(20px)';
            card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
            observer.observe(card);
        });
    });
</script>
</body>
</html>