package com.cyber.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cyber.DAO.UserDAO;
import com.cyber.model.TimetableEntry;

@WebServlet("/fetchTimetableEntries")
public class FetchTimetableEntriesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String date = request.getParameter("date");

        UserDAO userDao = new UserDAO();
        List<TimetableEntry> timetableEntries = userDao.getTimetableEntriesByDate(date);

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<table>");
        out.println("<thead><tr><th>ID</th><th>Time From</th><th>Time To</th><th>Classroom</th><th>Batch</th><th>Trainer</th><th>Actions</th></tr></thead>");
        out.println("<tbody>");
        for (TimetableEntry entry : timetableEntries) {
            out.println("<tr>");
            out.println("<td>" + entry.getId() + "</td>");
            out.println("<td>" + entry.getTimeFrom() + "</td>");
            out.println("<td>" + entry.getTimeTo() + "</td>");
            out.println("<td>" + entry.getClassroom() + "</td>");
            out.println("<td>" + entry.getBatchCode() + "</td>");
            out.println("<td>" + entry.getTeacher() + "</td>");
            out.println("<td>\r\n"
            		+ "    <button type=\"button\" class=\"edit-btn\" onclick=\"showForm('<%= entry.getId() %>', '<%= entry.getBatchCode() %>', '<%= entry.getSubject() %>', '<%= entry.getTeacher() %>', '<%= entry.getTimeFrom() %>', '<%= entry.getTimeTo() %>')\">Edit</button>\r\n"
            		+ "    <button type=\"button\" class=\"delete-btn\" style=\"background-color: #e57373;\">Delete</button>\r\n"
            		+ "</td>");
            out.println("</tr>");
        }
        out.println("</tbody>");
        out.println("</table>");
        out.close();
    }
}
