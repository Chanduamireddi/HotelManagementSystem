package com.group5.project.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import com.group5.project.Model.Admin;
import com.group5.project.Model.User;
import com.group5.project.Repository.AdminRepository;
import com.group5.project.Repository.UserRepository;

// Map the servlet to a URL
public class RegistrationServlet extends HttpServlet {
    private final UserRepository userRepo = new UserRepository();
    private final AdminRepository adminRepo = new AdminRepository();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstName = request.getParameter("firstName");
        String middleName = request.getParameter("middleName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");

        boolean result = false;

        try {
            if ("admin".equals(role)) {
                Admin admin = new Admin();
                admin.setAdminId("ADM" + System.currentTimeMillis()); // Example ID generator
                admin.setFirstName(firstName);
                admin.setMiddleName(middleName);
                admin.setLastName(lastName);
                admin.setEmail(email);
                admin.setPhone(phone);
                admin.setPassword(password);

                result = adminRepo.saveAdmin(admin);
            } else if ("user".equals(role)) {
                User user = new User();
                user.setUserId("USR" + System.currentTimeMillis()); // Example ID generator
                user.setFirstName(firstName);
                user.setLastName(lastName);
                user.setEmail(email);
                user.setPhone(phone);
                user.setPassword(password);

                result = userRepo.saveUser(user);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
        }

        if (result) {
            // Redirect to login page if registration is successful
            response.sendRedirect("loginpage.jsp");
        } else {
            // Stay on the same page and display error message
            request.setAttribute("errorMessage", "Registration Failed. Please try again.");
            request.getRequestDispatcher("registration.jsp").forward(request, response);
        }
    }
}
