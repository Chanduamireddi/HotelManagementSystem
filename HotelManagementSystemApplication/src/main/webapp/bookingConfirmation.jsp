<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.concurrent.TimeUnit" %>
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

    // Fetch the success/error message from request or session
    String message = (String) request.getAttribute("message");
    if (message == null) {
        message = (String) session.getAttribute("message");
        session.removeAttribute("message"); // Clear the session message after fetching
    }

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
<script type="text/javascript">
function showPopup(message) {
    if (message) {
        // Show the popup by making it visible
        const popupOverlay = document.createElement("div");
        popupOverlay.style.position = "fixed";
        popupOverlay.style.top = "0";
        popupOverlay.style.left = "0";
        popupOverlay.style.width = "100%";
        popupOverlay.style.height = "100%";
        popupOverlay.style.backgroundColor = "rgba(0, 0, 0, 0.5)";
        popupOverlay.style.display = "flex";
        popupOverlay.style.justifyContent = "center";
        popupOverlay.style.alignItems = "center";
        popupOverlay.style.zIndex = "1000";

        const popupBox = document.createElement("div");
        popupBox.style.backgroundColor = "white";
        popupBox.style.padding = "20px";
        popupBox.style.borderRadius = "10px";
        popupBox.style.textAlign = "center";
        popupBox.style.boxShadow = "0 5px 15px rgba(0, 0, 0, 0.3)";
        popupBox.innerHTML = `
            <h3 style="color: #4caf50; margin-bottom: 10px;">Humber says:</h3>
            <p style="font-size: 16px; color: #333; margin-bottom: 20px;">${message}</p>
            <button id="popup-ok" style="background: #4caf50; color: white; border: none; padding: 10px 20px; border-radius: 5px; font-size: 16px; cursor: pointer; transition: background 0.3s;">OK</button>
        `;

        popupOverlay.appendChild(popupBox);
        document.body.appendChild(popupOverlay);

        // Add event listener to handle the OK button click
        document.getElementById("popup-ok").addEventListener("click", function () {
            document.body.removeChild(popupOverlay);
            if (message === "Booking successful!") {
                window.location.href = "bookingHistory.jsp";
            } else {
                window.location.href = "rooms.jsp";
            }
        });
    }
}

document.addEventListener("DOMContentLoaded", function () {
    const message = '<%= message != null ? message : "" %>';
    if (message) {
        showPopup(message);
    }
});
</script>
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

        <div class="button-group">
            <!-- Confirm Booking Button -->
            <form action="BookingServlet" method="post">
                <input type="hidden" name="action" value="newBooking">
                <input type="hidden" name="roomId" value="<%= roomId %>">
                <input type="hidden" name="checkin" value="<%= checkInDate %>">
                <input type="hidden" name="checkout" value="<%= checkOutDate %>">
                <input type="hidden" name="totalPrice" value="<%= totalPrice %>">
                <input type="hidden" name="guests" value="<%= guests %>">
                <button type="submit" class="action-button modify">Confirm Booking</button>
            </form>

            <!-- Cancel Button -->
            <form action="rooms.jsp">
                <button type="submit" class="action-button cancel">Cancel</button>
            </form>

            <!-- Home Button -->
            <form action="homepage.jsp">
                <button type="submit" class="action-button home">Home</button>
            </form>
        </div>
    </div>
</section>

<footer>
    <p>&copy; 2024 Humber Hotel. All rights reserved.</p>
</footer>
</body>
</html>