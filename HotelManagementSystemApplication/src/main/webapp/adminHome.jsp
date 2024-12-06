<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Humber Hotel</title>
    <link rel="stylesheet" href="styles/homepage.css">
</head>
<body>

    <header>
        <div class="header-left">
            <img src="images/HumberLogo.jpg" alt="Logo" class="logo">
            <span class="hotel-name">Humber Hotel</span>
        </div>

        <nav class="header-center">
            <ul>
            	<li><a href="adminHome.jsp">Admin Home</a></li>
                <li><a href="roomsManagement.jsp">Rooms Management</a></li>
                <li><a href="bookingsManagement.jsp">Bookings Management</a></li>
                <li><a href="reports.jsp">Reports</a></li>
            </ul>
        </nav>

        <div class="header-right">
            <div class="user-profile">
                <span class="username">Admin User</span>
                <div class="dropdown-menu">
                    <a href="userprofile.jsp">User Profile</a>
                    <a href="logout.jsp">Logout</a>
                </div>
            </div>
        </div>
    </header>

    <section class="hero-carousel">
        <div class="carousel-slide fade">
            <img src="images/Banner1.jpg" alt="Welcome to Humber Hotel Group">
            <div class="carousel-content">
                <h2>Welcome to Humber Hotel Group</h2>
                <p>Experience luxury and comfort in the heart of the city.</p>
                <a href="reports.jsp" class="hero-button">View Reports</a>
            </div>
        </div>
        <div class="carousel-slide fade">
            <img src="images/Banner1.jpg" alt="Discover Elegance">
            <div class="carousel-content">
                <h2>Manage with Ease</h2>
                <p>Seamlessly manage operations and ensure guest satisfaction.</p>
                <a href="roomsManagement.jsp" class="hero-button">Manage Rooms</a>
            </div>
        </div>
    </section>

    <section class="hotel-overview">
        <div class="overview-card">
            <img src="images/HotelOverview.jpg" alt="Hotel Overview">
            <div class="overview-text">
                <h3>Admin Dashboard</h3>
                <p>Oversee bookings, room availability, and generate financial reports from one place. Streamline hotel operations effectively with the admin dashboard.</p>
            </div>
        </div>
    </section>

    <section class="customer-favourites">
        <h3>Hotel Features</h3>
        <div class="flip-card-container">
            <div class="flip-card">
                <div class="flip-card-inner">
                    <div class="flip-card-front">
                        <img src="images/Room1.jpg" alt="Manage Rooms">
                        <div class="room-name">Manage Rooms</div>
                    </div>
                    <div class="flip-card-back">
                        <p>Update room availability, add new categories, and ensure accurate listings.</p>
                        <a href="roomsManagement.jsp" class="book-button">Manage Now</a>
                    </div>
                </div>
            </div>
            <div class="flip-card">
                <div class="flip-card-inner">
                    <div class="flip-card-front">
                        <img src="images/Room2.jpg" alt="Bookings Management">
                        <div class="room-name">Bookings Management</div>
                    </div>
                    <div class="flip-card-back">
                        <p>Track guest bookings and modify as needed for guest satisfaction.</p>
                        <a href="bookingsManagement.jsp" class="book-button">Manage Now</a>
                    </div>
                </div>
            </div>
            <div class="flip-card">
                <div class="flip-card-inner">
                    <div class="flip-card-front">
                        <img src="images/Room3.jpg" alt="Reports">
                        <div class="room-name">Generate Reports</div>
                    </div>
                    <div class="flip-card-back">
                        <p>Analyze revenue and performance with detailed reports.</p>
                        <a href="reports.jsp" class="book-button">View Reports</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <footer>
        <p>&copy; 2024 Humber Hotel Group. All rights reserved.</a></p>
    </footer>

    <script src="scripts/hero.js"></script>
</body>
</html>
