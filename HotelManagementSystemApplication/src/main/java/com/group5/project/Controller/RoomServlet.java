package com.group5.project.Controller;


import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.group5.project.Model.Admin;
import com.group5.project.Model.Room;
import com.group5.project.Repository.RoomRepository;
import com.group5.project.Util.DatabaseUtility;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/RoomSearchServlet")
public class RoomServlet extends HttpServlet {
    private final RoomRepository roomRepo = new RoomRepository();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch all rooms from repository
    	
    	HttpSession session = request.getSession(false); // false to avoid creating a new session
        Admin admin = (session != null) ? (Admin) session.getAttribute("admin") : null;
        List<Room> allRooms = roomRepo.getAllRooms(admin.getAdminId());

        // Construct JSON response manually
        JSONArray roomsArray = new JSONArray();

        for (Room room : allRooms) {
            JSONObject roomJson = new JSONObject();
            roomJson.put("room_id", room.getRoomId());
            roomJson.put("room_name", room.getRoomName());
            roomJson.put("actual_price", room.getActualPrice());
            roomJson.put("discounted_price", room.getDiscountedPrice());
            roomJson.put("features", room.getFeatures());
            roomJson.put("start_date", room.getStartDate().toString()); // Convert LocalDate to String
            roomJson.put("end_date", room.getEndDate().toString()); // Convert LocalDate to String
            roomJson.put("max_adults", room.getMaxAdults());
            roomJson.put("max_children", room.getMaxChildren());

            roomsArray.put(roomJson);
        }

        // Send JSON response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(roomsArray.toString());
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("addRoom".equalsIgnoreCase(action)) {
            // Logic for adding a room
            String roomType = request.getParameter("roomType");
            String description = request.getParameter("description");
            BigDecimal actualPrice = new BigDecimal(request.getParameter("actualPrice"));
            BigDecimal discountedPrice = (request.getParameter("discountedPrice") != null && !request.getParameter("discountedPrice").isEmpty())
                    ? new BigDecimal(request.getParameter("discountedPrice"))
                    : null;
            String features = request.getParameter("features");
            LocalDate startDate = LocalDate.parse(request.getParameter("startDate"));
            LocalDate endDate = LocalDate.parse(request.getParameter("endDate"));
            int maxAdults = Integer.parseInt(request.getParameter("maxAdults"));
            int maxChildren = Integer.parseInt(request.getParameter("maxChildren"));
            String roomId = generateRoomId();

            HttpSession session = request.getSession(false); // false to avoid creating a new session
            Admin admin = (session != null) ? (Admin) session.getAttribute("admin") : null;
            String logId = (admin != null) ? admin.getAdminId() : "defaultLogId";
            

            // Create Room object
            Room newRoom = new Room(roomId, roomType, actualPrice, discountedPrice, features, startDate, endDate, maxAdults, maxChildren);

            // Add room to the repository
            boolean isAdded = roomRepo.addRoom(newRoom, logId);

            // Redirect based on success or failure
            if (isAdded) {
                response.sendRedirect("roomsManagement.jsp?status=success");
            } else {
                response.sendRedirect("roomsManagement.jsp?status=error");
            }

        } else if ("searchRoom".equalsIgnoreCase(action)) {
            // Existing logic for searching rooms
            String checkIn = request.getParameter("checkin");
            String checkOut = request.getParameter("checkout");
            int adults = Integer.parseInt(request.getParameter("adults"));
            int children = Integer.parseInt(request.getParameter("children"));

            // Fetch available rooms from repository
            List<Room> availableRooms = roomRepo.findAvailableRooms(checkIn, checkOut, adults, children);

            // Set rooms as a request attribute and forward to JSP
            request.setAttribute("rooms", availableRooms);
            request.getRequestDispatcher("rooms.jsp").forward(request, response);
        }else if ("updateRoom".equalsIgnoreCase(action)) {
            // Fetch updated room details from the form
            String roomId = request.getParameter("roomId");
            BigDecimal actualPrice = new BigDecimal(request.getParameter("actualPrice"));
            BigDecimal discountedPrice = (request.getParameter("discountedPrice") != null && !request.getParameter("discountedPrice").isEmpty())
                    ? new BigDecimal(request.getParameter("discountedPrice"))
                    : null;
            String features = request.getParameter("features");
            LocalDate startDate = LocalDate.parse(request.getParameter("startDate"));
            LocalDate endDate = LocalDate.parse(request.getParameter("endDate"));
            int maxAdults = Integer.parseInt(request.getParameter("maxAdults"));
            int maxChildren = Integer.parseInt(request.getParameter("maxChildren"));

            // Update room details in the repository
            boolean isUpdated = roomRepo.updateRoom(new Room(roomId, null, actualPrice, discountedPrice, features, startDate, endDate, maxAdults, maxChildren));

            // Redirect based on success or failure
            if (isUpdated) {
                response.sendRedirect("roomsManagement.jsp?status=updated");
            } else {
                response.sendRedirect("roomsManagement.jsp?status=error");
            }
        }else  if ("deleteRoom".equalsIgnoreCase(action)) {
            // Get the roomId from the request
            String roomId = request.getParameter("roomId");

            // Call the repository method to delete the room
            boolean isDeleted = roomRepo.deleteRoom(roomId);

            // Redirect based on success or failure
            if (isDeleted) {
                response.sendRedirect("roomsManagement.jsp?status=deleted");
            } else {
                response.sendRedirect("roomsManagement.jsp?status=error");
            }
        }else {
            // Handle other actions
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action parameter");
        }
    }
    
    private String generateRoomId() {
        String query = "SELECT MAX(room_id) AS maxRoomId FROM room";
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            if (resultSet.next()) {
                String maxRoomId = resultSet.getString("maxRoomId");
                if (maxRoomId != null) {
                    // Extract the numerical part of the room ID
                    int roomNumber = Integer.parseInt(maxRoomId.substring(2));
                    // Increment the number
                    roomNumber++;
                    // Return the new room ID with prefix RM
                    return "RM" + roomNumber;
                }
            }
            // If no records, start with RM1
            return "RM1";
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error generating room ID", e);
        }
    }



    
}