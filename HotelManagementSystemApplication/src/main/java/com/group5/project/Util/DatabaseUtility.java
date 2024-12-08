package com.group5.project.Util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseUtility {

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3306/hotelreservation?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASS = "Chandu@123";

    // Static block to load the MySQL driver
    static {
        try {
            // Load the MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL Driver loaded successfully.");
        } catch (ClassNotFoundException e) {
            System.err.println("Error loading MySQL Driver: " + e.getMessage());
            throw new RuntimeException("Failed to load MySQL Driver", e);
        }
    }

    // Method to establish and return a database connection
    public static Connection getConnection() throws SQLException {
        try {
            Connection connection = DriverManager.getConnection(DB_URL, USER, PASS);
            System.out.println("Database connection established.");
            return connection;
        } catch (SQLException e) {
            System.err.println("Error establishing database connection: " + e.getMessage());
            throw e;
        }
    }
}
