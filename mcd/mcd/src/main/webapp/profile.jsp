<%@page import="com.mcd.models.Dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile | Food Delight</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.21.0/jquery.validate.min.js"></script>
    <style>
        /* Background styling */
        .profile-container-wrapper {
            display: flex;
            min-height: 100vh;
            align-items: center;
            justify-content: center;
            background: url('https://wallpapercave.com/wp/wp1919500.jpg') no-repeat center center/cover;
            padding: 20px;
        }

        /* Profile container */
        .profile-container {
            padding: 40px;
            max-width: 600px;
            width: 100%;
            color: white;
            border-radius: 10px;
            background: rgba(0, 0, 0, 0.7);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            position: relative;
        }

        /* Profile header */
        .profile-header {
            text-align: center;
            margin-bottom: 30px;
            position: relative;
        }

        .profile-pic {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #ffcc00;
            margin-bottom: 15px;
        }

        .edit-profile-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            background: rgba(255, 204, 0, 0.2);
            border: none;
            color: #ffcc00;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .edit-profile-btn:hover {
            background: rgba(255, 204, 0, 0.4);
        }

        /* Form styling */
        .profile-form .form-group {
            margin-bottom: 1.5rem;
            position: relative;
        }

        .profile-form .form-control {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: white;
            transition: all 0.3s ease;
            padding: 12px 15px;
        }

        .profile-form .form-control:focus {
            background: rgba(255, 255, 255, 0.2);
            border-color: rgba(255, 255, 255, 0.4);
            color: white;
            box-shadow: 0 0 0 0.25rem rgba(255, 204, 0, 0.25);
        }

        .profile-form .form-control:disabled {
            background: rgba(255, 255, 255, 0.05);
            border-color: rgba(255, 255, 255, 0.1);
        }

        .profile-form label {
            font-weight: 500;
            margin-bottom: 8px;
            display: block;
        }

        /* Button styling */
        .btn-update {
            background: linear-gradient(45deg, #ffcc00, #ff9900);
            color: #333;
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            margin-top: 10px;
        }

        .btn-update:hover {
            background: linear-gradient(45deg, #ff9900, #ff6600);
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(255, 153, 0, 0.4);
        }

        /* Error message styling */
        .error {
            color: #ff6b6b;
            font-size: 14px;
            display: block;
            margin-top: 5px;
        }

        /* Success message */
        .success-message {
            color: #28a745;
            font-weight: 500;
            text-align: center;
            margin-bottom: 20px;
            display: none;
        }

        /* Date input styling */
        .date-input-container {
            position: relative;
        }

        .custom-date-placeholder {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: rgba(255, 255, 255, 0.7);
            pointer-events: none;
            margin: 0;
        }

        input[type="date"]::-webkit-datetime-edit,
        input[type="date"]::-webkit-inner-spin-button,
        input[type="date"]::-webkit-clear-button {
            display: none;
        }

        input[type="date"]:valid + .custom-date-placeholder {
            display: none;
        }

        input[type="date"]::before {
            content: attr(data-value);
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: white;
            pointer-events: none;
            width: calc(100% - 30px);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        input[type="date"]:focus::before {
            display: none;
        }
    </style>
</head>

<body>
    <%
    User user = (User) session.getAttribute("pass");
    if(user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String success = (String) request.getAttribute("success");
    String error = (String) request.getAttribute("error");
    %>

    <div class="profile-container-wrapper">
        <div class="profile-container">
            <div class="profile-header">
                <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" class="profile-pic" alt="Profile Picture">
                <h3><%= user.getName() %></h3>
               
                <button id="editProfileBtn" class="edit-profile-btn">
                    <i class="bi bi-pencil-fill"></i>
                </button>
            </div>

            <% if(success != null) { %>
                <div class="alert alert-success">
                    <%= success %>
                </div>
            <% } %>
            
            <% if(error != null) { %>
                <div class="alert alert-danger">
                    <%= error %>
                </div>
            <% } %>

            <form id="profileForm" class="profile-form" method="post" action="updateProfile">
                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" class="form-control" name="name" value="<%= user.getName() %>" disabled required>
                </div>
                
                <div class="form-group">
                    <input type="hidden" id="uid" class="form-control" name="uid" value="<%= user.getUserId() %>" disabled required>
                </div>
                
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" class="form-control" name="email" value="<%= user.getEmail() %>" disabled required>
                </div>
                
                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="text" id="phone" class="form-control" name="phone" value="<%= user.getPhone() %>" disabled required>
                </div>
                
                <div class="form-group date-input-container">
                    <label for="dob">Date of Birth</label>
                    <input type="date" id="dob" class="form-control" name="dob" value="<%= user.getDob() %>" disabled required>
                </div>
                
                <div class="form-group">
                    <label for="password">Password </label>
                    <input type="password" id="password" class="form-control" name="password" value="<%= user.getPassword() %>"disabled>
                </div>
                
                <div class="text-center">
                    <a href="userhome.jsp" class="btn btn-secondary me-2">Back to Main Page</a>
                    <button type="submit" id="updateBtn" class="btn btn-update" style="display: none;">Update Profile</button>
                    <button type="button" id="cancelBtn" class="btn btn-secondary" style="display: none;">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <script>
    $(document).ready(function() {
        // Initialize date display
        if ($('#dob').val()) {
            const formattedDate = formatDate($('#dob').val());
            $('#dob').attr('data-value', formattedDate);
        }

        // Toggle edit mode
        $('#editProfileBtn').click(function() {
            $('.form-control').prop('disabled', function(i, val) {
                return !val;
            });
            
            $('#updateBtn').show();
            $('#cancelBtn').show();
            $(this).hide();
        });

        // Cancel edit
        $('#cancelBtn').click(function() {
            $('.form-control').prop('disabled', true);
            $('#updateBtn').hide();
            $(this).hide();
            $('#editProfileBtn').show();
            
            // Reset form to original values
            $('#name').val('<%= user.getName() %>');
            $('#email').val('<%= user.getEmail() %>');
            $('#phone').val('<%= user.getPhone() %>');
            $('#dob').val('<%= user.getDob() %>');
            
            // Reset date display
            if ($('#dob').val()) {
                const formattedDate = formatDate($('#dob').val());
                $('#dob').attr('data-value', formattedDate);
            }
        });

        // Handle date input changes
        $('#dob').on('change input', function() {
            if (this.value) {
                const formattedDate = formatDate(this.value);
                $(this).attr('data-value', formattedDate);
            } else {
                $(this).removeAttr('data-value');
            }
        });

        // Form validation
        $("#profileForm").validate({
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
                    email: true
                },
                dob: {
                    required: true
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
                    email: "Please enter a valid email address"
                },
                dob: {
                    required: "Please enter your date of birth"
                }
            },
            errorElement: "span",
            errorClass: "error",
            highlight: function(element, errorClass, validClass) {
                $(element).addClass("is-invalid").removeClass("is-valid");
            },
            unhighlight: function(element, errorClass, validClass) {
                $(element).removeClass("is-invalid").addClass("is-valid");
            },
            submitHandler: function(form) {
                form.submit();
            }
        });

        // Helper function to format the date display
        function formatDate(dateString) {
            const date = new Date(dateString);
            return date.toLocaleDateString('en-US', {
                year: 'numeric',
                month: 'short',
                day: 'numeric'
            });
        }
    });
    </script>
</body>
</html>