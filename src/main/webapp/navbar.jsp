<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String currentUserName = (String) session.getAttribute("userName");
    String currentUserRole = (String) session.getAttribute("userRole");
    boolean isAdmin = "admin".equals(currentUserRole);
%>
<nav class="navbar">
    <div class="nav-container">
        <div class="nav-brand">
            <a href="<%= isAdmin ? "admin.jsp" : "search.jsp" %>">
                ✈️ AirBooking System
            </a>
        </div>
        
        <ul class="nav-menu">
            <li><a href="search.jsp">🔍 Search Flights</a></li>
            <li><a href="BookingHistoryServlet">📋 My Bookings</a></li>
            
            <% if (isAdmin) { %>
                <li><a href="admin.jsp" class="admin-link">⚙️ Admin Panel</a></li>
            <% } %>
            
            <li class="nav-user">
                <span>👤 <%= currentUserName %></span>
            </li>
            <li><a href="LogoutServlet" class="logout-link">🚪 Logout</a></li>
        </ul>
    </div>
</nav>