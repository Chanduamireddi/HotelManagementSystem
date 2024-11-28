package com.group5.project.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;



import java.io.IOException;
import java.util.List;

import com.group5.project.Model.Room;
import com.group5.project.Repository.RoomRepository;

@WebServlet("/RoomSearchServlet")
public class RoomServlet extends HttpServlet {
    private final RoomRepository roomRepo = new RoomRepository();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String checkIn = request.getParameter("checkin");
        String checkOut = request.getParameter("checkout");
        int adults = Integer.parseInt(request.getParameter("adults"));
        int children = Integer.parseInt(request.getParameter("children"));

        // Fetch available rooms from repository
        List<Room> availableRooms = roomRepo.findAvailableRooms(checkIn, checkOut, adults, children);

        // Set rooms as a request attribute and forward to JSP
        request.setAttribute("rooms", availableRooms);
        request.getRequestDispatcher("rooms.jsp").forward(request, response);
    }
}
