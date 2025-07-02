<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%@ page import="com.mcd.models.Dto.User" %>
<% 
User user = (User) session.getAttribute("pass");
boolean isLoggedIn = (user != null);
String username = isLoggedIn ? user.getName() : "Guest";
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About McDonald's</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Combined Styles */
        :root {
            --primary-color: #DA291C; /* McDonald's red */
            --primary-light: #FF6B7B;
            --primary-dark: #C1121F;
            --secondary-color: #f1faee;
            --accent-color: #FFC72C; /* McDonald's yellow */
            --dark-color: #27251F; /* McDonald's dark */
            --light-color: #F5F5F5;
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
            background-color: var(--light-color);
            padding-top: 80px;
            margin: 0;
            color: var(--dark-color);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
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

        /* About Page Specific Styles */
        .about-header {
            background-color: var(--primary-color);
            color: white;
            padding: 60px 0 30px;
            text-align: center;
            margin-bottom: 30px;
        }
        
        .logo {
            width: 150px;
            margin-bottom: 20px;
        }
        
        .about-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            flex: 1;
        }
        
        .about-section {
            background-color: white;
            border-radius: var(--border-radius);
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: var(--card-shadow);
        }
        
        .about-section h1 {
            color: var(--primary-color);
            margin-bottom: 20px;
            font-weight: 700;
        }
        
        .about-section h2 {
            color: var(--accent-color);
            border-bottom: 2px solid var(--accent-color);
            padding-bottom: 10px;
            margin-top: 30px;
            font-weight: 600;
        }
        
        .history-timeline {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin-top: 20px;
            gap: 20px;
        }
        
        .timeline-item {
            flex: 1 1 300px;
            margin-bottom: 20px;
            background-color: var(--light-color);
            padding: 20px;
            border-radius: var(--border-radius);
            border-left: 4px solid var(--primary-color);
            box-shadow: var(--card-shadow);
            transition: var(--transition);
        }
        
        .timeline-item:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-hover-shadow);
        }
        
        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 30px;
            margin-top: 20px;
        }
        
        .team-member {
            background-color: white;
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--card-shadow);
            text-align: center;
            transition: var(--transition);
        }
        
        .team-member:hover {
            transform: translateY(-10px);
            box-shadow: var(--card-hover-shadow);
        }
        
        .team-member img {
            width: 100%;
            height: 250px;
            object-fit: cover;
        }
        
        .team-member h3 {
            margin: 15px 0 5px;
            color: var(--primary-color);
            font-weight: 600;
        }
        
        .team-member p {
            color: var(--dark-color);
            padding: 0 15px 15px;
            font-size: 14px;
        }

        /* Responsive fixes */
        @media (max-width: 768px) {
            .about-header {
                padding: 40px 0 20px;
            }
            
            .history-timeline {
                flex-direction: column;
            }
            
            .team-grid {
                grid-template-columns: 1fr 1fr;
            }
        }

        @media (max-width: 576px) {
            .about-header {
                padding: 30px 0 15px;
            }
            
            .team-grid {
                grid-template-columns: 1fr;
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
    <!-- Skip to content link for accessibility -->
    <a href="#main-content" class="skip-link visually-hidden">Skip to main content</a>

    <!-- Header/Navbar -->
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
                        <a class="nav-link active" aria-current="page" href="about.jsp">About</a>
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

    <!-- About Page Content -->
    <main class="about-header">
        <img src="https://www.mcdonalds.com/content/dam/sites/usa/nfl/icons/arches-logo_108x108.jpg" alt="McDonald's Logo" class="logo" width="108" height="108">
        <h1>About McDonald's</h1>
    </main>
    
    <div class="about-container" id="main-content">
        <section class="about-section">
            <h2>Our Story</h2>
            <p>Welcome to McDonald's, the global fast-food restaurant chain serving millions of customers daily in over 100 countries. Since our founding in 1940 as a barbecue restaurant operated by Richard and Maurice McDonald, we've grown to become one of the world's most recognized brands.</p>
            
            <p>In 1948, we reorganized our business as a hamburger stand, using production line principles. Our first franchise opened in 1953, and today we operate over 38,000 locations worldwide, employing more than 200,000 people.</p>
        </section>
        
        <section class="about-section">
            <h2>Our Mission</h2>
            <p>Our mission is to be our customers' favorite place and way to eat and drink. We're committed to serving high-quality, great-tasting food at affordable prices while providing exceptional service in clean, welcoming environments.</p>
            
            <p>We strive to continuously improve our operations and customer experience, innovate our menu to meet changing tastes, and make a positive impact in all the communities we serve.</p>
        </section>
        
        <section class="about-section">
            <h2>Our History</h2>
            <div class="history-timeline">
                <div class="timeline-item">
                    <h3>1940</h3>
                    <p>Richard and Maurice McDonald open the first McDonald's restaurant in San Bernardino, California.</p>
                </div>
                <div class="timeline-item">
                    <h3>1955</h3>
                    <p>Ray Kroc opens the first franchised McDonald's in Des Plaines, Illinois, and later purchases the company.</p>
                </div>
                <div class="timeline-item">
                    <h3>1965</h3>
                    <p>McDonald's Corporation goes public with its first stock offering at $22.50 per share.</p>
                </div>
                <div class="timeline-item">
                    <h3>1975</h3>
                    <p>The first McDonald's Drive-Thru opens in Sierra Vista, Arizona to serve military personnel.</p>
                </div>
                <div class="timeline-item">
                    <h3>1984</h3>
                    <p>McDonald's serves its 50 billionth hamburger and introduces Chicken McNuggets nationwide.</p>
                </div>
                <div class="timeline-item">
                    <h3>Today</h3>
                    <p>With over 38,000 locations worldwide, McDonald's serves approximately 69 million customers daily.</p>
                </div>
            </div>
        </section>
        
        <section class="about-section">
            <h2>Our Values</h2>
            <ul>
                <li><strong>Quality:</strong> We're passionate about our food and take great care that what we serve every day is safe, great quality, and produced in a responsible way.</li>
                <li><strong>Service:</strong> We're proud to provide fast, accurate and friendly service to every customer.</li>
                <li><strong>Cleanliness:</strong> We ensure that our restaurants and facilities are always clean and welcoming.</li>
                <li><strong>Value:</strong> We're committed to providing our customers with affordable, high-quality food.</li>
                <li><strong>Community:</strong> We give back to our communities and support programs that positively impact them.</li>
            </ul>
        </section>
        
        <section class="about-section">
            <h2>Leadership Team</h2>
            <div class="team-grid">
                <div class="team-member">
                    <img src="https://media-exp1.licdn.com/dms/image/C5603AQEtIhev65R0Sg/profile-displayphoto-shrink_800_800/0/1614874745978?e=2147483647&v=beta&t=K-pdoRMMZ42tssns2kIY_sCL9s3brVeitez7U95jxEk" alt="CEO Chris Kempczinski">
                    <h3>Chris Kempczinski</h3>
                    <p>President and Chief Executive Officer</p>
                </div>
                <div class="team-member">
                    <img src="https://michiganross.umich.edu/sites/default/files/styles/person_portrait/public/images/coaches/ozan_headshot_2018_bb_v2.jpg?h=f803f42f&itok=5XQdibrQ" alt="CFO Kevin Ozan">
                    <h3>Kevin Ozan</h3>
                    <p>Chief Financial Officer</p>
                </div>
                <div class="team-member">
                    <img src="https://www.marketingdirecto.com/wp-content/uploads/2021/08/morgan-flatley-mcdonalds.jpg" alt="CMO Morgan Flatley">
                    <h3>Morgan Flatley</h3>
                    <p>Global Chief Marketing Officer</p>
                </div>
                <div class="team-member">
                    <img src="https://s3-rd-prod.chicagobusiness.com/styles/width_375/s3/Henry_Daniel_Cropweb.jpg" alt="CTO Daniel Henry">
                    <h3>Daniel Henry</h3>
                    <p>Chief Technology Officer</p>
                </div>
            </div>
        </section>
    </div>

    <!-- Footer -->
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
        // Navbar scroll effect
        window.addEventListener('scroll', function() {
            const navbar = document.querySelector('.navbar');
            if (window.scrollY > 50) {
                navbar.classList.add('navbar-scrolled');
            } else {
                navbar.classList.remove('navbar-scrolled');
            }
        });
    </script>
</body>
</html>