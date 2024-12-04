<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.concurrent.TimeUnit" %>
<%@ page import="java.util.Arrays" %>
<%
    // Fetch query parameters
    String roomId = request.getParameter("roomId");
    String roomName = request.getParameter("roomName");
    String features = request.getParameter("features");
    String pricePerNight = request.getParameter("price");
    String discountedPricePerNight = request.getParameter("discountedPrice");
    String checkInDate = request.getParameter("checkin");
    String checkOutDate = request.getParameter("checkout");
    String guests = request.getParameter("guests"); // Total guests
    String message = (String) request.getAttribute("message"); // Success or error message

    // Handle features (comma-separated)
    String[] featureList = features != null ? features.split(",") : new String[0];

    // Calculate total price
    long totalNights = 0;
    double totalPrice = 0.0;
    try {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date checkIn = dateFormat.parse(checkInDate);
        Date checkOut = dateFormat.parse(checkOutDate);
        long diffInMillies = Math.abs(checkOut.getTime() - checkIn.getTime());
        totalNights = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);

        // Use discounted price if available; otherwise, use the actual price
        double price = discountedPricePerNight != null ? Double.parseDouble(discountedPricePerNight) : Double.parseDouble(pricePerNight);
        totalPrice = totalNights * price;
    } catch (Exception e) {
        totalNights = 0;
        totalPrice = 0.0;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking Confirmation - Humber Hotel</title>
    <link rel="stylesheet" href="styles/bookingconfirmation.css">
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

<section class="confirmation-container">
    <div class="fixed-section">
        <h1 class="booking-details-title">Booking Details</h1>
        <div class="room-image">
            <img src="images/Room1.jpg" alt="<%= roomName %>">
        </div>
    </div>

    <div class="scrollable-details">
        <h2>Thank you for your reservation!</h2>
        <p>Please review your booking details below:</p>

        <div class="booking-summary">
            <h3>Booking Summary</h3>
            <div class="summary-item">
                <span>Room Type:</span>
                <span><%= roomName %></span>
            </div>
            <div class="summary-item">
                <span>Features:</span>
                <span>
                    <ul>
                        <% for (String feature : featureList) { %>
                            <li><%= feature.trim() %></li>
                        <% } %>
                    </ul>
                </span>
            </div>
            <div class="summary-item">
                <span>Check-In Date:</span>
                <span><%= checkInDate %></span>
            </div>
            <div class="summary-item">
                <span>Check-Out Date:</span>
                <span><%= checkOutDate %></span>
            </div>
            <div class="summary-item">
                <span>Nights:</span>
                <span><%= totalNights %></span>
            </div>
            <div class="summary-item">
                <span>Guests:</span>
                <span><%= guests %></span>
            </div>
            <div class="summary-item">
                <span>Total Price:</span>
                <span>$<%= String.format("%.2f", totalPrice) %></span>
            </div>
        </div>

        <form action="BookingServlet" method="post">
            <input type="hidden" name="action" value="newBooking">
            <input type="hidden" name="roomId" value="<%= roomId %>">
            <input type="hidden" name="checkin" value="<%= checkInDate %>">
            <input type="hidden" name="checkout" value="<%= checkOutDate %>">
            <input type="hidden" name="totalPrice" value="<%= totalPrice %>">
            <input type="hidden" name="guests" value="<%= guests %>">
            <button type="submit" class="action-button modify">Confirm Booking</button>
        </form>

        <% if (message != null) { %>
            <script>
                alert("<%= message %>");
            </script>
        <% } %>

        <div class="button-group">
            <a href="rooms.jsp" class="action-button cancel">Cancel</a>
            <a href="homepage.jsp" class="action-button home">Home</a>
        </div>
    </div>
</section>

<footer>
    <p>&copy; 2024 Humber Hotel. All rights reserved.</p>
</footer>
</body>
</html>
