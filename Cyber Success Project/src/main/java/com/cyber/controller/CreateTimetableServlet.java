// CreateTimetableServlet.java
package com.cyber.controller;

import java.io.IOException;
import java.sql.Time;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.cyber.DAO.UserDAO;
import com.cyber.model.TimetableEntry;

@WebServlet("/createTimetable")
public class CreateTimetableServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String date = request.getParameter("date");
            String day = request.getParameter("day");
            String timeFrom = request.getParameter("time_from");
            String timeTo = request.getParameter("time_to");
            String batchName = request.getParameter("batch_name");
            String classroom = request.getParameter("classroom");
            String courseName = request.getParameter("course-name");
            String trainerName = request.getParameter("trainer_name");

            // Validation can be added here
            if (date == null || day == null || batchName == null || classroom == null || courseName == null || trainerName == null) {
                throw new ServletException("All parameters are required.");
            }
            
//            if (timeFrom <= 0 || timeTo <= 0 || timeFrom >= timeTo) {
//                throw new ServletException("Invalid time range.");
//            }
            
            TimetableEntry entry = new TimetableEntry();
            entry.setDate(date);
            entry.setDay(day);
            entry.setTimeFrom(timeFrom);
            entry.setTimeTo(timeTo);
            entry.setBatchCode(batchName);
            entry.setClassroom(classroom);
            entry.setSubject(courseName);
            entry.setTeacher(trainerName);
            
            UserDAO userDAO = new UserDAO();
            userDAO.addTimetableEntry(entry);
            
            response.sendRedirect("createTimetable.jsp?date=" + date);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=number chukla aahe");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=" + e.getMessage());
        }
    }
}
