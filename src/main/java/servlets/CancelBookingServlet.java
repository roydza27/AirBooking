/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author royal
 */
public class CancelBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("BookingHistoryServlet");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String bookingId = request.getParameter("bookingId");
        
        if (bookingId == null || bookingId.trim().isEmpty()) {
            response.sendRedirect("BookingHistoryServlet");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        Connection conn = null;
        PreparedStatement psGetBooking = null;
        PreparedStatement psDeleteBooking = null;
        PreparedStatement psUpdateSeats = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            String getSql = "SELECT b.flight_id, b.seats_booked, f.date as flight_date " +
                           "FROM bookings b " +
                           "INNER JOIN flights f ON b.flight_id = f.flight_id " +
                           "WHERE b.booking_id = ? AND b.user_id = ?";
            
            psGetBooking = conn.prepareStatement(getSql);
            psGetBooking.setString(1, bookingId);
            psGetBooking.setInt(2, userId);
            rs = psGetBooking.executeQuery();

            if (!rs.next()) {
                conn.rollback();
                request.setAttribute("errorMsg", "Booking not found or unauthorized!");
                response.sendRedirect("BookingHistoryServlet");
                return;
            }

            String flightId = rs.getString("flight_id");
            int seatsBooked = rs.getInt("seats_booked");
            String flightDateStr = rs.getString("flight_date");

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date flightDate = sdf.parse(flightDateStr);
            Date today = new Date();
            
            String todayStr = sdf.format(today);
            Date todayDate = sdf.parse(todayStr);

            if (flightDate.before(todayDate)) {
                conn.rollback();
                session.setAttribute("errorMsg", "Cannot cancel booking! Flight date has passed.");
                response.sendRedirect("BookingHistoryServlet");
                return;
            }

            String deleteSql = "DELETE FROM bookings WHERE booking_id = ?";
            psDeleteBooking = conn.prepareStatement(deleteSql);
            psDeleteBooking.setString(1, bookingId);
            psDeleteBooking.executeUpdate();

            String updateSql = "UPDATE flights SET seats_available = seats_available + ? WHERE flight_id = ?";
            psUpdateSeats = conn.prepareStatement(updateSql);
            psUpdateSeats.setInt(1, seatsBooked);
            psUpdateSeats.setString(2, flightId);
            psUpdateSeats.executeUpdate();

            conn.commit();

            session.setAttribute("successMsg", "Booking cancelled successfully! " + seatsBooked + " seat(s) refunded.");
            response.sendRedirect("BookingHistoryServlet");

        } catch (SQLException e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            session.setAttribute("errorMsg", "Database error: " + e.getMessage());
            response.sendRedirect("BookingHistoryServlet");
        } catch (ParseException e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            session.setAttribute("errorMsg", "Date parsing error!");
            response.sendRedirect("BookingHistoryServlet");
        } finally {
            try {
                if (conn != null) conn.setAutoCommit(true);
                if (rs != null) rs.close();
                if (psGetBooking != null) psGetBooking.close();
                if (psDeleteBooking != null) psDeleteBooking.close();
                if (psUpdateSeats != null) psUpdateSeats.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
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
