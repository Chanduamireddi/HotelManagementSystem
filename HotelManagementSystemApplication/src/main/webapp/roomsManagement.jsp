<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rooms Management - Humber Hotel</title>
    <link rel="stylesheet" href="styles/roomsManagement.css">
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
            <li><a href="roomsManagement.jsp" class="active">Rooms Management</a></li>
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

<main>
    <section class="rooms-management">
        <h2>Rooms Management</h2>
        <table class="rooms-table">
            <thead>
                <tr>
                    <th>Room Type</th>
                    <th>Description</th>
                    <th>Price (Per Night)</th>
                    <th>Total Rooms</th>
                    <th>Available Rooms</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%-- Loop to fetch and display room types dynamically from the database --%>
                <tr>
                    <td>Deluxe Room</td>
                    <td>Spacious room with premium amenities and city view</td>
                    <td>$200</td>
                    <td>20</td>
                    <td>15</td>
                    <td>
                        <button class="edit-btn" onclick="openEditRoomModal('Deluxe Room')">Edit</button>
                        <button class="delete-btn" onclick="deleteRoom('Deluxe Room')">Delete</button>
                    </td>
                </tr>
                <%-- Repeat above row for each room type from the database --%>
            </tbody>
        </table>
        <div class="room-actions">
            <button class="add-room-btn" onclick="openAddRoomModal()">Add New Room Type</button>
        </div>
    </section>
</main>

<!-- Modal for Adding a New Room -->
<div id="addRoomModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeAddRoomModal()">&times;</span>
        <h3>Add New Room Type</h3>
        <form action="addRoom.jsp" method="POST">
            <label for="roomType">Room Type:</label>
            <input type="text" id="roomType" name="roomType" required>
            <label for="description">Description:</label>
            <textarea id="description" name="description" required></textarea>
            <label for="price">Price (Per Night):</label>
            <input type="number" id="price" name="price" required>
            <label for="totalRooms">Total Rooms:</label>
            <input type="number" id="totalRooms" name="totalRooms" required>
            <button type="submit" class="save-btn">Save</button>
        </form>
    </div>
</div>

<!-- Modal for Editing a Room -->
<div id="editRoomModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeEditRoomModal()">&times;</span>
        <h3>Edit Room Type</h3>
        <form action="editRoom.jsp" method="POST">
            <input type="hidden" id="editRoomType" name="roomType">
            <label for="editDescription">Description:</label>
            <textarea id="editDescription" name="description" required></textarea>
            <label for="editPrice">Price (Per Night):</label>
            <input type="number" id="editPrice" name="price" required>
            <label for="editTotalRooms">Total Rooms:</label>
            <input type="number" id="editTotalRooms" name="totalRooms" required>
            <button type="submit" class="save-btn">Update</button>
        </form>
    </div>
</div>

<footer>
    <p>&copy; 2024 Humber Hotel Group. All rights reserved. | <a href="privacy.jsp">Privacy Policy</a></p>
</footer>

<script src="scripts/roomsManagement.js"></script>
</body>
</html>
