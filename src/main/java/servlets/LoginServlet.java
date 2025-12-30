package servlets;

import beans.DBConnection;
import beans.User;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.ServletException;  // 👈 correct now

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * LoginServlet - Handles user authentication
 * Creates session on successful login and stores user details
 */
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("errorMsg", "Email and password are required!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "SELECT id, name, email, role FROM users WHERE email = ? AND password = ?")) {

            ps.setString(1, email.trim());
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    HttpSession session = request.getSession(true);
                    session.setAttribute("userId", rs.getInt("id"));
                    session.setAttribute("userName", rs.getString("name"));
                    session.setAttribute("userEmail", rs.getString("email"));
                    session.setAttribute("userRole", rs.getString("role"));
                    session.setMaxInactiveInterval(30 * 60);

                    if ("on".equalsIgnoreCase(rememberMe)) {
                        Cookie userCookie = new Cookie("userEmail", email);
                        userCookie.setMaxAge(7 * 24 * 60 * 60);
                        response.addCookie(userCookie);
                    }

                    if ("admin".equalsIgnoreCase(rs.getString("role"))) {
                        response.sendRedirect("admin.jsp");
                    } else {
                        response.sendRedirect("search.jsp");
                    }
                } else {
                    request.setAttribute("errorMsg", "Invalid email or password!");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            }
        } catch (SQLException e) {
            request.setAttribute("errorMsg", "Database error: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}
