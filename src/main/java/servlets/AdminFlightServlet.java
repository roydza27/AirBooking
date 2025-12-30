package servlets;

import beans.DBConnection;
import beans.Flight;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * AdminFlightServlet - Handles flight management for admin
 * Add, Delete, and View all flights
 */
public class AdminFlightServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("403.jsp");
            return;
        }

        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            deleteFlight(request, response);
        } else {
            viewAllFlights(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("403.jsp");
            return;
        }

        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addFlight(request, response);
        } else {
            response.sendRedirect("admin.jsp");
        }
    }

    /**
     * View all flights
     */
    private void viewAllFlights(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Flight> flights = new ArrayList<>();

        try {
            conn = DBConnection.getConnection();

            String sql = "SELECT * FROM flights ORDER BY date, from_city";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Flight flight = new Flight();
                flight.setFlightId(rs.getString("flight_id"));
                flight.setFromCity(rs.getString("from_city"));
                flight.setToCity(rs.getString("to_city"));
                flight.setDate(rs.getString("date"));
                flight.setSeatsAvailable(rs.getInt("seats_available"));
                flight.setPrice(rs.getInt("price"));
                flights.add(flight);
            }

            request.setAttribute("flights", flights);
            request.getRequestDispatcher("admin.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Database error: " + e.getMessage());
            request.getRequestDispatcher("admin.jsp").forward(request, response);
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Add new flight
     */
    private void addFlight(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String flightId = request.getParameter("flightId");
        String fromCity = request.getParameter("fromCity");
        String toCity = request.getParameter("toCity");
        String date = request.getParameter("date");
        String seatsStr = request.getParameter("seats");
        String priceStr = request.getParameter("price");

        // Validation
        if (flightId == null || fromCity == null || toCity == null || date == null || 
            seatsStr == null || priceStr == null || flightId.trim().isEmpty() || 
            fromCity.trim().isEmpty() || toCity.trim().isEmpty() || date.trim().isEmpty()) {
            
            request.setAttribute("errorMsg", "All fields are required!");
            viewAllFlights(request, response);
            return;
        }

        int seats, price;
        try {
            seats = Integer.parseInt(seatsStr);
            price = Integer.parseInt(priceStr);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMsg", "Invalid seats or price!");
            viewAllFlights(request, response);
            return;
        }

        if (seats <= 0 || price <= 0) {
            request.setAttribute("errorMsg", "Seats and price must be positive!");
            viewAllFlights(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();

            String sql = "INSERT INTO flights (flight_id, from_city, to_city, date, seats_available, price) VALUES (?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, flightId.toUpperCase());
            ps.setString(2, fromCity);
            ps.setString(3, toCity);
            ps.setString(4, date);
            ps.setInt(5, seats);
            ps.setInt(6, price);

            int result = ps.executeUpdate();

            if (result > 0) {
                request.setAttribute("successMsg", "Flight added successfully!");
            } else {
                request.setAttribute("errorMsg", "Failed to add flight!");
            }

        } catch (SQLException e) {
            if (e.getMessage().contains("Duplicate entry")) {
                request.setAttribute("errorMsg", "Flight ID already exists!");
            } else {
                e.printStackTrace();
                request.setAttribute("errorMsg", "Database error: " + e.getMessage());
            }
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        viewAllFlights(request, response);
    }

    /**
     * Delete flight
     */
    private void deleteFlight(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String flightId = request.getParameter("flightId");
        
        if (flightId == null || flightId.trim().isEmpty()) {
            viewAllFlights(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();

            String sql = "DELETE FROM flights WHERE flight_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, flightId);

            int result = ps.executeUpdate();

            if (result > 0) {
                request.setAttribute("successMsg", "Flight deleted successfully!");
            } else {
                request.setAttribute("errorMsg", "Flight not found!");
            }

        } catch (SQLException e) {
            if (e.getMessage().contains("foreign key constraint")) {
                request.setAttribute("errorMsg", "Cannot delete flight! Active bookings exist.");
            } else {
                e.printStackTrace();
                request.setAttribute("errorMsg", "Database error: " + e.getMessage());
            }
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        viewAllFlights(request, response);
    }
}