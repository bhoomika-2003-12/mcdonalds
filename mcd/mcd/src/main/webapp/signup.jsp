<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - McDonald's</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.21.0/jquery.validate.min.js"></script>
    <style>
        :root {
            --mcd-red: #DA291C;
            --mcd-yellow: #FFC72C;
            --mcd-dark: #27251F;
            --mcd-light: #F5F5F5;
        }
        
        body {
            font-family: 'Helvetica Neue', Arial, sans-serif;
            background-color: var(--mcd-light);
            background-image: url('https://images.unsplash.com/photo-1600891964599-f61ba0e24092?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            background-blend-mode: overlay;
            background-color: rgba(245, 245, 245, 0.9);
            min-height: 100vh;
        }
        
        .mcd-logo {
            width: 120px;
            margin-bottom: 20px;
            filter: drop-shadow(0 2px 4px rgba(0,0,0,0.2));
        }
        
        .container-wrapper {
            display: flex;
            min-height: 100vh;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .signup-container {
            padding: 40px;
            max-width: 500px;
            width: 100%;
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            border-top: 8px solid var(--mcd-red);
            backdrop-filter: blur(5px);
            position: relative;
            overflow: hidden;
        }
        
        .signup-container::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 8px;
            background: linear-gradient(90deg, 
                var(--mcd-red) 0%, 
                var(--mcd-yellow) 50%, 
                var(--mcd-red) 100%);
        }
        
        .signup-header {
            text-align: center;
            margin-bottom: 30px;
            position: relative;
            z-index: 1;
        }
        
        .signup-header h2 {
            color: var(--mcd-red);
            font-weight: 700;
            margin-bottom: 10px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .signup-header p {
            color: var(--mcd-dark);
            font-size: 1.1rem;
        }
        
        .form-control {
            height: 50px;
            border-radius: 8px;
            border: 1px solid #ddd;
            padding-left: 15px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
            background-color: rgba(255, 255, 255, 0.8);
        }
        
        .form-control:focus {
            border-color: var(--mcd-yellow);
            box-shadow: 0 0 0 0.25rem rgba(255, 199, 44, 0.3);
            background-color: white;
        }
        
        .btn-mcd {
            background-color: var(--mcd-red);
            color: white;
            border: none;
            height: 50px;
            border-radius: 8px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s;
            box-shadow: 0 4px 8px rgba(218, 41, 28, 0.3);
        }
        
        .btn-mcd:hover {
            background-color: #c8231a;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(218, 41, 28, 0.4);
        }
        
        .login-link {
            color: var(--mcd-red);
            text-decoration: none;
            font-weight: 600;
            transition: all 0.2s;
        }
        
        .login-link:hover {
            color: #c8231a;
            text-decoration: underline;
        }
        
        .form-group {
            position: relative;
            margin-bottom: 1.5rem;
        }
        
        .error {
            color: var(--mcd-red);
            font-size: 14px;
            margin-top: -15px;
            margin-bottom: 10px;
            display: block;
            font-weight: 500;
        }
        
        .input-icon {
            position: absolute;
            right: 15px;
            top: 15px;
            color: #aaa;
            transition: all 0.3s;
        }
        
        .form-control:focus + .input-icon {
            color: var(--mcd-yellow);
        }
        
        .date-input-container {
            position: relative;
        }
        
        .date-input-container input[type="date"] {
            appearance: none;
            -webkit-appearance: none;
            padding-right: 40px;
        }
        
        .date-input-container::after {
            content: "\f073";
            font-family: "Font Awesome 6 Free";
            font-weight: 900;
            position: absolute;
            right: 15px;
            top: 15px;
            color: #aaa;
            pointer-events: none;
            transition: all 0.3s;
        }
        
        .date-input-container input:focus + .input-icon,
        .date-input-container input:focus::after {
            color: var(--mcd-yellow);
        }
        
        .promo-text {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
            color: #666;
            background-color: rgba(255, 199, 44, 0.2);
            padding: 10px;
            border-radius: 8px;
            border-left: 4px solid var(--mcd-yellow);
        }
        
        .promo-text i {
            color: var(--mcd-yellow);
            margin-right: 5px;
        }
        
        .fries-decoration {
            position: absolute;
            width: 150px;
            opacity: 0.1;
            z-index: 0;
        }
        
        .fries-1 {
            top: -50px;
            right: -50px;
            transform: rotate(30deg);
        }
        
        .fries-2 {
            bottom: -30px;
            left: -30px;
            transform: rotate(-15deg);
        }
        
        @media (max-width: 576px) {
            .signup-container {
                padding: 30px 20px;
            }
            
            .fries-decoration {
                display: none;
            }
        }
    </style>
</head>

<body>
    <%String error = (String) request.getAttribute("fail"); if(error != null){ %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert" style="position: fixed; top: 20px; right: 20px; z-index: 1000; max-width: 400px;">
            <%=error %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <%} %>
    
    <div class="container-wrapper">
        <div class="signup-container">
            <img src="https://www.mcdonalds.com/content/dam/sites/usa/nfl/icons/fries.png" alt="Fries" class="fries-decoration fries-1">
            <img src="https://www.mcdonalds.com/content/dam/sites/usa/nfl/icons/fries.png" alt="Fries" class="fries-decoration fries-2">
            
            <div class="signup-header">
                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/McDonald%27s_Golden_Arches.svg/1200px-McDonald%27s_Golden_Arches.svg.png" alt="McDonald's Logo" class="mcd-logo">
                <h2>Join McDonald's Rewards</h2>
                <p>Sign up to earn points and get exclusive offers!</p>
            </div>
            
            <form id="signup-form" method="post" action="signup">
                <div class="form-group">
                    <input type="text" id="name" class="form-control" placeholder="Full Name" name="name" required>
                    <i class="fas fa-user input-icon"></i>
                </div>
                
                <div class="form-group">
                    <input type="email" id="email" class="form-control" placeholder="Email" name="email" required>
                    <i class="fas fa-envelope input-icon"></i>
                </div>
                
                <div class="form-group">
                    <input type="text" id="phone" class="form-control" placeholder="Phone Number" name="phone" required>
                    <i class="fas fa-phone input-icon"></i>
                </div>
                
                <div class="form-group date-input-container">
                    <input type="date" id="dob" class="form-control" name="dob" required>
                </div>
                
                <div class="form-group">
                    <input type="password" id="password" class="form-control" placeholder="Password" name="password" required>
                    <i class="fas fa-lock input-icon"></i>
                </div>
                
                <div class="form-group">
                    <input type="password" id="confirm-password" class="form-control" placeholder="Confirm Password" name="confirm" required>
                    <i class="fas fa-lock input-icon"></i>
                </div>
                
                <button type="submit" class="btn btn-mcd w-100 mb-3">
                    <i class="fas fa-hamburger me-2"></i> Sign Up Now
                </button>
                
                <div class="text-center mb-3">
                    <span>Already have an account? </span>
                    <a href="login.jsp" class="login-link">Log in</a>
                </div>
                
                <div class="promo-text">
                    <i class="fas fa-gift"></i> Get free large fries with your first order!
                </div>
            </form>
        </div>
    </div>

    <script>
    jQuery.validator.addMethod("checkemail", function(value, element) {
        return /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(value);
    });
   
    $(document).ready(function () {
        $("#signup-form").validate({
            rules: {
                name: {
                    required: true,
                    minlength: 3
                },
                phone: {
                    required: true,
                    minlength: 10,
                    maxlength: 10,
                    digits: true
                },
                email: {
                    required: true,
                    checkemail: true
                },
                dob: {
                    required: true,
                },
                password: {
                    required: true,
                    minlength: 6
                },
                confirm: {
                    required: true,
                    minlength: 6,
                    equalTo: "#password"
                }
            },
            messages: {
                name: {
                    required: "Please enter your name",
                    minlength: "Name should be at least 3 characters" 
                },
                phone: {
                    required: "Please enter your phone number",
                    minlength: "Your phone number must be exactly 10 digits",
                    maxlength: "Your phone number must be exactly 10 digits",
                    digits: "Please enter a valid phone number"
                },
                email: {
                    required: "Please enter your email",
                    checkemail: "Please enter a valid email address"
                },
                dob: {
                    required: "Please enter your date of birth"
                },
                password: {
                    required: "Please enter your password",
                    minlength: "Your password must be at least 6 characters long"
                },
                confirm: {
                    required: "Please confirm your password",
                    minlength: "Your password must be at least 6 characters long",
                    equalTo: "Passwords do not match"
                }
            },
            errorElement: "span",
            errorClass: "error",
            highlight: function(element, errorClass, validClass) {
                $(element).addClass("is-invalid").removeClass("is-valid");
                $(element).next('.input-icon').css('color', '#DA291C');
            },
            unhighlight: function(element, errorClass, validClass) {
                $(element).removeClass("is-invalid").addClass("is-valid");
                $(element).next('.input-icon').css('color', '#28a745');
            },
            submitHandler: function(form) {
                $('.btn-mcd').html('<i class="fas fa-spinner fa-spin me-2"></i> Processing...');
                $('.btn-mcd').prop('disabled', true);
                form.submit();
            }
        });

        // Format date input display
        $('#dob').on('change', function() {
            if (this.value) {
                this.setAttribute('data-value', this.value);
            }
        });
        
        // Close alert after 5 seconds
        setTimeout(function() {
            $('.alert').alert('close');
        }, 5000);
    });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>