<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bookings Management - Humber Hotel</title>
    <link rel="stylesheet" href="styles/bookingsManagement.css">
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
            <li><a href="bookingsManagement.jsp" class="active">Bookings Management</a></li>
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

<main>
    <section class="bookings-management">
        <h2>Bookings Management</h2>
        <table class="bookings-table">
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Guest Name</th>
                    <th>Room Type</th>
                    <th>Check-in</th>
                    <th>Check-out</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%-- Loop to fetch and display bookings dynamically from the database --%>
                <tr>
                    <td>BK101</td>
                    <td>John Doe</td>
                    <td>Deluxe Room</td>
                    <td>2024-12-01</td>
                    <td>2024-12-05</td>
                    <td>Confirmed</td>
                    <td>
                        <button class="view-btn" onclick="viewBookingDetails('BK101')">View</button>
                        <button class="edit-btn" onclick="openEditBookingModal('BK101')">Edit</button>
                        <button class="delete-btn" onclick="deleteBooking('BK101')">Delete</button>
                    </td>
                </tr>
                <%-- Repeat above row for each booking from the database --%>
            </tbody>
        </table>
        <div class="booking-actions">
            <button class="add-booking-btn" onclick="openAddBookingModal()">Add New Booking</button>
        </div>
    </section>
</main>

<!-- Modal for Adding a New Booking -->
<div id="addBookingModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeAddBookingModal()">&times;</span>
        <h3>Add New Booking</h3>
        <form action="addBooking.jsp" method="POST">
            <label for="guestName">Guest Name:</label>
            <input type="text" id="guestName" name="guestName" required>
            <label for="roomType">Room Type:</label>
            <select id="roomType" name="roomType" required>
                <option value="Deluxe Room">Deluxe Room</option>
                <option value="Executive Room">Executive Room</option>
                <option value="Presidential Suite">Presidential Suite</option>
            </select>
            <label for="checkIn">Check-in Date:</label>
            <input type="date" id="checkIn" name="checkIn" required>
            <label for="checkOut">Check-out Date:</label>
            <input type="date" id="checkOut" name="checkOut" required>
            <label for="status">Status:</label>
            <select id="status" name="status" required>
                <option value="Confirmed">Confirmed</option>
                <option value="Pending">Pending</option>
                <option value="Cancelled">Cancelled</option>
            </select>
            <button type="submit" class="save-btn">Save</button>
        </form>
    </div>
</div>

<!-- Modal for Editing a Booking -->
<div id="editBookingModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeEditBookingModal()">&times;</span>
        <h3>Edit Booking</h3>
        <form action="editBooking.jsp" method="POST">
            <input type="hidden" id="editBookingId" name="bookingId">
            <label for="editGuestName">Guest Name:</label>
            <input type="text" id="editGuestName" name="guestName" required>
            <label for="editRoomType">Room Type:</label>
            <select id="editRoomType" name="roomType" required>
                <option value="Deluxe Room">Deluxe Room</option>
                <option value="Executive Room">Executive Room</option>
                <option value="Presidential Suite">Presidential Suite</option>
            </select>
            <label for="editCheckIn">Check-in Date:</label>
            <input type="date" id="editCheckIn" name="checkIn" required>
            <label for="editCheckOut">Check-out Date:</label>
            <input type="date" id="editCheckOut" name="checkOut" required>
            <label for="editStatus">Status:</label>
            <select id="editStatus" name="status" required>
                <option value="Confirmed">Confirmed</option>
                <option value="Pending">Pending</option>
                <option value="Cancelled">Cancelled</option>
            </select>
            <button type="submit" class="save-btn">Update</button>
        </form>
    </div>
</div>

<footer>
    <p>&copy; 2024 Humber Hotel Group. All rights reserved. | <a href="privacy.jsp">Privacy Policy</a></p>
</footer>

<script src="scripts/bookingsManagement.js"></script>
</body>
</html>
