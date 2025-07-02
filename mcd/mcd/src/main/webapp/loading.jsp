<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Signing Up | MoonChees</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .loading-container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f8f9fa;
        }
        .spinner {
            width: 3rem;
            height: 3rem;
        }
        .loading-text {
            margin-top: 1.5rem;
            font-size: 1.2rem;
            color: #333;
        }
        .progress {
            width: 50%;
            margin-top: 1.5rem;
            height: 8px;
        }
    </style>
</head>
<body>
    <div class="loading-container">
        <div class="spinner-border text-primary spinner" role="status">
            <span class="visually-hidden">Loading...</span>
        </div>
        <div class="loading-text">Creating your account...</div>
        <div class="progress">
            <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" 
                 style="width: 100%"></div>
        </div>
        <div class="mt-3 text-muted">Please wait while we set up your account and send verification email</div>
    </div>

    <script>
        // Automatically redirect after 5 seconds if something goes wrong
        setTimeout(function() {
            window.location.href = "signup.jsp?timeout=true";
        }, 15000); // 15 seconds timeout
    </script>
</body>
</html>