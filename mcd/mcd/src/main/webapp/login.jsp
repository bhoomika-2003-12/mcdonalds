<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>McDonald's Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
    <style>
        :root {
            --mcd-red: #DA291C;
            --mcd-yellow: #FFC72C;
            --mcd-dark: #27251F;
            --mcd-light: #F7F7F7;
            --mcd-green: #3A913F;
        }

        body {
            font-family: 'Flame Sans', Arial, sans-serif;
            background-color: var(--mcd-light);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
            padding: 20px;
            background-image: url('https://www.mcdonalds.com/content/dam/sites/usa/nfl/icons/arches-logo_108x108.jpg');
            background-size: 200px;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-blend-mode: overlay;
            background-color: rgba(247, 247, 247, 0.9);
        }

        .login-container {
            background: white;
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 500px;
            transition: all 0.3s ease;
            border: 3px solid var(--mcd-yellow);
        }

        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-header h2 {
            color: var(--mcd-red);
            font-weight: 700;
            margin-bottom: 10px;
            font-family: 'Flame Bold', Arial, sans-serif;
        }

        .login-header p {
            color: var(--mcd-dark);
            font-size: 0.95rem;
        }

        .form-control {
            height: 50px;
            border-radius: 8px;
            border: 2px solid #e0e0e0;
            padding: 15px;
            font-size: 0.95rem;
            transition: all 0.3s;
            margin-bottom: 20px;
        }

        .form-control:focus {
            border-color: var(--mcd-yellow);
            box-shadow: 0 0 0 0.25rem rgba(255, 199, 44, 0.25);
        }

        .form-control::placeholder {
            color: #adb5bd;
        }

        .btn-login {
            background: linear-gradient(to right, var(--mcd-red), #C5221A);
            border: none;
            height: 50px;
            border-radius: 8px;
            font-weight: 600;
            letter-spacing: 0.5px;
            font-size: 0.9rem;
            transition: all 0.3s;
            margin-top: 10px;
        }

        .btn-login:hover {
            background: linear-gradient(to right, #C5221A, var(--mcd-red));
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(218, 41, 28, 0.4);
        }

        .links-container {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
            font-size: 0.9rem;
        }

        .links-container a {
            color: var(--mcd-red);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
        }

        .links-container a:hover {
            color: #C5221A;
            text-decoration: underline;
        }

        .divider {
            display: flex;
            align-items: center;
            margin: 25px 0;
            color: #6c757d;
            font-size: 0.9rem;
        }

        .divider::before, .divider::after {
            content: "";
            flex: 1;
            border-bottom: 1px solid #e0e0e0;
            margin: 0 10px;
        }

        .alert-message {
            border-radius: 8px;
            padding: 12px 15px;
            margin-bottom: 20px;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            animation: fadeIn 0.5s ease-in-out;
        }

        .alert-success {
            background-color: rgba(58, 145, 63, 0.2);
            border-left: 4px solid var(--mcd-green);
            color: #1a4b1d;
        }

        .alert-error {
            background-color: rgba(218, 41, 28, 0.2);
            border-left: 4px solid var(--mcd-red);
            color: #610316;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 576px) {
            .login-container {
                padding: 30px 20px;
            }
            
            .links-container {
                flex-direction: column;
                gap: 10px;
                align-items: center;
            }
        }

        /* McDonald's logo styling */
        .mcd-logo {
            width: 80px;
            height: 80px;
            margin-bottom: 15px;
            filter: drop-shadow(0 2px 4px rgba(0,0,0,0.2));
        }

        /* Special font for McDonald's feel */
        @font-face {
            font-family: 'Flame Sans';
            src: url('https://www.mcdonalds.com/etc/designs/mcdonalds/fonts/FlameSans-Regular.woff2') format('woff2');
            font-weight: normal;
            font-style: normal;
        }

        @font-face {
            font-family: 'Flame Bold';
            src: url('https://www.mcdonalds.com/etc/designs/mcdonalds/fonts/Flame-Bold.woff2') format('woff2');
            font-weight: bold;
            font-style: normal;
        }
    </style>
</head>

<body>
    <div class="login-container animate__animated animate__fadeIn">
        <div class="login-header">
            <img src="https://www.mcdonalds.com/content/dam/sites/usa/nfl/icons/arches-logo_108x108.jpg" alt="McDonald's Logo" class="mcd-logo">
            <h2>Welcome to McDonald's</h2>
            <p>Sign in to your McDonald's account</p>
        </div>

        <!-- Success/Error Messages -->
        <%String success= (String) request.getAttribute("signupsuccess"); if(success != null){ %>
        <div class="alert-message alert-success">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-check-circle-fill me-2" viewBox="0 0 16 16">
                <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
            </svg>
            <%=success %>
        </div>
        <%} %>
        
        <%String usernotfound = (String) request.getAttribute("usernotfound"); if(usernotfound != null){ %>
        <div class="alert-message alert-error">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-exclamation-circle-fill me-2" viewBox="0 0 16 16">
                <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8 4a.905.905 0 0 0-.9.995l.35 3.507a.552.552 0 0 0 1.1 0l.35-3.507A.905.905 0 0 0 8 4zm.002 6a1 1 0 1 0 0 2 1 1 0 0 0 0-2z"/>
            </svg>
            <%=usernotfound %>
        </div>
        <%} %>
        
        <%String passwordChanged = (String) request.getAttribute("passwordChanged"); if(passwordChanged != null){ %>
        <div class="alert-message alert-success">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-check-circle-fill me-2" viewBox="0 0 16 16">
                <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
            </svg>
            <%=passwordChanged %>
        </div>
        <%} %>

        <!-- Login Form -->
        <form method="post" action="loginservlete">
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
            </div>
            
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
            </div>
            
            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-login text-white">
                    Sign In
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-right ms-2" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8z"/>
                    </svg>
                </button>
            </div>
            
            <div class="links-container">
                <a href="resetpassword.jsp">Forgot password?</a>
                <a href="signup.jsp">Create an account</a>
            </div>
        </form>
        
        <div class="divider">or</div>
        
        <div class="text-center">
            <p class="mb-3">Continue as guest</p>
            <a href="index.jsp" class="btn btn-outline-dark" style="border-color: var(--mcd-dark); color: var(--mcd-dark);">
                Order Now
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>