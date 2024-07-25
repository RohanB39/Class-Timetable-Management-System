package com.cyber.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cyber.DAO.UserDAO;

/**
 * Servlet implementation class EditFrom
 */
@WebServlet("/editForm")
public class EditFrom extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int entryId = Integer.parseInt(request.getParameter("entryId"));
		String timeFrom = request.getParameter("time_from");
		String timeTo = request.getParameter("time_to");
		String batchName = request.getParameter("batch_name");
		String classroom = request.getParameter("classroom");
		String courseName = request.getParameter("course-name");
		String trainerName = request.getParameter("trainer_name");

		UserDAO userDAO = new UserDAO();
		boolean isUpdated = userDAO.updateEntry(entryId, timeFrom, timeTo, batchName, classroom, courseName,
				trainerName);

		if (isUpdated) {
			response.sendRedirect("editTimetable.jsp");
		} else {
			response.sendRedirect("error.jsp");
		}

	}
}
