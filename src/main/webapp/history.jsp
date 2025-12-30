<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="beans.Booking" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String successMsg = (String) session.getAttribute("successMsg");
    String errorMsg = (String) session.getAttribute("errorMsg");
    session.removeAttribute("successMsg");
    session.removeAttribute("errorMsg");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking History - AirBooking System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <%@ include file="navbar.jsp" %>
    
    <div class="container">
        <div class="history-box">
            <h2>📋 My Booking History</h2>
            
            <% if (successMsg != null) { %>
                <div class="alert alert-success">
                    <%= successMsg %>
                </div>
            <% } %>
            
            <% if (errorMsg != null) { %>
                <div class="alert alert-error">
                    <%= errorMsg %>
                </div>
            <% } %>
            
            <% if (request.getAttribute("infoMsg") != null) { %>
                <div class="alert alert-info">
                    <%= request.getAttribute("infoMsg") %>
                    <a href="search.jsp" class="btn btn-sm btn-primary">Search Flights</a>
                </div>
            <% } %>
            
            <c:if test="${not empty bookings}">
                <div class="bookings-grid">
                    <c:forEach var="booking" items="${bookings}">
                        <div class="booking-card">
                            <div class="booking-header">
                                <h3>🎫 ${booking.bookingId}</h3>
                                <span class="booking-date">Booked: ${booking.bookingDate}</span>
                            </div>
                            
                            <div class="booking-route">
                                <div class="route-info">
                                    <span class="city">${booking.fromCity}</span>
                                    <span class="arrow">✈️</span>
                                    <span class="city">${booking.toCity}</span>
                                </div>
                                <div class="flight-info">
                                    <strong>Flight:</strong> ${booking.flightId} | 
                                    <strong>Date:</strong> ${booking.flightDate}
                                </div>
                            </div>
                            
                            <div class="booking-details">
                                <table>
                                    <tr>
                                        <th>Seats:</th>
                                        <td>${booking.seatsBooked}</td>
                                    </tr>
                                    <tr>
                                        <th>Total Price:</th>
                                        <td><strong>₹${booking.totalPrice}</strong></td>
                                    </tr>
                                </table>
                            </div>
                            
                            <div class="booking-actions">
                                <form action="CancelBookingServlet" method="post" 
                                      onsubmit="return confirmCancel('${booking.bookingId}')">
                                    <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                    <button type="submit" class="btn btn-danger">Cancel Booking</button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            
            <div class="history-footer">
                <a href="search.jsp" class="btn btn-primary">Book New Flight</a>
            </div>
        </div>
    </div>

    <script>
        function confirmCancel(bookingId) {
            return confirm('Are you sure you want to cancel booking ' + bookingId + '?\n\nNote: Cancellation is only allowed if the flight date is today or in the future.');
        }
    </script>
</body>
</html>