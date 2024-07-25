package com.cyber.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cyber.DAO.UserDAO;
import com.cyber.model.TimetableEntry;

@WebServlet("/editPopup")
public class EditPopup extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("entryId"));
            String timeFrom = request.getParameter("time_from");
            String timeTo = request.getParameter("time_to");
            String batchCode = request.getParameter("batch_name");
            String classroom = request.getParameter("classroom");
            String teacher = request.getParameter("trainer_name");
            String subject = request.getParameter("course-name");

            // Populate TimetableEntry object
            TimetableEntry entry = new TimetableEntry();
            entry.setId(id);
            entry.setTimeFrom(timeFrom);
            entry.setTimeTo(timeTo);
            entry.setBatchCode(batchCode);
            entry.setClassroom(classroom);
            entry.setTeacher(teacher);
            entry.setSubject(subject);

            // Update the entry in the database
            UserDAO userDao = new UserDAO();
            userDao.updateTimetableEntry2(entry);

            // Redirect or forward to the original timetable page
            response.sendRedirect("editTimetable.jsp");
        } catch (NumberFormatException e) {
            System.err.println("Entry ID is missing or invalid: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Entry ID is missing or invalid.");
        }
    }
}
