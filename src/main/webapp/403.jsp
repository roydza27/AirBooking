<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>403 - Access Denied</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .error-container {
            text-align: center;
            padding: 50px 20px;
            max-width: 600px;
            margin: 100px auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
        
        .error-icon {
            font-size: 120px;
            margin-bottom: 20px;
        }
        
        .error-code {
            font-size: 72px;
            font-weight: bold;
            color: #dc3545;
            margin: 0;
        }
        
        .error-message {
            font-size: 24px;
            color: #333;
            margin: 20px 0;
        }
        
        .error-description {
            color: #666;
            margin: 20px 0;
            line-height: 1.6;
        }
        
        .error-actions {
            margin-top: 30px;
        }
        
        .error-actions a {
            margin: 0 10px;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">🚫</div>
        <h1 class="error-code">403</h1>
        <h2 class="error-message">Access Denied</h2>
        <p class="error-description">
            Sorry, you don't have permission to access this resource. 
            This page is restricted to administrators only.
        </p>
        <div class="error-actions">
            <% 
                if (session != null && session.getAttribute("userId") != null) {
                    String role = (String) session.getAttribute("userRole");
                    if ("user".equals(role)) {
            %>
                <a href="search.jsp" class="btn btn-primary">Go to Search</a>
            <% 
                    }
                } else {
            %>
                <a href="login.jsp" class="btn btn-primary">Login</a>
            <% 
                }
            %>
            <a href="javascript:history.back()" class="btn btn-secondary">Go Back</a>
        </div>
    </div>
</body>
</html>