package com.cyber.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cyber.DAO.UserDAO;
import com.cyber.model.TimetableEntry;

@WebServlet("/UpdateEntry")
public class UpdateEntry extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Extract form data
        int id = Integer.parseInt(request.getParameter("id"));
        String batchCode = request.getParameter("batchCode");
        String subject = request.getParameter("subject");
        String teacher = request.getParameter("trainer_name");
        String classroom = request.getParameter("classroom");
        String timeFrom = request.getParameter("timeFrom");
        String timeTo = request.getParameter("timeTo");

        // Create a TimetableEntry object
        TimetableEntry entry = new TimetableEntry();
        entry.setId(id);
        entry.setBatchCode(batchCode);
        entry.setSubject(subject);
        entry.setTeacher(teacher);
        entry.setClassroom(classroom);
        entry.setTimeFrom(timeFrom);
        entry.setTimeTo(timeTo);

        // Update the entry in the database
        UserDAO userDAO = new UserDAO();
        userDAO.updateTimetableEntry2(entry);

        // Redirect to a confirmation page or back to the timetable view
        response.sendRedirect("createTimetable.jsp");
    }
}
