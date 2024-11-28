package com.group5.project.Repository;

import com.group5.project.Model.Room;
import com.group5.project.Util.DatabaseUtility;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RoomRepository {

    // Find available rooms based on search criteria
    public List<Room> findAvailableRooms(String checkIn, String checkOut, int adults, int children) {
        List<Room> rooms = new ArrayList<>();
        String query = "SELECT * FROM room WHERE start_date >= ? AND end_date <= ? AND max_adults <= ? AND max_children <= ?";

        try (Connection conn = DatabaseUtility.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, checkIn);
            stmt.setString(2, checkOut);
            stmt.setInt(3, adults);
            stmt.setInt(4, children);


            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Room room = new Room();
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
}
