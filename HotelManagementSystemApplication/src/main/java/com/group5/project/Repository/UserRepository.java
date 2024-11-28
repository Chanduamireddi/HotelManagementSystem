package com.group5.project.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.group5.project.Model.User;
import com.group5.project.Util.DatabaseUtility;
import com.group5.project.Util.PasswordUtils;

public class UserRepository {
	public boolean saveUser(User user) {
        String sql = "INSERT INTO users (user_id, first_name, last_name, email, phno, password) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseUtility.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Encrypt password using bcrypt
            String hashedPassword = PasswordUtils.hashPassword(user.getPassword());

            stmt.setString(1, user.getUserId());
            stmt.setString(2, user.getFirstName());
            stmt.setString(3, user.getLastName());
            stmt.setString(4, user.getEmail());
            stmt.setString(5, user.getPhone());
            stmt.setString(6, hashedPassword);

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
	public User findUserByEmail(String email) {
        try (Connection conn = DatabaseUtility.getConnection()) {
            String query = "SELECT * FROM users WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getString("user_id"));
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phno"));
                user.setPassword(rs.getString("password"));
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
