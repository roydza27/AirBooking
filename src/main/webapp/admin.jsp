<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="beans.Flight" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String userRole = (String) session.getAttribute("userRole");
    if (!"admin".equals(userRole)) {
        response.sendRedirect("403.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Panel - AirBooking System</title>
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <%@ include file="navbar.jsp" %>
        <div class="container">
            <div class="admin-box">
                <h2>⚙️ Admin Panel - Flight Management</h2>

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

                <div class="admin-section">
                    <h3>➕ Add New Flight</h3>
                    <form action="AdminFlightServlet" method="post" class="admin-form">
                        <input type="hidden" name="action" value="add">

                        <div class="form-row">
                            <div class="form-group">
                                <label for="flightId">Flight ID:</label>
                                <input type="text" id="flightId" name="flightId" required 
                                       placeholder="e.g., AI109" pattern="[A-Z]{2}[0-9]{3,}" 
                                       title="Format: 2 letters + 3+ numbers">
                            </div>

                            <div class="form-group">
                                <label for="fromCity">From City:</label>
                                <select id="fromCity" name="fromCity" required>
                                    <option value="">Select City</option>
                                    <option value="Mumbai">Mumbai</option>
                                    <option value="Delhi">Delhi</option>
                                    <option value="Bangalore">Bangalore</option>
                                    <option value="Kolkata">Kolkata</option>
                                    <option value="Chennai">Chennai</option>
                                    <option value="Hyderabad">Hyderabad</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="toCity">To City:</label>
                                <select id="toCity" name="toCity" required>
                                    <option value="">Select City</option>
                                    <option value="Mumbai">Mumbai</option>
                                    <option value="Delhi">Delhi</option>
                                    <option value="Bangalore">Bangalore</option>
                                    <option value="Kolkata">Kolkata</option>
                                    <option value="Chennai">Chennai</option>
                                    <option value="Hyderabad">Hyderabad</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="date">Flight Date:</label>
                                <input type="date" id="date" name="date" required 
                                       min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                            </div>

                            <div class="form-group">
                                <label for="seats">Total Seats:</label>
                                <input type="number" id="seats" name="seats" required 
                                       min="1" max="300" placeholder="e.g., 50">
                            </div>

                            <div class="form-group">
                                <label for="price">Price per Seat (₹):</label>
                                <input type="number" id="price" name="price" required 
                                       min="500" max="50000" placeholder="e.g., 3500">
                            </div>
                        </div>

                        <button type="submit" class="btn btn-success">Add Flight</button>
                    </form>
                </div>

                <div class="admin-section">
                    <h3>✈️ All Flights</h3>

                    <%
                        if (request.getAttribute("flights") == null) {
                            request.getRequestDispatcher("AdminFlightServlet").forward(request, response);
                            return;
                        }
                    %>

                    <c:choose>
                        <c:when test="${not empty flights}">
                            <div class="table-responsive">
                                <table class="flights-table">
                                    <thead>
                                        <tr>
                                            <th>Flight ID</th>
                                            <th>From</th>
                                            <th>To</th>
                                            <th>Date</th>
                                            <th>Seats Available</th>
                                            <th>Price (₹)</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="flight" items="${flights}">
                                            <tr>
                                                <td><strong>${flight.flightId}</strong></td>
                                                <td>${flight.fromCity}</td>
                                                <td>${flight.toCity}</td>
                                                <td>${flight.date}</td>
                                                <td>
                                                    <span class="seats-badge 
                                                        ${flight.seatsAvailable < 10 ? 'low-seats' : ''}">
                                                        ${flight.seatsAvailable}
                                                    </span>
                                                </td>
                                                <td>₹${flight.price}</td>
                                                <td>
                                                    <form action="AdminFlightServlet" method="get" style="display: inline;"
                                                          onsubmit="return confirmDelete('${flight.flightId}')">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="flightId" value="${flight.flightId}">
                                                        <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p class="no-data">No flights available. Add your first flight!</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        <script>
            function confirmDelete(flightId) {
                return confirm('Are you sure you want to delete flight ' + flightId + '?\n\nThis action cannot be undone.');
            }
        </script>
    </body>
</html>
