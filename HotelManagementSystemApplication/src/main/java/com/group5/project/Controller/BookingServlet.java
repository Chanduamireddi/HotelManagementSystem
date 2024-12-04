package com.group5.project.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.group5.project.Model.Admin;
import com.group5.project.Model.User;
import com.group5.project.Repository.BookingRepository;

import java.io.IOException;
import java.util.Map;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private final BookingRepository bookingRepo = new BookingRepository();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Get session without creating a new one
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        Admin admin = (session != null) ? (Admin) session.getAttribute("admin") : null;


        if (user == null && admin== null ) {
            // Return a JSON response if the session is invalid to avoid unintended redirection
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"message\": \"Session invalid. Please log in.\"}");
            return;
        }

        // Extract the action parameter to determine the operation
        String action = request.getParameter("action");
        System.out.println("Received action: " + action); // Log the action for debugging

        if ("updateBooking".equalsIgnoreCase(action)) {
            handleEditBooking(request, response);
        } else if ("newBooking".equalsIgnoreCase(action)) {
            handleNewBooking(request, response, user,admin);
        }else if ("deleteBooking".equalsIgnoreCase(action)) {
            String bookingId = request.getParameter("bookingId");

            if (bookingId == null || bookingId.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"message\": \"Missing booking ID.\"}");
                return;
            }

            try {
                boolean result = bookingRepo.deleteBooking(bookingId);
                if (result) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("{\"message\": \"Booking deleted successfully.\"}");
                } else {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("{\"message\": \"Failed to delete booking.\"}");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"message\": \"An error occurred while deleting the booking.\"}");
            }
        }
 
        else {
            // Invalid or missing action parameter
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"message\": \"Invalid or missing action parameter.\"}");
        }
    }

    private void handleNewBooking(HttpServletRequest request, HttpServletResponse response, User user,Admin admin) throws ServletException, IOException {
        try {
        	String userId ="",adminId="";
            if(user==null) adminId=admin.getAdminId();
            else      userId = user.getUserId();

            
            String roomId = request.getParameter("roomId");
            String checkInDate = request.getParameter("checkin");
            String checkOutDate = request.getParameter("checkout");
            double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));
            String guests = request.getParameter("guests");
            String status = userId.startsWith("USR") ? "confirmed" : "pending";

            boolean result = bookingRepo.saveBooking(userId, roomId, checkInDate, checkOutDate, totalPrice, guests, status,adminId);

            String message = result ? "Booking successful!" : "Booking failed. Please try again.";
            response.setStatus(result ? HttpServletResponse.SC_OK : HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"message\": \"" + message + "\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"message\": \"An error occurred while processing the booking.\"}");
        }
    }

    private void handleEditBooking(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // Extract parameters directly from the request
            String bookingId = request.getParameter("bookingId");
            String checkInDate = request.getParameter("checkIn");
            String checkOutDate = request.getParameter("checkOut");
            String status = request.getParameter("status");

            // Log parameters for debugging
            System.out.println("Booking ID: " + bookingId);
            System.out.println("Check-in Date: " + checkInDate);
            System.out.println("Check-out Date: " + checkOutDate);
            System.out.println("Status: " + status);

            if (bookingId == null || status == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"message\": \"Missing required parameters\"}");
                return;
            }

            // Call repository to update the booking
            boolean result = bookingRepo.updateBooking(bookingId, checkInDate, checkOutDate, status);

            // Send response
            if (result) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("{\"message\": \"Booking updated successfully\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"message\": \"Failed to update booking\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"message\": \"An error occurred while updating the booking\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("fetchBookings".equalsIgnoreCase(action)) {
            fetchBookings(response);
        } else if ("true".equalsIgnoreCase(request.getParameter("json"))) {
            fetchMonthlyIncome(response);
        } else {
            // Default: Forward to JSP
            request.getRequestDispatcher("reports.jsp").forward(request, response);
        }
    }

    private void fetchBookings(HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // Fetch bookings as they are stored in the database
            var bookings = bookingRepo.getAllBookingsWithUserNames();
            Gson gson = new Gson();
            String jsonResponse = gson.toJson(bookings);

            // Write the JSON response back to the client
            response.getWriter().write(jsonResponse);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Unable to fetch bookings.\"}");
        }
    }

    private void fetchMonthlyIncome(HttpServletResponse response) throws IOException {
        Map<String, Double> monthlyIncome = bookingRepo.getMonthlyIncome();

        Gson gson = new Gson();
        String jsonResponse = gson.toJson(monthlyIncome);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse);
    }
}
