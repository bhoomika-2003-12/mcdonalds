<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password - McDonald's</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <style>
        :root {
            --mcd-red: #DA291C;
            --mcd-yellow: #FFC72C;
            --mcd-dark: #27251F;
            --mcd-light: #F5F5F5;
            --mcd-green: #4B8A2D;
            --shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        body {
            font-family: 'Helvetica Neue', Arial, sans-serif;
            background: url("https://wallpapercave.com/wp/wp1919500.jpg") no-repeat center center/cover;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            padding: 20px;
            color: var(--mcd-dark);
        }
        
        .auth-container {
            display: flex;
            max-width: 1000px;
            width: 100%;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: var(--shadow);
            animation: fadeIn 0.8s ease-in-out;
        }
        
        .auth-image {
            flex: 1;
            background: url('https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80') no-repeat center center/cover;
            position: relative;
            display: none;
        }
        
        .auth-image::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(218, 41, 28, 0.8);
        }
        
        .auth-content {
            flex: 1;
            padding: 40px;
            background: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            position: relative;
        }
        
        .mcd-logo {
            position: absolute;
            top: 20px;
            left: 40px;
            height: 40px;
        }
        
        .auth-header {
            margin-bottom: 30px;
            text-align: center;
            margin-top: 40px;
        }
        
        .auth-header h2 {
            font-weight: 700;
            color: var(--mcd-red);
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .auth-header p {
            color: #666;
        }
        
        .form-control {
            height: 50px;
            border-radius: 8px;
            border: 2px solid #ddd;
            padding-left: 15px;
            transition: all 0.3s;
            margin-bottom: 20px;
        }
        
        .form-control:focus {
            border-color: var(--mcd-yellow);
            box-shadow: 0 0 0 3px rgba(255, 199, 44, 0.3);
        }
        
        .form-label {
            font-weight: 600;
            margin-bottom: 8px;
            display: block;
            color: var(--mcd-dark);
        }
        
        .btn-auth {
            background: var(--mcd-red);
            border: none;
            color: white;
            height: 50px;
            border-radius: 8px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s;
            margin-top: 10px;
        }
        
        .btn-auth:hover {
            background: #c82419;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(218, 41, 28, 0.3);
            color: white;
        }
        
        .auth-footer {
            text-align: center;
            margin-top: 20px;
            color: #666;
        }
        
        .auth-footer a {
            color: var(--mcd-red);
            font-weight: 600;
            text-decoration: none;
        }
        
        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #666;
        }
        
        .input-group {
            position: relative;
        }
        
        .error-message {
            color: #D8000C;
            background: #FFD2D2;
            padding: 10px 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            animation: shake 0.5s;
        }
        
        .error-message i {
            margin-right: 10px;
        }
        
        @media (min-width: 992px) {
            .auth-image {
                display: block;
            }
        }
        
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes shake {
            0%, 100% {
                transform: translateX(0);
            }
            10%, 30%, 50%, 70%, 90% {
                transform: translateX(-5px);
            }
            20%, 40%, 60%, 80% {
                transform: translateX(5px);
            }
        }
        
        .password-strength {
            height: 4px;
            background: #e2e8f0;
            border-radius: 2px;
            margin-top: -15px;
            margin-bottom: 15px;
            overflow: hidden;
        }
        
        .strength-bar {
            height: 100%;
            width: 0;
            transition: width 0.3s, background 0.3s;
        }
        
        .mcd-yellow-line {
            height: 5px;
            background: var(--mcd-yellow);
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
        }
    </style>
</head>

<body>
    <div class="auth-container animate__animated animate__fadeIn">
        <div class="auth-image"></div>
        <div class="auth-content">
            <div class="mcd-yellow-line"></div>
            <img src="https://logos-world.net/wp-content/uploads/2020/04/McDonalds-Logo-700x394.png" alt="McDonald's Logo" class="mcd-logo">
            
            <div class="auth-header">
                <h2>Reset Your Password</h2>
                <p>Enter your details to set a new password</p>
                
                <%String failedtochangepassword = (String) request.getAttribute("failedtochangepassword"); if(failedtochangepassword != null){ %>
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i>
                    <%=failedtochangepassword %>
                </div>
                <%} %>
                <%String changepassword = (String) request.getAttribute("failed"); if(failedtochangepassword != null){ %>
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i>
                    <%=changepassword %>
                </div>
                <%} %>
            </div>
            
            <form method="post" action="resetpasswordservlet" id="resetForm">
                <div class="mb-3">
                    <label for="email" class="form-label">Email Address</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
                </div>
                
                <div class="mb-3">
                    <label for="phone" class="form-label">Phone Number</label>
                    <input type="text" class="form-control" id="phone" name="phone" placeholder="Enter your phone number" required>
                </div>
                
                <div class="mb-3">
                    <label for="password" class="form-label">New Password</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="password" name="password" placeholder="Create new password" required>
                        <span class="password-toggle" id="togglePassword">
                            <i class="far fa-eye"></i>
                        </span>
                    </div>
                    <div class="password-strength">
                        <div class="strength-bar" id="strengthBar"></div>
                    </div>
                </div>
                
                <div class="mb-3">
                    <label for="confirm-password" class="form-label">Confirm Password</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="confirm-password" name="confirmpassword" placeholder="Confirm your password" required>
                        <span class="password-toggle" id="toggleConfirmPassword">
                            <i class="far fa-eye"></i>
                        </span>
                    </div>
                    <div id="passwordMatch" class="text-sm text-danger mt-1" style="display: none;">Passwords don't match</div>
                </div>
                
                <input type="submit" class="btn btn-auth w-100" value="Reset Password" />
            </form>
            
            <div class="auth-footer">
                <p>Remember your password? <a href="login.jsp">Sign in</a></p>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <script>
        // Password toggle functionality
        const togglePassword = document.querySelector('#togglePassword');
        const toggleConfirmPassword = document.querySelector('#toggleConfirmPassword');
        const password = document.querySelector('#password');
        const confirmPassword = document.querySelector('#confirm-password');
        const strengthBar = document.querySelector('#strengthBar');
        const passwordMatch = document.querySelector('#passwordMatch');
        
        togglePassword.addEventListener('click', function() {
            const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
            password.setAttribute('type', type);
            this.innerHTML = type === 'password' ? '<i class="far fa-eye"></i>' : '<i class="far fa-eye-slash"></i>';
        });
        
        toggleConfirmPassword.addEventListener('click', function() {
            const type = confirmPassword.getAttribute('type') === 'password' ? 'text' : 'password';
            confirmPassword.setAttribute('type', type);
            this.innerHTML = type === 'password' ? '<i class="far fa-eye"></i>' : '<i class="far fa-eye-slash"></i>';
        });
        
        // Password strength indicator
        password.addEventListener('input', function() {
            const strength = calculatePasswordStrength(this.value);
            updateStrengthBar(strength);
        });
        
        // Password match validation
        confirmPassword.addEventListener('input', function() {
            if (password.value !== this.value && this.value.length > 0) {
                passwordMatch.style.display = 'block';
            } else {
                passwordMatch.style.display = 'none';
            }
        });
        
        // Form validation
        document.getElementById('resetForm').addEventListener('submit', function(e) {
            if (password.value !== confirmPassword.value) {
                e.preventDefault();
                passwordMatch.style.display = 'block';
                confirmPassword.focus();
            }
        });
        
        function calculatePasswordStrength(password) {
            let strength = 0;
            
            // Length check
            if (password.length >= 8) strength += 1;
            if (password.length >= 12) strength += 1;
            
            // Character variety
            if (/[A-Z]/.test(password)) strength += 1;
            if (/[0-9]/.test(password)) strength += 1;
            if (/[^A-Za-z0-9]/.test(password)) strength += 1;
            
            return Math.min(strength, 5); // Max strength of 5
        }
        
        function updateStrengthBar(strength) {
            let width = 0;
            let color = '';
            
            switch(strength) {
                case 0:
                case 1:
                    width = 20;
                    color = '#D8000C'; // Red
                    break;
                case 2:
                    width = 40;
                    color = '#FF5722'; // Orange
                    break;
                case 3:
                    width = 60;
                    color = '#FFC72C'; // Yellow
                    break;
                case 4:
                    width = 80;
                    color = '#8BC34A'; // Light green
                    break;
                case 5:
                    width = 100;
                    color = '#4B8A2D'; // McDonald's green
                    break;
            }
            
            strengthBar.style.width = width + '%';
            strengthBar.style.background = color;
        }
    </script>
</body>

</html>
