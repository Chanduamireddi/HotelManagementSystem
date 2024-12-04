<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Contact Us - Humber Hotel</title>
    <link rel="stylesheet" href="styles/contact.css">
    <script>
        function showSuccessPopup() {
            document.getElementById('successPopup').style.display = 'flex';
        }
        function closeSuccessPopup() {
            document.getElementById('successPopup').style.display = 'none';
        }
    </script>
</head>
<body>

    <header>
        <div class="header-left">
            <img src="images/HumberLogo.jpg" alt="Logo" class="logo">
            <span class="hotel-name">Humber Hotel</span>
        </div>
        <nav class="header-center">
            <ul>
                <li><a href="homepage.jsp">Home</a></li>
                <li><a href="rooms.jsp">Rooms</a></li>
                <li><a href="contactus.jsp">Contact Us</a></li>
            </ul>
        </nav>
        <div class="header-right">
            <div class="user-profile">
                <span class="username">User</span>
                <div class="dropdown-menu">
                    <a href="userprofile.jsp">User Profile</a>
                    <a href="logout.jsp">Logout</a>
                </div>
            </div>
        </div>
    </header>

    <section class="contact-container">
        <h1>Contact Us</h1>
        <p>If you have any questions, feel free to reach out to us. We'd love to hear from you!</p>

        <div class="contact-info">
            <p><strong>Phone:</strong> +1 (123) 456-7890</p>
            <p><strong>Email:</strong> support@humberhotel.com</p>
            <p><strong>Address:</strong> 123 Main Street, City, Country</p>
        </div>

        <h2>Send us a message</h2>
        <form action="ContactServlet" method="post" class="contact-form">
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="message">Message:</label>
                <textarea id="message" name="message" rows="5" required></textarea>
            </div>
            <button type="submit" class="submit-button">Submit</button>
        </form>
    </section>

    <footer>
        <p>&copy; 2024 Humber Hotel Group. All rights reserved. | <a href="privacy.jsp">Privacy Policy</a></p>
    </footer>

    <!-- Success Popup -->
    <% if (request.getParameter("success") != null) { %>
        <div id="successPopup" class="popup-overlay" style="display: flex;">
            <div class="popup-content">
                <p>Thank you! We have received your query. Stay tuned, we will get back to you within 48 hours.</p>
                <button onclick="closeSuccessPopup()">Close</button>
            </div>
        </div>
    <% } %>
</body>
</html>
