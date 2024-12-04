package com.group5.project.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.group5.project.Model.Admin;
import com.group5.project.Util.DatabaseUtility;
import com.group5.project.Util.PasswordUtils;

public class AdminRepository {
	public boolean saveAdmin(Admin admin) {
        String sql = "INSERT INTO admin (admin_id, first_name, middle_name, last_name, email, phno, password) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseUtility.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Encrypt password using bcrypt
            String hashedPassword = PasswordUtils.hashPassword(admin.getPassword());

            stmt.setString(1, admin.getAdminId());
            stmt.setString(2, admin.getFirstName());
            stmt.setString(3, admin.getMiddleName());
            stmt.setString(4, admin.getLastName());
            stmt.setString(5, admin.getEmail());
            stmt.setString(6, admin.getPhone());
            stmt.setString(7, hashedPassword);

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
	
	public Admin findAdminByEmail(String email) {
        try (Connection conn = DatabaseUtility.getConnection()) {
            String query = "SELECT * FROM admin WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Admin admin = new Admin();
                admin.setAdminId(rs.getString("admin_id"));
                admin.setFirstName(rs.getString("first_name"));
                admin.setMiddleName(rs.getString("middle_name"));
                admin.setLastName(rs.getString("last_name"));
                admin.setEmail(rs.getString("email"));
                admin.setPhone(rs.getString("phno"));
                admin.setPassword(rs.getString("password"));
                return admin;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
	
	public void updateAdmin(Admin admin) {
        String query = "UPDATE admin SET first_name = ?, middle_name = ?, last_name = ?, email = ?, phno = ? WHERE email = ?";
        
        try (Connection conn = DatabaseUtility.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, admin.getFirstName());
            stmt.setString(2, admin.getMiddleName());
            stmt.setString(3, admin.getLastName());
            stmt.setString(4, admin.getEmail());
            stmt.setString(5, admin.getPhone());
            stmt.setString(6, admin.getEmail());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
