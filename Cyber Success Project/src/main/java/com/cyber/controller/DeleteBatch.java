package com.cyber.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cyber.DAO.UserDAO;
import com.cyber.model.BatchEntry;

@WebServlet("/DeleteBatch")
public class DeleteBatch extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String batchCode = request.getParameter("batch_name");
			UserDAO userdao = new UserDAO();
			 // Check if batch already exists
            if (userdao.isBatchExists(batchCode)) {
            	userdao.deleteBatchDetails(batchCode);
                request.setAttribute("successMessage", "Batch " + batchCode + " is Deleted Successfully");
            } else {
                request.setAttribute("errorMessage", "Batch " + batchCode + "Not Found");
            }
            
            // Forward back to the AddBatch.jsp page
            request.getRequestDispatcher("DeleteBatch.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
