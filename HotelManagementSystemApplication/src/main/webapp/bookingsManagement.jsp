<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bookings Management - Humber Hotel</title>
    <link rel="stylesheet" href="styles/bookingsManagement.css">
    <script>
        // Fetch bookings data on page load
        document.addEventListener('DOMContentLoaded', fetchBookings);

        // Fetch bookings data from the server
        function fetchBookings() {
            fetch('BookingServlet?action=fetchBookings')
                .then(response => {
                    if (!response.ok) throw new Error(`Failed to fetch bookings. Status: ${response.status}`);
                    return response.json();
                })
                .then(data => populateBookingsTable(data))
                .catch(error => console.error('Error fetching bookings:', error));
        }

        // Populate the table with fetched bookings data
        function populateBookingsTable(data) {
            const tableBody = document.querySelector('.bookings-table tbody');
            tableBody.innerHTML = ''; // Clear existing rows

            if (!data || data.length === 0) {
                const emptyRow = document.createElement('tr');
                emptyRow.innerHTML = '<td colspan="8">No bookings available.</td>';
                tableBody.appendChild(emptyRow);
                return;
            }

            data.forEach(booking => {
                const row = document.createElement('tr');

                // Create individual cells for the row
                const bookingIdCell = document.createElement('td');
                bookingIdCell.textContent = booking.bookingId || 'N/A';
                row.appendChild(bookingIdCell);

                const roomNoCell = document.createElement('td');
                roomNoCell.textContent = booking.roomNo || 'N/A';
                row.appendChild(roomNoCell);

                const checkInCell = document.createElement('td');
                checkInCell.textContent = booking.checkIn || 'N/A';
                row.appendChild(checkInCell);

                const checkOutCell = document.createElement('td');
                checkOutCell.textContent = booking.checkOut || 'N/A';
                row.appendChild(checkOutCell);

                const guestsCell = document.createElement('td');
                guestsCell.textContent = booking.guests || 'N/A';
                row.appendChild(guestsCell);

                const statusCell = document.createElement('td');
                statusCell.textContent = booking.status || 'N/A';
                row.appendChild(statusCell);

                const usernameCell = document.createElement('td');
                usernameCell.textContent = booking.username || 'N/A';
                row.appendChild(usernameCell);

                // Action buttons
                const actionsCell = document.createElement('td');
                const editButton = document.createElement('button');
                editButton.textContent = 'Edit';
                editButton.className = 'edit-btn';
                editButton.onclick = () => openEditBookingModal(
                    booking.bookingId,
                    booking.checkIn,
                    booking.checkOut,
                    booking.status
                );

                const deleteButton = document.createElement('button');
                deleteButton.textContent = 'Delete';
                deleteButton.className = 'delete-btn';
                deleteButton.onclick = () => deleteBooking(booking.bookingId);

                actionsCell.appendChild(editButton);
                actionsCell.appendChild(deleteButton);
                row.appendChild(actionsCell);

                tableBody.appendChild(row);
            });
        }

        // Open the Add Booking modal
        function openAddBookingModal() {
            document.getElementById('addBookingForm').reset(); // Clear the form
            document.getElementById('addBookingModal').style.display = 'block';
        }

        // Close the Add Booking modal
        function closeAddBookingModal() {
            document.getElementById('addBookingModal').style.display = 'none';
        }

        // Submit the add booking form
        function submitAddBooking() {
            const form = document.getElementById('addBookingForm');
            const formData = new URLSearchParams(new FormData(form));

            fetch('BookingServlet', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: formData.toString()
            })
            .then(response => {
                if (!response.ok) throw new Error('Failed to add booking.');
                alert('Booking added successfully!');
                closeAddBookingModal();
                fetchBookings();
            })
            .catch(error => {
                console.error('Error adding booking:', error);
                alert('Failed to add booking.');
            });
        }
     // Submit the edit booking form
        function submitEditBooking() {
            const bookingId = document.getElementById('editBookingId').value;
            const checkIn = document.getElementById('editCheckIn').value;
            const checkOut = document.getElementById('editCheckOut').value;
            const status = document.getElementById('editStatus').value;

            // Create the request body
            const requestBody = new URLSearchParams({
                action: 'updateBooking',
                bookingId: bookingId,
                checkIn: checkIn,
                checkOut: checkOut,
                status: status
            });

            fetch('BookingServlet', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: requestBody.toString()
            })
            .then(response => {
                if (!response.ok) throw new Error('Failed to update booking.');
                return response.json();
            })
            .then(data => {
                alert(data.message || 'Booking updated successfully!');
                closeEditBookingModal();
                fetchBookings(); // Refresh the bookings table
            })
            .catch(error => {
                console.error('Error updating booking:', error);
                alert('Failed to update booking. Please try again.');
            });
        }


        // Open the Edit Booking modal and populate fields
        function openEditBookingModal(bookingId, checkIn, checkOut, status) {
            document.getElementById('editBookingId').value = bookingId;
            document.getElementById('editCheckIn').value = checkIn;
            document.getElementById('editCheckOut').value = checkOut;
            document.getElementById('editStatus').value = status;

            document.getElementById('editBookingModal').style.display = 'block';
        }

        // Close the Edit Booking modal
        function closeEditBookingModal() {
            document.getElementById('editBookingModal').style.display = 'none';
        }
     // Delete a booking with confirmation
        function deleteBooking(bookingId) {
            const isConfirmed = confirm(`Are you sure you want to delete booking ID: ${bookingId}?`);
            if (isConfirmed) {
                const requestBody = new URLSearchParams({
                    action: 'deleteBooking',
                    bookingId: bookingId
                });

                fetch('BookingServlet', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: requestBody.toString()
                })
                .then(response => {
                    if (!response.ok) throw new Error('Failed to delete booking.');
                    alert('Booking deleted successfully!');
                    fetchBookings(); // Refresh the table after deletion
                })
                .catch(error => {
                    console.error('Error deleting booking:', error);
                    alert('Failed to delete booking.');
                });
            }
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
        <button class="add-booking-btn" onclick="openAddBookingModal()">Add Booking</button>
        <table class="bookings-table">
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Room No</th>
                    <th>Check-in</th>
                    <th>Check-out</th>
                    <th>Guests</th>
                    <th>Status</th>
                    <th>Username</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <!-- Rows will be dynamically inserted -->
            </tbody>
        </table>
    </section>
</main>

<!-- Modal for Adding Booking -->
<div id="addBookingModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeAddBookingModal()">&times;</span>
        <h3>Add Booking</h3>
        <form id="addBookingForm">
            <label for="addRoomNo">Room ID:</label>
            <input type="text" id="addRoomNo" name="roomId" required>
            
            <label for="addCheckIn">Check-in Date:</label>
            <input type="date" id="addCheckIn" name="checkin" required>
            
            <label for="addCheckOut">Check-out Date:</label>
            <input type="date" id="addCheckOut" name="checkout" required>
            
            <label for="addGuests">Guests:</label>
            <input type="number" id="addGuests" name="guests" required>
            
            <label for="addAmount">Total Amount:</label>
            <input type="number" id="addAmount" name="totalPrice" required>
            
            <input type="hidden" name="action" value="newBooking">
            <button type="button" class="save-btn" onclick="submitAddBooking()">Add Booking</button>
        </form>
    </div>
</div>

<!-- Modal for Editing Booking -->
<div id="editBookingModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeEditBookingModal()">&times;</span>
        <h3>Edit Booking</h3>
        <form>
            <input type="hidden" id="editBookingId" name="bookingId">
            
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
            
            <button type="button" class="save-btn" onclick="submitEditBooking()">Update</button>
        </form>
    </div>
</div>

<footer>
    <p>&copy; 2024 Humber Hotel Group. All rights reserved. | <a href="privacy.jsp">Privacy Policy</a></p>
</footer>

</body>
</html>
