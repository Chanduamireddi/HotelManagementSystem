package com.group5.project.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.group5.project.Model.User;
import com.group5.project.Repository.BookingRepository;

import java.io.IOException;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private final BookingRepository bookingRepo = new BookingRepository();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("loginpage.jsp"); // Redirect to login if session is invalid
            return;
        }
        String userId = user.getUserId(); // Extract userId from session
        String roomId = request.getParameter("roomId");
        String checkInDate = request.getParameter("checkin");
        String checkOutDate = request.getParameter("checkout");
        double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));
        String guests=request.getParameter("guests");

        boolean result = bookingRepo.saveBooking(userId, roomId, checkInDate, checkOutDate, totalPrice,guests);

        String message = result ? "Booking successful!" : "Booking failed. Please try again.";
        request.setAttribute("message", message);
        request.getRequestDispatcher("bookingConfirmation.jsp").forward(request, response);
    }
}
