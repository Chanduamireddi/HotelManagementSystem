package com.group5.project.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.group5.project.Util.DatabaseUtility;

public class BookingRepository {

    public boolean saveBooking(String userId, String roomId, String checkInDate, String checkOutDate, double totalPrice,String guests) {
        String query = "INSERT INTO bookings (booking_id, user_id, room_id, checkin_date, checkout_date, guests, amount) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, "BK" + System.currentTimeMillis()); // Generate unique booking ID
            ps.setString(2, userId);
            ps.setString(3, roomId);
            ps.setString(4, checkInDate);
            ps.setString(5, checkOutDate);
            ps.setInt(6, Integer.parseInt(guests)); // Example: Guests (can be dynamic if required)
            ps.setDouble(7, totalPrice);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
