package com.group5.project.Controller;

import java.io.IOException;

import com.group5.project.Model.Admin;
import com.group5.project.Model.User;
import com.group5.project.Repository.AdminRepository;
import com.group5.project.Repository.UserRepository;
import com.group5.project.Util.PasswordUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;




@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private final UserRepository userRepo = new UserRepository();
    private final AdminRepository adminRepo = new AdminRepository();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Determine if the request is for login or profile update
        if (request.getParameter("email") != null && request.getParameter("password") != null) {
            // Handle login
            handleLogin(request, response);
        } else if (request.getParameter("updateProfile") != null) {
            // Handle profile update
            handleProfileUpdate(request, response);
        } else {
            response.sendRedirect("loginpage.jsp?error=Invalid action");
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        boolean isValid = false;

        if ("admin".equalsIgnoreCase(role)) {
            System.out.println("Checking admin credentials...");
            Admin admin = adminRepo.findAdminByEmail(email);
            if (admin != null && PasswordUtils.checkPassword(password, admin.getPassword())) {
                isValid = true;
                request.getSession().setAttribute("admin", admin);
                request.getSession().setAttribute("role", "admin");
                response.sendRedirect("adminHome.jsp");
                return;
            }
        } else if ("user".equalsIgnoreCase(role)) {
            System.out.println("Checking user credentials...");
            User user = userRepo.findUserByEmail(email);
            if (user != null && PasswordUtils.checkPassword(password, user.getPassword())) {
                isValid = true;
                request.getSession().setAttribute("user", user);
                request.getSession().setAttribute("role", "user");
                request.getSession().setAttribute("userId",user.getUserId());
                response.sendRedirect("homepage.jsp");
                return;
            }
        }

        if (!isValid) {
            response.sendRedirect("loginpage.jsp?error=Invalid credentials");
        }
    }

    private void handleProfileUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Determine if the user or admin is logged in
        Object account = request.getSession().getAttribute("user") != null 
            ? request.getSession().getAttribute("user") 
            : request.getSession().getAttribute("admin");

        if (account == null) {
            response.sendRedirect("loginpage.jsp?error=Please log in first");
            return;
        }

        // Extract updated profile details
        String firstName = request.getParameter("firstName");
        String middleName = request.getParameter("middleName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        if (account instanceof User) {
            User user = (User) account;
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setEmail(email);
            user.setPhone(phone);
            userRepo.updateUser(user); // Save changes in the repository
            request.getSession().setAttribute("user", user); // Update session
        } else if (account instanceof Admin) {
            Admin admin = (Admin) account;
            admin.setFirstName(firstName);
            admin.setMiddleName(middleName); // Only admins have middle name
            admin.setLastName(lastName);
            admin.setEmail(email);
            admin.setPhone(phone);
            adminRepo.updateAdmin(admin); // Save changes in the repository
            request.getSession().setAttribute("admin", admin); // Update session
        }

        response.sendRedirect("userprofile.jsp?success=Profile updated successfully");
    }
}
