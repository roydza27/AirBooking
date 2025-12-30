<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="beans.Flight" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flight Results - AirBooking System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <%@ include file="navbar.jsp" %>
    
    <div class="container">
        <div class="results-box">
            <h2>Available Flights</h2>
            
            <div class="search-summary">
                <p><strong>Route:</strong> ${searchFrom} → ${searchTo}</p>
                <p><strong>Date:</strong> ${searchDate}</p>
            </div>
            
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
            
            <c:choose>
                <c:when test="${not empty flights}">
                    <div class="flights-grid">
                        <c:forEach var="flight" items="${flights}">
                            <div class="flight-card">
                                <div class="flight-header">
                                    <h3>✈️ ${flight.flightId}</h3>
                                    <span class="flight-price">₹${flight.price}</span>
                                </div>
                                
                                <div class="flight-route">
                                    <span class="city">${flight.fromCity}</span>
                                    <span class="arrow">→</span>
                                    <span class="city">${flight.toCity}</span>
                                </div>
                                
                                <div class="flight-details">
                                    <p><strong>Date:</strong> ${flight.date}</p>
                                    <p><strong>Available Seats:</strong> 
                                        <span class="seats-badge">${flight.seatsAvailable}</span>
                                    </p>
                                </div>
                                
                                <form action="BookingServlet" method="post" class="booking-form">
                                    <input type="hidden" name="flightId" value="${flight.flightId}">
                                    <input type="hidden" name="price" value="${flight.price}">
                                    
                                    <div class="form-group">
                                        <label for="seats_${flight.flightId}">Number of Seats:</label>
                                        <input type="number" id="seats_${flight.flightId}" 
                                               name="seats" min="1" max="${flight.seatsAvailable}" 
                                               value="1" required>
                                    </div>
                                    
                                    <button type="submit" class="btn btn-success"
                                            onclick="return confirm('Book ${flight.flightId}?')">
                                        Book Now
                                    </button>
                                </form>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-results">
                        <p>No flights found for the selected route and date.</p>
                        <a href="search.jsp" class="btn btn-primary">Search Again</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>