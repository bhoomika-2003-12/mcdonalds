<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mcd.models.Dto.*" %>
<%@ page import="com.mcd.models.Dao.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Food Item</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            padding-top: 60px;
            background-color: #f8f9fa;
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

        .food-update-container {
            max-width: 800px;
            margin: 30px auto;
            padding: 30px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }

        .image-preview-container {
            position: relative;
            width: 100%;
            padding-top: 75%; /* 4:3 Aspect Ratio */
            overflow: hidden;
            border-radius: 10px;
            background-color: #f5f5f5;
            margin-bottom: 15px;
        }

        .food-image {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s;
        }

        .food-image:hover {
            transform: scale(1.03);
        }

        .alert-notification {
            position: fixed;
            top: 80px;
            right: 20px;
            z-index: 1000;
            min-width: 300px;
            animation: slideIn 0.3s ease-out;
        }

        @keyframes slideIn {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        .btn-submit {
            background-color: #dc3545;
            border: none;
            padding: 10px 25px;
            font-size: 1.1rem;
            transition: all 0.3s;
        }

        .btn-submit:hover {
            background-color: #c82333;
            transform: translateY(-2px);
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
            .navbar .nav-link {
                margin-right: 15px;
            }
        }

        @media (max-width: 480px) {
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
    <%
    // Prevent caching of this page
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    
    Food food = null;
    String message = (String) session.getAttribute("message");
    String messageType = (String) session.getAttribute("messageType");
    String foodId = request.getParameter("id");
    
    // Clear messages from session after retrieving
    if (message != null && messageType != null) {
        session.removeAttribute("message");
        session.removeAttribute("messageType");
    }
    
    try {
        if (foodId == null || foodId.isEmpty()) {
            throw new Exception("Food ID parameter is missing");
        }
        
        AdminDao adao = new AdminDaoImpli();
        food = adao.getFoodbyId(Integer.parseInt(foodId));
        
        if (food == null) {
            session.setAttribute("message", "Food item not found");
            session.setAttribute("messageType", "error");
            response.sendRedirect("foods.jsp");
            return;
        }
    } catch (Exception e) {
        session.setAttribute("message", "Error retrieving food: " + e.getMessage());
        session.setAttribute("messageType", "error");
        response.sendRedirect("foods.jsp");
        return;
    }
    %>

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

    <!-- Alert Container -->
    <div id="alertContainer">
        <% if (message != null && messageType != null) { %>
            <div class="alert alert-<%= messageType %> alert-notification alert-dismissible fade show">
                <strong><%= messageType.equals("success") ? "Success!" : "Error!" %></strong> <%= message %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>
    </div>

    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card p-4">
                    <h2 class="text-center mb-4">Update Food Item</h2>
                    
                    <form id="updateForm" action="UpdateFoodServlet" method="post">
                        <input type="hidden" name="foodId" value="<%= food.getFood_id() %>">
                        <input type="hidden" name="existingImage" value="<%= food.getFood_image() %>">
                        
                        <div class="row">
                            <!-- Left Column - Image -->
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Food Image</label>
                                    <div class="image-preview-container">
                                        <img src="<%= food.getFood_image() %>" 
                                             class="food-image"
                                             onerror="this.src='https://via.placeholder.com/400x300?text=No+Image+Available'"
                                             alt="<%= food.getFood_name() %>">
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="foodImage" class="form-label">Image URL</label>
                                        <input type="text" class="form-control" id="foodImage" name="foodImage" 
                                               value="<%= food.getFood_image() %>" required
                                               oninput="updateImagePreview(this.value)">
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Right Column - Form Fields -->
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="foodName" class="form-label">Food Name</label>
                                    <input type="text" class="form-control" id="foodName" name="foodName" 
                                           value="<%= food.getFood_name() %>" required>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="foodDescription" class="form-label">Description</label>
                                    <textarea class="form-control" id="foodDescription" name="foodDescription" 
                                              rows="3" required><%= food.getFood_desc() %></textarea>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="foodPrice" class="form-label">Price</label>
                                        <input type="number" step="0.01" class="form-control" id="foodPrice" name="foodPrice" 
                                               value="<%= food.getFood_price() %>" required min="0.01">
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="foodType" class="form-label">Type</label>
                                        <select class="form-select" id="foodType" name="foodType" required>
                                            <option value="Veg" <%= "Veg".equals(food.getFood_type()) ? "selected" : "" %>>Vegetarian</option>
                                            <option value="Non-Veg" <%= "Non-Veg".equals(food.getFood_type()) ? "selected" : "" %>>Non-Vegetarian</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="foodCategory" class="form-label">Category</label>
                                    <select class="form-select" id="foodCategory" name="foodCategory" required>
                                        <option value="Starter" <%= "Starter".equals(food.getFood_category()) ? "selected" : "" %>>Starter</option>
                                        <option value="Main Course" <%= "Main Course".equals(food.getFood_category()) ? "selected" : "" %>>Main Course</option>
                                        <option value="Dessert" <%= "Dessert".equals(food.getFood_category()) ? "selected" : "" %>>Dessert</option>
                                        <option value="Beverage" <%= "Beverage".equals(food.getFood_category()) ? "selected" : "" %>>Beverage</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        
                        <div class="d-flex justify-content-between mt-4">
                            <a href="foods.jsp" class="btn btn-outline-secondary">Back</a>
                            <button type="submit" class="btn btn-submit text-white">Update Food</button>
                        </div>
                    </form>
                </div>
            </div>
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
        // Update image preview when URL changes
        function updateImagePreview(imageUrl) {
            const preview = document.querySelector('.food-image');
            if (preview) {
                preview.src = imageUrl;
            }
        }

        // Form validation
        function validateForm() {
            const price = document.getElementById('foodPrice').value;
            if (price <= 0) {
                alert('Price must be greater than 0');
                return false;
            }
            return true;
        }

        // Auto-dismiss alerts after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            const alerts = document.querySelectorAll('.alert-notification');
            alerts.forEach(alert => {
                setTimeout(() => {
                    alert.classList.remove('show');
                    setTimeout(() => alert.remove(), 150);
                }, 5000);
            });
            
            // Initialize image preview with current URL
            const currentImageUrl = document.getElementById('foodImage').value;
            updateImagePreview(currentImageUrl);

            // Prevent form resubmission
            if (window.history.replaceState) {
                window.history.replaceState(null, null, window.location.href);
            }

            // Handle form submission
            document.getElementById('updateForm').addEventListener('submit', function(e) {
                if (!validateForm()) {
                    e.preventDefault();
                    return false;
                }
                return true;
            });
        });
    </script>
</body>
</html>