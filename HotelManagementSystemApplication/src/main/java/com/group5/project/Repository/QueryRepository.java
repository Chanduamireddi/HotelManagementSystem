package com.group5.project.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.group5.project.Model.Query;
import com.group5.project.Util.DatabaseUtility;

public class QueryRepository {

	public void saveQuery(Query query) {
        String sql = "INSERT INTO queries (user_id, name, email, message) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseUtility.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, query.getUserId());
            stmt.setString(2, query.getName());
            stmt.setString(3, query.getEmail());
            stmt.setString(4, query.getMessage());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
