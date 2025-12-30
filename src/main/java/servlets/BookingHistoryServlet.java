/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import beans.Booking;
import beans.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author royal
 */
public class BookingHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Booking> bookings = new ArrayList<>();

        try {
            conn = DBConnection.getConnection();

            String sql = "SELECT b.booking_id, b.user_id, b.flight_id, b.seats_booked, b.total_price, b.booking_date, " +
                        "f.from_city, f.to_city, f.date as flight_date, f.price " +
                        "FROM bookings b " +
                        "INNER JOIN flights f ON b.flight_id = f.flight_id " +
                        "WHERE b.user_id = ? " +
                        "ORDER BY b.booking_date DESC";
            
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getString("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setFlightId(rs.getString("flight_id"));
                booking.setSeatsBooked(rs.getInt("seats_booked"));
                booking.setTotalPrice(rs.getInt("total_price"));
                booking.setBookingDate(rs.getString("booking_date"));
                
                booking.setFromCity(rs.getString("from_city"));
                booking.setToCity(rs.getString("to_city"));
                booking.setFlightDate(rs.getString("flight_date"));
                
                bookings.add(booking);
            }

            request.setAttribute("bookings", bookings);
            
            if (bookings.isEmpty()) {
                request.setAttribute("infoMsg", "You have no bookings yet. Start searching for flights!");
            }

            request.getRequestDispatcher("history.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Database error: " + e.getMessage());
            request.getRequestDispatcher("history.jsp").forward(request, response);
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
