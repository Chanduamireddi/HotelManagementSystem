package com.group5.project.Repository;

import com.group5.project.Model.Admin;
import com.group5.project.Model.Room;
import com.group5.project.Util.DatabaseUtility;

import jakarta.servlet.http.HttpSession;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class RoomRepository {

	// Find available rooms based on search criteria
	public List<Room> findAvailableRooms(String checkIn, String checkOut, int adults, int children) {
	    List<Room> rooms = new ArrayList<>();
	    String query = "SELECT * FROM room r WHERE r.start_date <= ? AND r.end_date >= ? " +
	                   "AND r.max_adults >= ? AND r.max_children >= ? " +
	                   "AND r.room_id NOT IN ( " +
	                   "    SELECT b.room_id FROM bookings b WHERE NOT ( " +
	                   "        b.checkout_date <= ? OR b.checkin_date >= ? " +
	                   "    ) " +
	                   ")";

	    try (Connection conn = DatabaseUtility.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(query)) {
	        // Set parameters for the room search
	        stmt.setString(1, checkIn);
	        stmt.setString(2, checkOut);
	        stmt.setInt(3, adults);
	        stmt.setInt(4, children);

	        // Set parameters for the booking exclusion logic
	        stmt.setString(5, checkIn);
	        stmt.setString(6, checkOut);

	        ResultSet rs = stmt.executeQuery();
	        while (rs.next()) {
	            Room room = new Room(query, query, null, null, query, null, null, children, children);
	            room.setRoomId(rs.getString("room_id"));
	            room.setRoomName(rs.getString("room_name"));
	            room.setFeatures(rs.getString("features"));
	            room.setActualPrice(rs.getBigDecimal("actual_price"));
	            room.setDiscountedPrice(rs.getBigDecimal("discounted_price"));
	            room.setStartDate(rs.getDate("start_date").toLocalDate());
	            room.setEndDate(rs.getDate("end_date").toLocalDate());
	            rooms.add(room);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return rooms;
	}

    
	public List<Room> getAllRooms(String logId) {
	    List<Room> rooms = new ArrayList<>();

	    String query = "SELECT * FROM room WHERE log_id = ?";

	    try (Connection connection = DatabaseUtility.getConnection();
	         PreparedStatement statement = connection.prepareStatement(query)) {

	        // Set the logId parameter in the prepared statement
	        statement.setString(1, logId);

	        try (ResultSet resultSet = statement.executeQuery()) {
	            while (resultSet.next()) {
	                // Create a new Room object and populate it with values from the ResultSet
	                Room room = new Room(query, query, null, null, query, null, null, 0, 0);
	                room.setRoomId(resultSet.getString("room_id"));
	                room.setRoomName(resultSet.getString("room_name"));
	                room.setActualPrice(resultSet.getBigDecimal("actual_price"));
	                room.setDiscountedPrice(resultSet.getBigDecimal("discounted_price"));
	                room.setFeatures(resultSet.getString("features"));
	                room.setStartDate(resultSet.getDate("start_date").toLocalDate());
	                room.setEndDate(resultSet.getDate("end_date").toLocalDate());
	                room.setMaxAdults(resultSet.getInt("max_adults"));
	                room.setMaxChildren(resultSet.getInt("max_children"));

	                // Add the room to the list
	                rooms.add(room);
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return rooms;
	}

    
    public boolean addRoom(Room room,String logId) {
        String query = "INSERT INTO room (room_id, room_name, actual_price, discounted_price, features, start_date, end_date, max_adults, max_children,systime,log_id) "
                     + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?,?,?)";
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
             
        	 

             // Getting the current system time
             LocalDateTime sysTime = LocalDateTime.now();
            // Set parameters for the query
            statement.setString(1, room.getRoomId());  // Assuming room_id is generated or passed
            statement.setString(2, room.getRoomName());
            statement.setBigDecimal(3, room.getActualPrice());
            statement.setBigDecimal(4, room.getDiscountedPrice());  // Can be null
            statement.setString(5, room.getFeatures());
            statement.setDate(6, java.sql.Date.valueOf(room.getStartDate()));  // Convert LocalDate to java.sql.Date
            statement.setDate(7, java.sql.Date.valueOf(room.getEndDate()));    // Convert LocalDate to java.sql.Date
            statement.setInt(8, room.getMaxAdults());
            statement.setInt(9, room.getMaxChildren());
            statement.setTimestamp(10, java.sql.Timestamp.valueOf(sysTime));
            statement.setString(11, logId);

            

            // Execute update
            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;  // Return true if insertion was successful
        } catch (SQLException e) {
            e.printStackTrace();  // Log exception
            return false;  // Return false if any exception occurs
        }
    }
    
    public boolean updateRoom(Room room) {
        String query = "UPDATE room SET actual_price = ?, discounted_price = ?, features = ?, start_date = ?, end_date = ?, max_adults = ?, max_children = ? "
                     + "WHERE room_id = ?";
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            // Set parameters for the query
            statement.setBigDecimal(1, room.getActualPrice());
            statement.setBigDecimal(2, room.getDiscountedPrice());
            statement.setString(3, room.getFeatures());
            statement.setDate(4, java.sql.Date.valueOf(room.getStartDate()));
            statement.setDate(5, java.sql.Date.valueOf(room.getEndDate()));
            statement.setInt(6, room.getMaxAdults());
            statement.setInt(7, room.getMaxChildren());
            statement.setString(8, room.getRoomId());

            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0; // Return true if update was successful
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteRoom(String roomId) {
        String query = "DELETE FROM room WHERE room_id = ?";
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, roomId);

            int rowsDeleted = statement.executeUpdate();
            return rowsDeleted > 0; // Return true if deletion was successful
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


}