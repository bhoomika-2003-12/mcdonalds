<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%@ page import="com.mcd.models.Dto.User" %>
<% 
User user = (User) session.getAttribute("pass");
boolean isLoggedIn = (user != null);
String username = isLoggedIn ? user.getName() : "Guest";
String email = isLoggedIn ? user.getEmail() : "";
String success=(String)request.getAttribute("success");
String fail=(String)request.getAttribute("fail");
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact McDonald's</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">
    <style>
        :root {
            --primary-color: #DA291C;
            --accent-color: #FFC72C;
            --dark-color: #27251F;
            --light-color: #F5F5F5;
            --card-shadow: 0 10px 30px -15px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--light-color);
            padding-top: 80px;
            color: var(--dark-color);
        }
        
        .contact-header {
            background-color: var(--primary-color);
            color: white;
            padding: 60px 0;
            text-align: center;
            margin-bottom: 40px;
        }
        
        .contact-container {
            max-width: 1000px;
            margin: 0 auto 50px;
            padding: 0 20px;
        }
        
        .contact-card {
            background: white;
            border-radius: 10px;
            box-shadow: var(--card-shadow);
            padding: 30px;
            margin-bottom: 30px;
        }
        
        .contact-card h2 {
            color: var(--primary-color);
            margin-bottom: 20px;
            font-weight: 600;
        }
        
        .form-label {
            font-weight: 500;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .btn-primary:hover {
            background-color: var(--accent-color);
            border-color: var(--accent-color);
            color: var(--dark-color);
        }
        
        .contact-info-card {
            background-color: var(--light-color);
            border-radius: 10px;
            padding: 25px;
            height: 100%;
            transition: var(--transition);
        }
        
        .contact-info-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow);
        }
        
        .contact-info-card i {
            font-size: 2rem;
            color: var(--primary-color);
            margin-bottom: 15px;
        }
        
        .complaint-categories {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 20px;
        }
        
        .complaint-category-btn {
            border: 1px solid #ddd;
            border-radius: 20px;
            padding: 5px 15px;
            background: white;
            cursor: pointer;
            transition: var(--transition);
        }
        
        .complaint-category-btn:hover, 
        .complaint-category-btn.active {
            background: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }
        
        @media (max-width: 768px) {
            .contact-header {
                padding: 40px 0;
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
    <!-- Header/Navbar (same as about page) -->
    <header class="navbar navbar-expand-lg navbar-light fixed-top shadow-sm">
        <div class="container">
            <a class="navbar-brand" href="home.jsp" aria-label="McDonald's Home">
                <img src="https://www.mcdonalds.com/content/dam/sites/usa/nfl/icons/arches-logo_108x108.jpg" alt="McDonald's Logo" width="40" height="40">
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
                        <a class="nav-link" href="menu.jsp">Menu</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="about.jsp">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="contact.jsp">Contact</a>
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

    <!-- Contact Header -->
    <div class="contact-header">
        <div class="container">
            <h1 class="animate__animated animate__fadeInDown">We're Here to Help</h1>
            <p class="lead animate__animated animate__fadeInUp animate__delay-1s">Have feedback or a complaint? Let us know how we can improve your experience.</p>
        </div>
    </div>
    
    <% if(success != null && !success.isEmpty()) { %>
<div class="container mt-4 auto-hide">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="bi bi-check-circle-fill me-2"></i> <%= success %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</div>
<% } %>

<% if(fail != null && !fail.isEmpty()) { %>
<div class="container mt-4 auto-hide">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="bi bi-exclamation-triangle-fill me-2"></i> <%= fail %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</div>
<% } %>
    
    

    <!-- Contact Content -->
    <div class="contact-container">
        <div class="row">
            <!-- Complaint Form -->
            <div class="col-lg-8">
                <div class="contact-card">
                    <h2>Submit a Complaint</h2>
                    <p>Please fill out the form below and we'll get back to you within 24-48 hours.</p>
                    
                    <form id="complaintForm" action="complaint" method="post">
                        <% if(isLoggedIn) { %>
                        <input type="hidden" name="userId" value="<%= user.getUserId() %>">
                        <% } %>
                        
                        <div class="mb-3">
                            <label for="name" class="form-label">Your Name</label>
                            <input type="text" class="form-control" id="name" name="name" 
                                value="<%= isLoggedIn ? username : "" %>" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="email" class="form-label">Email Address</label>
                            <input type="email" class="form-control" id="email" name="email" 
                                value="<%=isLoggedIn ? email : "" %>" required>
                        </div>
                         <div class="mb-3">
                            <label for="subject" class="form-label">Subject</label>
                            <input type="text" class="form-control" id="subject" name="subject" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="message" class="form-label">Detailed Description</label>
                            <textarea class="form-control" id="message" name="message" rows="5" required></textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label for="orderNumber" class="form-label">Order Number (if applicable)</label>
                            <input type="text" class="form-control" id="orderNumber" name="orderNumber">
                        </div>
                        
                        <div class="mb-3">
                            <label for="location" class="form-label">Restaurant Location (if applicable)</label>
                            <input type="text" class="form-control" id="location" name="location" 
                                placeholder="City or specific restaurant address">
                        </div>
                        
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="followUp" name="followUp">
                            <label class="form-check-label" for="followUp">I would like a follow-up call regarding this complaint</label>
                        </div>
                        
                        <input type="submit" class="btn btn-primary btn-lg" value="Submit Complaint"/>
                        </form>
                </div>
            </div>
            
            <!-- Contact Information -->
            <div class="col-lg-4">
                <div class="contact-info-card mb-4">
                    <i class="bi bi-telephone"></i>
                    <h3>Call Us</h3>
                    <p>Our customer service team is available 24/7</p>
                    <p><strong>1-800-244-6227</strong></p>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer (same as about page) -->
    <footer class="bg-dark text-white py-5">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-4">
                    <h5>McDonald's</h5>
                    <p>Delicious food made with love since 1940.</p>
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
                    <p><i class="bi bi-geo-alt me-2"></i> 123 McDonald's Street, Chicago, IL</p>
                    <p><i class="bi bi-envelope me-2"></i> contact@mcdonalds.com</p>
                    <p><i class="bi bi-telephone me-2"></i> +1 (800) 244-6227</p>
                </div>
            </div>
            <hr class="my-4 bg-light">
            <div class="text-center">
                <p>&copy; 2023 McDonald's Corporation. All rights reserved.</p>
                <div class="social-icons mt-3">
                    <a href="https://www.facebook.com/McDonalds/" class="text-white me-3" aria-label="Facebook"><i class="bi bi-facebook"></i></a>
                    <a href="https://www.instagram.com/mcdonalds/" class="text-white me-3" aria-label="Instagram"><i class="bi bi-instagram"></i></a>
                    <a href="https://twitter.com/McDonalds" class="text-white me-3" aria-label="Twitter"><i class="bi bi-twitter"></i></a>
                    <a href="https://www.linkedin.com/company/mcdonald's-corporation" class="text-white" aria-label="LinkedIn"><i class="bi bi-linkedin"></i></a>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Auto-dismiss alerts after delay
        // Auto-dismiss alerts after delay
document.addEventListener('DOMContentLoaded', function() {
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => {
        // Bootstrap's built-in method to auto-hide alerts
        setTimeout(() => {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        }, 3000); // 3 seconds
    });
});
    </script>
    
</body>
</html>