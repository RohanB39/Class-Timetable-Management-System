package com.cyber.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cyber.DAO.UserDAO;
import com.cyber.model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String role = request.getParameter("role");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        try {
            User user = userDAO.validateUser(role, username, password);
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("managerName", user.getName()); // Set the manager's name in the session
                if ("Master".equals(role)) {
                    response.sendRedirect("masterDashboard.jsp");
                } else if ("Trainer".equals(role)) {
                    response.sendRedirect("trainerDashboard.jsp");
                } else {
                    response.sendRedirect("managerDashboard.jsp");
                }
            } else {
                request.setAttribute("errorMessage", "Incorrect username and password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error: Failed to login.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
