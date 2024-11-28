<%@ page import="java.util.List"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="java.util.Random"%>
<%@ page import="com.group5.project.Model.Room"%>
<%
    // Fetch the list of rooms passed from the servlet
    List<Room> rooms = (List<Room>) request.getAttribute("rooms");

    // Generate a random image for each room
    String[] availableImages = {"Room1.jpg", "Room2.jpg", "Room3.jpg", "Room4.jpg", "Room5.jpg"};
    Random random = new Random();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Rooms - Humber Hotel Group</title>
    <link rel="stylesheet" href="styles/rooms.css">
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
                <li><a href="BookingConfirmation.jsp">Book Now</a></li>
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

    <main>
        <section class="room-search">
            <h2>Search Rooms</h2>
            <form action="RoomSearchServlet" method="post">
                <div class="form-row">
                    <div class="form-group">
                        <label for="checkin">Check-In Date:</label>
                        <input type="date" id="checkin" name="checkin" required>
                    </div>
                    <div class="form-group">
                        <label for="checkout">Check-Out Date:</label>
                        <input type="date" id="checkout" name="checkout" required>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="adults">Adults:</label>
                        <input type="number" id="adults" name="adults" min="1" value="1" required>
                    </div>
                    <div class="form-group">
                        <label for="children">Children:</label>
                        <input type="number" id="children" name="children" min="0" value="0">
                    </div>
                </div>
                <div class="form-submit">
                    <button type="submit" class="search-button">Search</button>
                </div>
            </form>
        </section>

        <section class="room-list">
            <h2>Room Results</h2>
            <% if (rooms != null && !rooms.isEmpty()) { %>
                <% for (Room room : rooms) { %>
                    <% String randomImage = availableImages[random.nextInt(availableImages.length)]; %>
                    <div class="room-card">
                        <div class="room-image">
                            <img src="images/<%= randomImage %>" alt="<%= room.getRoomName() %>">
                        </div>
                        <div class="room-details">
                            <h3><%= room.getRoomName() %></h3>
                            <p><strong>Features:</strong></p>
                            <ul class="feature-list">
                                <% 
                                    // Convert the features string to a List
                                    List<String> features = Arrays.asList(room.getFeatures().split(","));
                                    for (String feature : features) { 
                                %>
                                    <li><%= feature.trim() %></li>
                                <% } %>
                            </ul>
                            <p>
                                <strong>Rate per Night:</strong> 
                                <span class="original-price">$<%= room.getActualPrice() %></span>
                                <% if (room.getDiscountedPrice() != null) { %>
                                    <span class="discounted-price">$<%= room.getDiscountedPrice() %></span>
                                <% } %>
                            </p>
                        </div>
                        <div class="room-book">
                            <a href="bookingConfirmation.jsp?roomId=<%= room.getRoomId() %>&roomName=<%= room.getRoomName() %>&features=<%= room.getFeatures() %>&price=<%= room.getActualPrice() %>&discountedPrice=<%= room.getDiscountedPrice() != null ? room.getDiscountedPrice() : room.getActualPrice() %>&checkin=<%= request.getParameter("checkin") %>&checkout=<%= request.getParameter("checkout") %>&guests=<%= Integer.parseInt(request.getParameter("adults")) + Integer.parseInt(request.getParameter("children")) %>" class="book-button">Book Now</a>
                        </div>
                    </div>
                <% } %>
            <% } else { %>
                <p>No rooms available for the selected criteria.</p>
            <% } %>
        </section>
    </main>

    <footer>
        <p>&copy; 2024 Humber Hotel Group. All rights reserved. | <a href="privacy.jsp">Privacy Policy</a></p>
    </footer>
</body>
</html>
