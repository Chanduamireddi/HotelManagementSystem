package com.group5.project.Controller;



import com.google.gson.Gson;
import com.group5.project.Model.Admin;
import com.group5.project.Model.Booking;
import com.group5.project.Model.User;
import com.group5.project.Repository.BookingRepository;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
	private final BookingRepository bookingRepo = new BookingRepository();

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Get session without creating a new one
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        Admin admin = (session != null) ? (Admin) session.getAttribute("admin") : null;

        if (user == null && admin == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"message\": \"Session invalid. Please log in.\"}");
            return;
        }

        String action = null;
        String bookingId = null;
        String userId = null;

        // Check the content type of the request
        String contentType = request.getContentType();
        if (contentType != null && contentType.contains("application/json")) {
            // Handle JSON payload
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }
            String requestBody = sb.toString();
            System.out.println("Request Body: " + requestBody);

            // Parse JSON
            try {
                Gson gson = new Gson();
                Map<String, String> requestBodyMap = gson.fromJson(requestBody, Map.class);
                action = requestBodyMap.get("action");
                bookingId = requestBodyMap.get("bookingId");
                userId = requestBodyMap.get("userId");
            } catch (Exception e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"message\": \"Invalid JSON format.\"}");
                return;
            }
        } else {
            // Handle URL-encoded form data
            action = request.getParameter("action");
            bookingId = request.getParameter("bookingId");
            userId = request.getParameter("userId");
        }

        System.out.println("Parsed action: " + action);
        System.out.println("Parsed bookingId: " + bookingId);
        System.out.println("Parsed userId: " + userId);

        if (action == null || action.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"message\": \"Missing or invalid action parameter.\"}");
            return;
        }

        // Process actions based on the action parameter
        if ("updateBooking".equalsIgnoreCase(action)) {
            handleEditBooking(request, response);
        } else if ("newBooking".equalsIgnoreCase(action)) {
            handleNewBooking(request, response, user, admin);
        } else if ("deleteBooking".equalsIgnoreCase(action)) {
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
        } else if ("userHistory".equalsIgnoreCase(action)) {
            try {
                System.out.println("Received userId from request: " + userId);

                // Fallback logic for admin or user
                String resolvedUserId = userId != null ? userId : (admin != null ? admin.getAdminId() : null);
                System.out.println("Resolved userId: " + resolvedUserId);

                if (resolvedUserId == null || resolvedUserId.isEmpty()) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("{\"message\": \"Missing user ID.\"}");
                    return;
                }

                // Fetch bookings by userId
                List<Booking> bookings = bookingRepo.getBookingsByUserId(resolvedUserId);
                System.out.println("Fetched bookings: " + bookings);

                // Respond with JSON
                if (bookings != null && !bookings.isEmpty()) {
                    response.setContentType("application/json");
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write(new Gson().toJson(bookings));
                } else {
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("[]"); // Empty array if no bookings found
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"message\": \"An error occurred while fetching booking history.\"}");
            }
        } else if ("cancelBooking".equalsIgnoreCase(action)) {
            if (bookingId == null || bookingId.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"message\": \"Missing booking ID.\"}");
                return;
            }

            try {
                // Call repository to update the booking status to "Cancelled"
                boolean success = bookingRepo.updateBookingStatus(bookingId, "Cancelled");

                response.setContentType("application/json");
                if (success) {
                    response.getWriter().write("{\"success\": true, \"message\": \"Booking cancelled successfully.\"}");
                } else {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("{\"success\": false, \"message\": \"Failed to cancel booking.\"}");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"message\": \"Invalid or missing action parameter.\"}");
        }
    }



	private void handleNewBooking(HttpServletRequest request, HttpServletResponse response, User user, Admin admin)
			throws ServletException, IOException {
		try {
			String userId = "", adminId = "";
			if (user == null)
				adminId = admin.getAdminId();
			else
				userId = user.getUserId();

			String roomId = request.getParameter("roomId");
			String checkInDate = request.getParameter("checkin");
			String checkOutDate = request.getParameter("checkout");
			double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));
			String guests = request.getParameter("guests");
			String status = userId.startsWith("USR") ? "confirmed" : "pending";

			boolean result = bookingRepo.saveBooking(userId, roomId, checkInDate, checkOutDate, totalPrice, guests,
					status, adminId);

			String message = result ? "Booking successful!" : "Booking failed. Please try again.";
			   request.setAttribute("message", message);

			    // Forward back to the same JSP page
			    RequestDispatcher dispatcher = request.getRequestDispatcher("bookingConfirmation.jsp");
			    dispatcher.forward(request, response);
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
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
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