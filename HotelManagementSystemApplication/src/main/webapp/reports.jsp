<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports - Humber Hotel</title>
    <link rel="stylesheet" href="styles/reports.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- Include Chart.js -->
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
            <li><a href="reports.jsp" class="active">Reports</a></li>
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

<main>
    <section class="reports">
        <h2>Reports</h2>

        <div class="chart-container">
            <div class="chart">
                <h3>Monthly Revenue</h3>
                <canvas id="revenueChart"></canvas>
            </div>
            <div class="chart">
                <h3>Room Occupancy</h3>
                <canvas id="occupancyChart"></canvas>
            </div>
        </div>

        <div class="table-container">
            <h3>Key Metrics</h3>
            <table class="reports-table">
                <thead>
                    <tr>
                        <th>Metric</th>
                        <th>Value</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Total Revenue</td>
                        <td>$250,000</td>
                    </tr>
                    <tr>
                        <td>Total Bookings</td>
                        <td>1,200</td>
                    </tr>
                    <tr>
                        <td>Occupancy Rate</td>
                        <td>85%</td>
                    </tr>
                    <tr>
                        <td>Average Revenue Per Room</td>
                        <td>$210</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </section>
</main>

<footer>
    <p>&copy; 2024 Humber Hotel Group. All rights reserved. | <a href="privacy.jsp">Privacy Policy</a></p>
</footer>

<script src="scripts/reports.js"></script>
</body>
</html>
