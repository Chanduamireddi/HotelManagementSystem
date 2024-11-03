<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Available Rooms - [Hotel Name]</title>
    <link rel="stylesheet" href="styles/rooms.css">
</head>
<body>
    <header>
        <h1>Available Rooms</h1>
    </header>

    <section class="room-search">
        <h2>Search Rooms</h2>
        <form action="RoomSearchServlet" method="get">
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
        <div class="room-card">
            <div class="room-image">
                <img src="images/Room1.jpg" alt="Deluxe Suite">
            </div>
            <div class="room-details">
                <h3>Deluxe Suite</h3>
                <p><strong>Features:</strong></p>
                <ul class="feature-list">
                    <li>King Bed</li>
                    <li>Ocean View</li>
                    <li>Free Wi-Fi</li>
                </ul>
                <p><strong>Rate per Night:</strong> <span class="original-price">$300</span> <span class="discounted-price">$250</span></p>
            </div>
            <div class="room-book">
                <a href="booking-confirmation.jsp" class="book-button">Book Now</a>
            </div>
        </div>

        <div class="room-card">
            <div class="room-image">
                <img src="images/Room2.jpg" alt="Standard Room">
            </div>
            <div class="room-details">
                <h3>Standard Room</h3>
                <p><strong>Features:</strong></p>
                <ul class="feature-list">
                    <li>Queen Bed</li>
                    <li>City View</li>
                    <li>Free Wi-Fi</li>
                </ul>
                <p><strong>Rate per Night:</strong> <span class="original-price">$220</span> <span class="discounted-price">$180</span></p>
            </div>
            <div class="room-book">
                <a href="booking-confirmation.jsp" class="book-button">Book Now</a>
            </div>
        </div>
    </section>

    <!-- Fixed Footer -->
    <footer>
        <p>&copy; 2024 [Hotel Name]. All rights reserved.</p>
    </footer>
</body>
</html>
