/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import beans.DBConnection;
import beans.Flight;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
public class SearchFlightServlet extends HttpServlet {

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
        
        String fromCity = request.getParameter("fromCity");
        String toCity = request.getParameter("toCity");
        String date = request.getParameter("date");

        if (fromCity == null || toCity == null || date == null ||
            fromCity.trim().isEmpty() || toCity.trim().isEmpty() || date.trim().isEmpty()) {
            response.sendError(400, "All search fields are required!");
            return;
        }

        if (fromCity.equalsIgnoreCase(toCity)) {
            response.sendError(400, "From and To cities cannot be the same!");
            return;
        }
        
        Cookie fromCookie = new Cookie("lastFrom", fromCity.trim());
        Cookie toCookie = new Cookie("lastTo", toCity.trim());
        fromCookie.setMaxAge(86400);
        toCookie.setMaxAge(86400);
        response.addCookie(fromCookie);
        response.addCookie(toCookie);
        
        List<Flight> flights = new ArrayList<>();
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                "SELECT flight_id, from_city, to_city, date, seats_available, price " +
                "FROM flights WHERE from_city=? AND to_city=? AND date=? AND seats_available>0")) {

            ps.setString(1, fromCity.trim());
            ps.setString(2, toCity.trim());
            ps.setString(3, date.trim());

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Flight f = new Flight();
                    f.setFlightId(rs.getString("flight_id"));
                    f.setFromCity(rs.getString("from_city"));
                    f.setToCity(rs.getString("to_city"));
                    f.setDate(rs.getString("date"));
                    f.setSeatsAvailable(rs.getInt("seats_available"));
                    f.setPrice(rs.getInt("price"));
                    flights.add(f);
                }
            }
            request.setAttribute("flights", flights);
            request.getRequestDispatcher("results.jsp").forward(request, response);

        } catch (SQLException e) {
            response.sendError(500, "Database error: " + e.getMessage());
        }
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
