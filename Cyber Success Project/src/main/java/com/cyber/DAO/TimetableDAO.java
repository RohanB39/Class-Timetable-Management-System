package com.cyber.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.cyber.model.TimetableEntry;
import com.cyber.dbconn.DatabaseUtil;

public class TimetableDAO {

    private static final String INSERT_TIMETABLE_SQL = "INSERT INTO timetable (date, day, time_from, time_to, batch_name, classroom_name, teacher_name, subject_name) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT_TIMETABLE_BY_DATE = "SELECT * FROM timetable WHERE date = ?";

    public void insertTimetableEntry(TimetableEntry entry) throws SQLException {
        try (Connection connection = DatabaseUtil.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(INSERT_TIMETABLE_SQL)) {
            preparedStatement.setString(1, entry.getDate());
            preparedStatement.setString(2, entry.getDay());
            preparedStatement.setString(3, entry.getTimeFrom());
            preparedStatement.setString(4, entry.getTimeTo());
            preparedStatement.setString(5, entry.getBatchCode());
            preparedStatement.setString(6, entry.getClassroom());
            preparedStatement.setString(7, entry.getTeacher());
            preparedStatement.setString(8, entry.getSubject());
            preparedStatement.executeUpdate();
        }
    }

    public List<TimetableEntry> selectTimetableEntriesByDate(String date) throws SQLException {
        List<TimetableEntry> timetableEntries = new ArrayList<>();
        try (Connection connection = DatabaseUtil.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SELECT_TIMETABLE_BY_DATE)) {
            preparedStatement.setString(1, date);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                String day = rs.getString("day");
                String timeFrom = rs.getString("time_from");
                String timeTo = rs.getString("time_to");
                String batchName = rs.getString("batch_name");
                String classroomName = rs.getString("classroom_name");
                String teacherName = rs.getString("teacher_name");
                String subjectName = rs.getString("subject_name");
                timetableEntries.add(new TimetableEntry());
            }
        }
        return timetableEntries;
    }
}
