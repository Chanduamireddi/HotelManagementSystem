package com.group5.project.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.group5.project.Model.Booking;
import com.group5.project.Util.DatabaseUtility;

public class BookingRepository {

	public boolean saveBooking(String userId, String roomId, String checkInDate, String checkOutDate, double totalPrice, String guests, String status,String adminId) {
	    String query = "INSERT INTO bookings (booking_id, user_id, room_id, checkin_date, checkout_date, guests, amount, status,admin_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?,?)";
	    
	    // Generate unique booking ID
	    String bookingId = "BK" + System.currentTimeMillis();
	    
	    try (Connection connection = DatabaseUtility.getConnection();
	         PreparedStatement ps = connection.prepareStatement(query)) {

	        // Set parameters for the PreparedStatement
	        ps.setString(1, bookingId);
	        ps.setString(2, userId);
	        ps.setString(3, roomId);
	        ps.setString(4, checkInDate); // Assuming checkInDate is in proper format (e.g., YYYY-MM-DD)
	        ps.setString(5, checkOutDate); // Assuming checkOutDate is in proper format (e.g., YYYY-MM-DD)
	        ps.setInt(6, Integer.parseInt(guests)); // Convert guests string to integer
	        ps.setDouble(7, totalPrice);
	        ps.setString(8, status);
	        ps.setString(9, adminId);


	        // Execute the query and check if insertion was successful
	        return ps.executeUpdate() > 0;
	    } catch (SQLException e) {
	        // Print stack trace for debugging (can be replaced with proper logging)
	        System.err.println("Error occurred while saving booking: " + e.getMessage());
	        e.printStackTrace();
	        return false;
	    } catch (NumberFormatException e) {
	        // Handle case where guests is not a valid integer
	        System.err.println("Invalid number format for guests: " + guests);
	        e.printStackTrace();
	        return false;
	    }
	}

    
    public Map<String, Double> getMonthlyIncome() {
        Map<String, Double> incomeData = new HashMap<>();
        try (Connection connection = DatabaseUtility.getConnection()) {
            String query = "SELECT DATE_FORMAT(checkin_date, '%Y-%m') AS month, SUM(amount) AS income " +
                           "FROM bookings GROUP BY DATE_FORMAT(checkin_date, '%Y-%m') ORDER BY month";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    String month = resultSet.getString("month");
                    double income = resultSet.getDouble("income");
                    incomeData.put(month, income);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return incomeData;
    }
    public List<Map<String, Object>> getAllBookingsWithUserNames() {
        List<Map<String, Object>> bookingsList = new ArrayList<>();
        String bookingQuery = "SELECT booking_id, room_id, checkin_date, checkout_date, guests, status, user_id FROM bookings";
        String userQuery = "SELECT first_name FROM users WHERE user_id = ?";
        String adminQuery = "SELECT first_name FROM admin WHERE admin_id = ?";

        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement bookingStatement = connection.prepareStatement(bookingQuery);
             ResultSet bookingResultSet = bookingStatement.executeQuery()) {

            while (bookingResultSet.next()) {
                Map<String, Object> booking = new HashMap<>();
                String userId = bookingResultSet.getString("user_id");

                booking.put("bookingId", bookingResultSet.getString("booking_id"));
                booking.put("roomNo", bookingResultSet.getString("room_id"));
                // Fetch dates as strings to maintain the exact format from the database
                booking.put("checkIn", bookingResultSet.getString("checkin_date"));
                booking.put("checkOut", bookingResultSet.getString("checkout_date"));
                booking.put("guests", bookingResultSet.getInt("guests"));
                booking.put("status", bookingResultSet.getString("status"));
                booking.put("userId", userId);

                // Determine the username based on userId
                String username = null;
                try (PreparedStatement userStatement = connection.prepareStatement(
                        userId.startsWith("USR") ? userQuery : adminQuery)) {
                    userStatement.setString(1, userId);
                    try (ResultSet userResultSet = userStatement.executeQuery()) {
                        if (userResultSet.next()) {
                            username = userResultSet.getString("first_name");
                        }
                    }
                }

                booking.put("username", username);
                bookingsList.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookingsList;
    }

    
    public boolean updateBooking(String bookingId, String checkInDate, String checkOutDate, String status) {
    	System.out.println(checkInDate );
        String query = "UPDATE bookings SET checkin_date = ?, checkout_date = ?, status = ? WHERE booking_id = ?";
        
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, checkInDate);  // Update check-in date
            ps.setString(2,  checkOutDate); // Update check-out date
            ps.setString(3, status);       // Update booking status
            ps.setString(4, bookingId);   // Where clause: booking_id

            // Execute update
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteBooking(String bookingId) {
        String query = "DELETE FROM bookings WHERE booking_id = ?";

        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, bookingId);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Booking> getBookingsByUserId(String userId) throws Exception {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT booking_id, room_id, checkin_date, checkout_date, amount, status "
                     + "FROM bookings "
                     + "WHERE user_id = ?";

        Connection connection=DatabaseUtility.getConnection();
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Booking booking = new Booking();
                    booking.setBookingId(rs.getString("booking_id"));
                    booking.setRoomType(rs.getString("room_id"));
                    booking.setCheckInDate(rs.getDate("checkin_date"));
                    booking.setCheckOutDate(rs.getDate("checkout_date"));
                    booking.setTotalPrice(rs.getDouble("amount"));
                    booking.setStatus(rs.getString("status"));

                    bookings.add(booking);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error fetching bookings for user ID: " + userId, e);
        }

        return bookings;
    }
    
    public boolean updateBookingStatus(String bookingId, String status) {
        String query = "UPDATE bookings SET status = ? WHERE booking_id = ?";
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, status);
            stmt.setString(2, bookingId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Return true if the update was successful
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }



}
