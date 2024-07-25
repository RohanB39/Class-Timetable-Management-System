package com.cyber.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cyber.DAO.UserDAO;
import com.cyber.model.TimetableEntry;

/**
 * Servlet implementation class DeleteEntry
 */
@WebServlet("/DeleteEntry")
public class DeleteEntry extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int id = Integer.parseInt(request.getParameter("id"));
			TimetableEntry entry = new TimetableEntry();
			entry.setId(id);
			UserDAO userDAO = new UserDAO();
			userDAO.deleteTimetableEntry2(id);
			response.sendRedirect("createTimetable.jsp?id gone=" + id);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
