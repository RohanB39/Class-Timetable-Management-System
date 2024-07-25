package com.cyber.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.cyber.dbconn.DatabaseUtil;
import com.cyber.model.BatchEntry;
import com.cyber.model.TimetableEntry;
import com.cyber.model.User;

public class UserDAO {

	public User validateUser(String role, String username, String password) throws SQLException {
		String sql;
		if ("Master".equals(role)) {
			if ("admin".equals(username) && "masterpassword".equals(password)) {
				User user = new User();
				user.setUsername(username);
				user.setPassword(password);
				return user;
			} else {
				return null;
			}
		} else {
			sql = getSqlQueryForRole(role);
			try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
				stmt.setString(1, username);
				stmt.setString(2, password);
				try (ResultSet rs = stmt.executeQuery()) {
					if (rs.next()) {
						User user = new User();
						if ("Manager".equals(role)) {
							user.setUsername(rs.getString("manager_username"));
							user.setPassword(rs.getString("manager_password"));
							user.setName(rs.getString("manager_name")); // Set the manager's name
						} else if ("Trainer".equals(role)) {
							user.setUsername(rs.getString("trainer_username"));
							user.setPassword(rs.getString("trainer_password"));
						}
						return user;
					} else {
						return null;
					}
				}
			}
		}
	}

	private String getSqlQueryForRole(String role) {
		switch (role) {
		case "Manager":
			return "SELECT * FROM manager_details WHERE manager_username = ? AND manager_password = ?";
		case "Trainer":
			return "SELECT * FROM trainer_details WHERE trainer_username = ? AND trainer_password = ?";
		default:
			return "";
		}
	}

	public void addTimetableEntry(TimetableEntry entry) throws Exception {
		String sql = "INSERT INTO Timetable_Details (date, day, time_from, time_to, batch_code, classroom, teacher, course) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, entry.getDate());
			stmt.setString(2, entry.getDay());
			stmt.setString(3, entry.getTimeFrom());
			stmt.setString(4, entry.getTimeTo());
			stmt.setString(5, entry.getBatchCode());
			stmt.setString(6, entry.getClassroom());
			stmt.setString(7, entry.getTeacher());
			stmt.setString(8, entry.getSubject());
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new Exception("Error inserting timetable entry: " + e.getMessage());
		}
	}

	public static List<TimetableEntry> getTimetableEntriesByDate(String date) {
		List<TimetableEntry> entries = new ArrayList<>();
		try (Connection conn = DatabaseUtil.getConnection()) {
			String query = "SELECT * FROM Timetable_Details WHERE date = ?";
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, date);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				TimetableEntry entry = new TimetableEntry();
				entry.setId(rs.getInt("id"));
				entry.setDate(rs.getString("date"));
				entry.setDay(rs.getString("day"));
				entry.setTimeFrom(rs.getString("time_from"));
				entry.setTimeTo(rs.getString("time_to"));
				entry.setBatchCode(rs.getString("batch_code"));
				entry.setClassroom(rs.getString("classroom"));
				entry.setSubject(rs.getString("course"));
				entry.setTeacher(rs.getString("teacher"));

				entries.add(entry);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return entries;
	}

	private static int timeToInt(Time time) {
		int hours = time.toLocalTime().getHour();
		int minutes = time.toLocalTime().getMinute();
		return hours * 100 + minutes;
	}

	// Method to fetch trainer names from database
	public List<String> getAllTrainerNames() throws SQLException {
		List<String> trainerNames = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			String sql = "SELECT trainer_name FROM trainer_details";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while (rs.next()) {
				trainerNames.add(rs.getString("trainer_name"));
			}
		} catch (SQLException e) {
			e.printStackTrace(); // Print stack trace for debugging
			throw e; // Rethrow the exception to handle it at the caller level
		} finally {
			// Close resources in finally block
			if (rs != null)
				rs.close();
			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
		}
		return trainerNames;
	}

	// Method to fetch batch names from database
	public List<String> getAllBatchNames() throws SQLException {
		List<String> batchNames = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			String sql = "SELECT batchCode FROM batchcodes";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while (rs.next()) {
				batchNames.add(rs.getString("batchCode"));
			}
		} catch (SQLException e) {
			e.printStackTrace(); // Print stack trace for debugging
			throw e; // Rethrow the exception to handle it at the caller level
		} finally {
			// Close resources in finally block
			if (rs != null)
				rs.close();
			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
		}
		return batchNames;
	}

	public void addBatchDetails(BatchEntry batch) throws Exception {
		String sql = "INSERT INTO batchcodes (batchCode, course) VALUES (?, ?)";
		try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, batch.getBatchCode());
			stmt.setString(2, batch.getCourseDetails());
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new Exception("Error inserting timetable entry: " + e.getMessage());
		}
	}

	public void deleteBatchDetails(String batchCode) throws Exception {
		String sql = "DELETE FROM batchcodes WHERE batchCode = ?";
		try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, batchCode);
			int rowsAffected = stmt.executeUpdate();
			if (rowsAffected == 0) {
				throw new Exception("No batch found with batchCode: " + batchCode);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new Exception("Error deleting batch entry: " + e.getMessage());
		}
	}

	public boolean isBatchExists(String batchCode) throws Exception {
		boolean exists = false;
		String query = "SELECT COUNT(*) FROM batchcodes WHERE batchCode = ?";

		try (Connection con = DatabaseUtil.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
			ps.setString(1, batchCode);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					exists = rs.getInt(1) > 0;
				}
			}
		}

		return exists;
	}

	public List<BatchEntry> getAllBatchDetails() throws Exception {
		List<BatchEntry> batchDetails = new ArrayList<>();
		String sql = "SELECT batchCode, course FROM batchcodes";

		try (Connection conn = DatabaseUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql);
				ResultSet rs = stmt.executeQuery()) {

			while (rs.next()) {
				BatchEntry batch = new BatchEntry();
				batch.setBatchCode(rs.getString("batchCode"));
				batch.setCourseDetails(rs.getString("course"));
				batchDetails.add(batch);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new Exception("Error retrieving batch details: " + e.getMessage());
		}

		return batchDetails;
	}

	public int getTotalBatchCount() throws Exception {
		int totalBatches = 0;
		String sql = "SELECT COUNT(*) AS total FROM batchcodes";

		try (Connection conn = DatabaseUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql);
				ResultSet rs = stmt.executeQuery()) {

			if (rs.next()) {
				totalBatches = rs.getInt("total");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new Exception("Error counting total batches: " + e.getMessage());
		}

		return totalBatches;
	}

	public void updateTimetableEntry(TimetableEntry entry) {
		String sql = "UPDATE timetable_details SET date=?, day=?, time_from=?, time_to=?, batch_code=?, classroom=?, teacher=?, course=? WHERE id=?";
		try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, entry.getDate());
			pstmt.setString(2, entry.getDay());
			pstmt.setString(3, entry.getTimeFrom());
			pstmt.setString(4, entry.getTimeTo());
			pstmt.setString(5, entry.getBatchCode());
			pstmt.setString(6, entry.getClassroom());
			pstmt.setString(7, entry.getTeacher());
			pstmt.setString(8, entry.getSubject());
			pstmt.setInt(9, entry.getId());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public boolean updateEntry(int entryId, String timeFrom, String timeTo, String batchName, String classroom,
			String courseName, String trainerName) {
		boolean updated = false;
		try (Connection con = DatabaseUtil.getConnection()) {
			String query = "UPDATE timetable_details SET time_from = ?, time_to = ?, batch_name = ?, classroom = ?, course_name = ?, trainer_name = ? WHERE id = ?";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, timeFrom);
			ps.setString(2, timeTo);
			ps.setString(3, batchName);
			ps.setString(4, classroom);
			ps.setString(5, courseName);
			ps.setString(6, trainerName);
			ps.setInt(7, entryId);

			updated = ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return updated;
	}

	private List<TimetableEntry> getEntriesForDate(String date) throws SQLException {
		List<TimetableEntry> entries = new ArrayList<>();
		String sql = "SELECT * FROM timetable_details WHERE date = ?";

		try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

			stmt.setString(1, date);
			try (ResultSet rs = stmt.executeQuery()) {
				while (rs.next()) {
					TimetableEntry entry = new TimetableEntry();
					entry.setDate(rs.getString("date"));
					entry.setDay(rs.getString("day"));
					entry.setTimeFrom(rs.getString("time_from"));
					entry.setTimeTo(rs.getString("time_to"));
					entry.setBatchCode(rs.getString("batch_code"));
					entry.setClassroom(rs.getString("classroom"));
					entry.setTeacher(rs.getString("teacher"));
					entry.setSubject(rs.getString("course"));
					entries.add(entry);
				}
			}
		}
		return entries;
	}
	
	  // Method to insert a list of entries
	private void insertEntries(List<TimetableEntry> entries) throws SQLException {
        String sql = "INSERT INTO timetable_details (date, day, time_from, time_to, batch_code, classroom, teacher, course) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (TimetableEntry entry : entries) {
                stmt.setString(1, entry.getDate());
                stmt.setString(2, entry.getDay());
                stmt.setString(3, entry.getTimeFrom());
                stmt.setString(4, entry.getTimeTo());
                stmt.setString(5, entry.getBatchCode());
                stmt.setString(6, entry.getClassroom());
                stmt.setString(7, entry.getTeacher());
                stmt.setString(8, entry.getSubject());
                stmt.addBatch();
            }
            stmt.executeBatch();
        }
    }
	
	// Method to add yesterday's entries with today's date
    public void addYesterdayEntries(String today) throws SQLException {
        String yesterday = LocalDate.parse(today).minusDays(1).toString();
        List<TimetableEntry> entries = getEntriesForDate(yesterday);
        for (TimetableEntry entry : entries) {
            entry.setDate(today);
        }
        insertEntries(entries);
    }
    
    // If no entries for yesterday, check the day before
    public void addPreviousDayEntries(String today) throws SQLException {
        String yesterday = LocalDate.parse(today).minusDays(1).toString();
        List<TimetableEntry> entries = getEntriesForDate(yesterday);
        if (entries.isEmpty()) {
            String dayBeforeYesterday = LocalDate.parse(yesterday).minusDays(1).toString();
            entries = getEntriesForDate(dayBeforeYesterday);
        }
        if (!entries.isEmpty()) {
            for (TimetableEntry entry : entries) {
                entry.setDate(today);
            }
            insertEntries(entries);
        }
    }
    
    public void deleteTodaysData(String date) {
    	String sql = "delete from timetable_details where date = ?";
    	try {
			Connection con = DatabaseUtil.getConnection();
			PreparedStatement ptmt = con.prepareStatement(sql);
			ptmt.setString(1, date);
			ptmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    }
    
    public void updateTimetableEntry2(TimetableEntry entry) {
		String sql = "UPDATE timetable_details SET time_from=?, time_to=?, batch_code=?, classroom=?, teacher=?, course=? WHERE id=?";
		try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, entry.getTimeFrom());
			pstmt.setString(2, entry.getTimeTo());
			pstmt.setString(3, entry.getBatchCode());
			pstmt.setString(4, entry.getClassroom());
			pstmt.setString(5, entry.getTeacher());
			pstmt.setString(6, entry.getSubject());
			pstmt.setInt(7, entry.getId());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
    
    public void deleteTimetableEntry2(int id) {
		String sql = "DELETE FROM timetable_details WHERE id=?";
		try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
