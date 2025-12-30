<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - AirBooking System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="auth-box">
            <h1>✈️ AirBooking System</h1>
            <h2>Register</h2>
            
            <% if (request.getAttribute("errorMsg") != null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("errorMsg") %>
                </div>
            <% } %>
            
            <form action="RegisterServlet" method="post" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="name">Full Name:</label>
                    <input type="text" id="name" name="name" required 
                           placeholder="Enter your full name">
                </div>
                
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required 
                           placeholder="Enter your email">
                </div>
                
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required 
                           placeholder="Enter password (min 6 characters)">
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password:</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required 
                           placeholder="Re-enter password">
                </div>
                
                <button type="submit" class="btn btn-primary">Register</button>
            </form>
            
            <div class="auth-footer">
                <p>Already have an account? <a href="login.jsp">Login here</a></p>
            </div>
        </div>
    </div>

    <script>
        function validateForm() {
            const password = document.getElementById("password").value;
            const confirmPassword = document.getElementById("confirmPassword").value;
            
            if (password.length < 6) {
                alert("Password must be at least 6 characters long!");
                return false;
            }
            
            if (password !== confirmPassword) {
                alert("Passwords do not match!");
                return false;
            }
            
            return true;
        }
    </script>
</body>
</html>