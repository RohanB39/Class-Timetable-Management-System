package com.cyber.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cyber.DAO.UserDAO;
import com.cyber.model.BatchEntry;

@WebServlet("/AddBatch")
public class AddBatch extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String batchCode = request.getParameter("batchcode");
            String courseName = request.getParameter("course-name");
            
            UserDAO userdao = new UserDAO();
            
            // Check if batch already exists
            if (userdao.isBatchExists(batchCode)) {
                request.setAttribute("errorMessage", "Batch " + batchCode + " is already present");
            } else {
                BatchEntry batchentry = new BatchEntry();
                batchentry.setBatchCode(batchCode);
                batchentry.setCourseDetails(courseName);
                
                userdao.addBatchDetails(batchentry);
                request.setAttribute("successMessage", "Batch " + batchCode + " added successfully");
            }
            
            // Forward back to the AddBatch.jsp page
            request.getRequestDispatcher("AddBatch.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions or set error message if needed
        }
    }
}
