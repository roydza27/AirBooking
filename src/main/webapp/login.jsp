<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<%@ page import="jakarta.servlet.http.HttpServletResponse" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - AirBooking System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="auth-box">
            <h1>✈️ AirBooking System</h1>
            <h2>Login</h2>

            <% if (request.getAttribute("successMsg") != null) { %>
                <div class="alert alert-success">
                    <%= request.getAttribute("successMsg") %>
                </div>
            <% } %>

            <% if (request.getAttribute("errorMsg") != null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("errorMsg") %>
                </div>
            <% } %>

            <form action="LoginServlet" method="post">
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required
                           value="<%= getCookieValue(request.getCookies(), "userEmail") %>"
                           placeholder="Enter your email">
                </div>

                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required
                           placeholder="Enter your password">
                </div>

                <div class="form-group checkbox-group">
                    <input type="checkbox" id="rememberMe" name="rememberMe">
                    <label for="rememberMe">Remember Me</label>
                </div>

                <button type="submit" class="btn btn-primary">Login</button>
            </form>

            <div class="auth-footer">
                <p>Don't have an account? <a href="register.jsp">Register here</a></p>
            </div>

            <div class="demo-credentials">
                <h4>Demo Credentials:</h4>
                <p><strong>Admin:</strong> admin@airbooking.com / admin123</p>
                <p><strong>User:</strong> john@example.com / user123</p>
            </div>
        </div>
    </div>

<%!
    private String getCookieValue(Cookie[] cookies, String cookieName) {
        if (cookies == null) return "";
        for (Cookie cookie : cookies) {
            if (cookieName.equals(cookie.getName())) {
                return cookie.getValue();
            }
        }
        return "";
    }
%>

</body>
</html>
