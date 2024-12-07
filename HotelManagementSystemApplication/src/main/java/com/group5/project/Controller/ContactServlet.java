package com.group5.project.Controller;

import com.group5.project.Model.Query;

import com.group5.project.Repository.QueryRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.group5.project.Model.User;


import java.io.IOException;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {
    private final QueryRepository queryRepo = new QueryRepository();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get logged-in user
        User loggedInUser = (User) request.getSession().getAttribute("user");
        if (loggedInUser == null) {
            response.sendRedirect("loginpage.jsp?error=Please log in to contact us.");
            return;
        }

        // Extract form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        // Create and save query
        Query query = new Query();
        query.setUserId(loggedInUser.getUserId());
        query.setName(name);
        query.setEmail(email);
        query.setMessage(message);
        queryRepo.saveQuery(query);

        // Redirect to contact page with a success message
        response.sendRedirect("contactus.jsp?success=Your query has been submitted. We will get back to you within 48 hours.");
    }
}
