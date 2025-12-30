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
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author royal
 */
public class BookingServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get booking parameters
        String flightId = request.getParameter("flightId");
        String seatsStr = request.getParameter("seats");
        String priceStr = request.getParameter("price");

        // Validation
        if (flightId == null || seatsStr == null || priceStr == null) {
            request.setAttribute("errorMsg", "Invalid booking data!");
            request.getRequestDispatcher("search.jsp").forward(request, response);
            return;
        }

        int seatsBooked;
        int pricePerSeat;
        
        try {
            seatsBooked = Integer.parseInt(seatsStr);
            pricePerSeat = Integer.parseInt(priceStr);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMsg", "Invalid seat or price data!");
            request.getRequestDispatcher("search.jsp").forward(request, response);
            return;
        }

        if (seatsBooked <= 0) {
            request.setAttribute("errorMsg", "Please select at least 1 seat!");
            request.getRequestDispatcher("search.jsp").forward(request, response);
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        int totalPrice = seatsBooked * pricePerSeat;

        Connection conn = null;
        PreparedStatement psCheck = null;
        PreparedStatement psUpdate = null;
        PreparedStatement psInsert = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Start transaction

            // STEP 1: Check seat availability (PREVENT OVERBOOKING)
            String checkSql = "SELECT seats_available FROM flights WHERE flight_id = ? FOR UPDATE";
            psCheck = conn.prepareStatement(checkSql);
            psCheck.setString(1, flightId);
            rs = psCheck.executeQuery();

            if (!rs.next()) {
                conn.rollback();
                request.setAttribute("errorMsg", "Flight not found!");
                request.getRequestDispatcher("search.jsp").forward(request, response);
                return;
            }

            int availableSeats = rs.getInt("seats_available");

            if (availableSeats < seatsBooked) {
                conn.rollback();
                request.setAttribute("errorMsg", "Only " + availableSeats + " seats available! Cannot book " + seatsBooked + " seats.");
                request.getRequestDispatcher("search.jsp").forward(request, response);
                return;
            }

            // STEP 2: Update seat availability
            String updateSql = "UPDATE flights SET seats_available = seats_available - ? WHERE flight_id = ?";
            psUpdate = conn.prepareStatement(updateSql);
            psUpdate.setInt(1, seatsBooked);
            psUpdate.setString(2, flightId);
            psUpdate.executeUpdate();

            // STEP 3: Generate unique booking ID in format BK2025XXXX
            String bookingId = generateBookingId();
            String bookingDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

            // STEP 4: Insert booking record
            String insertSql = "INSERT INTO bookings (booking_id, user_id, flight_id, seats_booked, total_price, booking_date) VALUES (?, ?, ?, ?, ?, ?)";
            psInsert = conn.prepareStatement(insertSql);
            psInsert.setString(1, bookingId);
            psInsert.setInt(2, userId);
            psInsert.setString(3, flightId);
            psInsert.setInt(4, seatsBooked);
            psInsert.setInt(5, totalPrice);
            psInsert.setString(6, bookingDate);

            int result = psInsert.executeUpdate();

            if (result > 0) {
                conn.commit(); // Commit transaction
                
                // Set booking details for confirmation page
                request.setAttribute("bookingId", bookingId);
                request.setAttribute("flightId", flightId);
                request.setAttribute("seatsBooked", seatsBooked);
                request.setAttribute("totalPrice", totalPrice);
                request.setAttribute("bookingDate", bookingDate);
                request.setAttribute("successMsg", "Booking successful!");
                
                request.getRequestDispatcher("confirm.jsp").forward(request, response);
            } else {
                conn.rollback();
                request.setAttribute("errorMsg", "Booking failed! Please try again.");
                request.getRequestDispatcher("search.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            request.setAttribute("errorMsg", "Database error: " + e.getMessage());
            request.getRequestDispatcher("search.jsp").forward(request, response);
        } finally {
            // Close resources
            try {
                if (conn != null) conn.setAutoCommit(true);
                if (rs != null) rs.close();
                if (psCheck != null) psCheck.close();
                if (psUpdate != null) psUpdate.close();
                if (psInsert != null) psInsert.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    private String generateBookingId() {
        String year = new SimpleDateFormat("yyyy").format(new Date());
        String randomNum = String.format("%04d", (int)(Math.random() * 10000));
        return "BK" + year + randomNum;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
