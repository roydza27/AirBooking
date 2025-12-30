<%@ page import="jakarta.servlet.http.Cookie" %>
<%@ page import="java.util.List" %>
<%@ page import="beans.Flight" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String lastFrom = "";
    String lastTo = "";
    if (request.getCookies() != null) {
        for (Cookie cookie : request.getCookies()) {
            if ("lastFrom".equals(cookie.getName())) lastFrom = cookie.getValue();
            if ("lastTo".equals(cookie.getName())) lastTo = cookie.getValue();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Flights - AirBooking System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <div class="container">
        <div class="search-box">
            <h2>Search Flights</h2>

            <form action="SearchFlightServlet" method="POST">
                <div class="form-row">
                    <div class="form-group">
                        <label>From City:</label>
                        <select name="fromCity" required>
                            <option value="">Select City</option>
                            <option value="Mumbai" <%= "Mumbai".equals(lastFrom) ? "selected" : "" %>>Mumbai</option>
                            <option value="Delhi">Delhi</option>
                            <option value="Bangalore">Bangalore</option>
                            <option value="Kolkata">Kolkata</option>
                            <option value="Chennai">Chennai</option>
                            <option value="Hyderabad">Hyderabad</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>To City:</label>
                        <select name="toCity" required>
                            <option value="">Select City</option>
                            <option value="Delhi" <%= "Delhi".equals(lastTo) ? "selected" : "" %>>Delhi</option>
                            <option value="Mumbai">Mumbai</option>
                            <option value="Bangalore">Bangalore</option>
                            <option value="Kolkata">Kolkata</option>
                            <option value="Chennai">Chennai</option>
                            <option value="Hyderabad">Hyderabad</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Travel Date:</label>
                        <input type="date" name="date" required>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary">Search Flights</button>
            </form>
            <div class="info-box"> <h4>Popular Routes:</h4> <ul> <li>Mumbai ✈️ Delhi</li> <li>Delhi ✈️ Bangalore</li> <li>Bangalore ✈️ Kolkata</li> <li>Chennai ✈️ Hyderabad</li> </ul> </div>

        </div>
    </div>
</body>
</html>
