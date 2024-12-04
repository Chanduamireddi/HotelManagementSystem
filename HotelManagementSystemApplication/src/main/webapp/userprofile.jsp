<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.group5.project.Model.User" %>
<%@ page import="com.group5.project.Model.Admin" %>
<%
    // Retrieve the logged-in user or admin from the session
    Object loggedInAccount = session.getAttribute("user") != null 
        ? session.getAttribute("user") 
        : session.getAttribute("admin");

    // If no user or admin is found in the session, redirect to the login page
    if (loggedInAccount == null) {
        response.sendRedirect("loginpage.jsp?error=Please log in first");
        return;
    }

    // Initialize variables to store user/admin details
    String firstName = null, middleName = null, lastName = null, email = null, phone = null, address = null;
    String role = null;
    String homePageLink = "homepage.jsp"; // Default to user's homepage

    // Check whether the logged-in account is a User or Admin and set variables
    if (loggedInAccount instanceof Admin) {
        Admin admin = (Admin) loggedInAccount;
        role = "Admin";
        firstName = admin.getFirstName();
        middleName = admin.getMiddleName();
        lastName = admin.getLastName();
        email = admin.getEmail();
        phone = admin.getPhone();
        homePageLink = "adminHome.jsp"; // Set to admin homepage
    } else if (loggedInAccount instanceof User) {
        User user = (User) loggedInAccount;
        role = "User";
        firstName = user.getFirstName();
        lastName = user.getLastName();
        email = user.getEmail();
        phone = user.getPhone();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile - Humber Hotel</title>
    <link rel="stylesheet" href="styles/userprofile.css">
</head>
<body>
    <header>
        <div class="header-left">
            <img src="images/ProfilePic.jpg" alt="Logo" class="logo">
            <span class="hotel-name">Humber Hotel</span>
        </div>
        <nav class="header-center">
            <ul>
                <!-- Dynamically set the home page link based on role -->
                <li><a href="<%= homePageLink %>">Home</a></li>
                <li><a href="rooms.jsp">Rooms</a></li>
                <li><a href="contactus.jsp">Contact Us</a></li>
            </ul>
        </nav>
        <div class="header-right">
            <div class="user-profile">
                <span class="username"><%= role %></span>
                <div class="dropdown-menu">
                    <a href="userprofile.jsp">User Profile</a>
                    <a href="logout.jsp">Logout</a>
                </div>
            </div>
        </div>
    </header>

    <section class="profile-container">
        <div class="personal-info">
            <div class="profile-image">
                <img src="images/ProfilePic.jpg" alt="Profile Picture">
            </div>
            <div class="profile-details">
                <h2>Personal Information</h2>
                <div class="detail-field"><strong>First Name: </strong><%= firstName != null ? firstName : "Not Available" %></div>
                <% if (middleName != null) { %>
                    <div class="detail-field"><strong>Middle Name: </strong><%= middleName %></div>
                <% } %>
                <div class="detail-field"><strong>Last Name: </strong><%= lastName != null ? lastName : "Not Available" %></div>
                <div class="detail-field"><strong>Email: </strong><%= email != null ? email : "Not Available" %></div>
                <div class="detail-field"><strong>Phone Number: </strong><%= phone != null ? phone : "Not Available" %></div>
                <button class="edit-button" onclick="openPopup()">Edit Profile</button>
            </div>
        </div>
    </section>

    <footer>
        <p>&copy; 2024 Humber Hotel. All rights reserved.</p>
    </footer>

    <!-- Popup Form -->
    <div class="popup-overlay" id="popupForm">
        <div class="popup-form">
            <h2>Edit Profile</h2>
            <form action="LoginServlet" method="POST">
                <!-- Add a hidden field to indicate profile update -->
                <input type="hidden" name="updateProfile" value="true">

                <label for="firstName">First Name:</label>
                <input type="text" id="firstName" name="firstName" value="<%= firstName != null ? firstName : "" %>" required>

                <% if (middleName != null) { %>
                    <label for="middleName">Middle Name:</label>
                    <input type="text" id="middleName" name="middleName" value="<%= middleName %>">
                <% } %>

                <label for="lastName">Last Name:</label>
                <input type="text" id="lastName" name="lastName" value="<%= lastName != null ? lastName : "" %>" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= email != null ? email : "" %>" required>

                <label for="phone">Phone Number:</label>
                <input type="text" id="phone" name="phone" value="<%= phone != null ? phone : "" %>" required>


                <button type="submit">Save</button>
                <button type="button" onclick="closePopup()">Cancel</button>
            </form>
        </div>
    </div>

    <script>
        function openPopup() {
            document.getElementById("popupForm").style.display = "flex";
        }
        function closePopup() {
            document.getElementById("popupForm").style.display = "none";
        }
    </script>
</body>
</html>
