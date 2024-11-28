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
import com.group5.project.Util.PasswordUtils;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private final UserRepository userRepo = new UserRepository();
    private final AdminRepository adminRepo = new AdminRepository();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role"); // Expecting "admin" or "user" from the toggle

        boolean isValid = false;

        if ("admin".equals(role)) {
            Admin admin = adminRepo.findAdminByEmail(email);
            if (admin != null && PasswordUtils.checkPassword(password, admin.getPassword())) {
                isValid = true;
                // Set session attributes for admin
                request.getSession().setAttribute("user", admin);
                response.sendRedirect("homepage.jsp"); // Redirect to admin dashboard
            }
        } else if ("user".equals(role)) {
            User user = userRepo.findUserByEmail(email);
            if (user != null && PasswordUtils.checkPassword(password, user.getPassword())) {
                isValid = true;
                // Set session attributes for user
                request.getSession().setAttribute("user", user);
                response.sendRedirect("homepage.jsp"); // Redirect to user dashboard
            }
        }

        if (!isValid) {
            // Redirect back to login page with an error message
            response.sendRedirect("loginpage.jsp?error=Invalid credentials");
        }
    }
}
