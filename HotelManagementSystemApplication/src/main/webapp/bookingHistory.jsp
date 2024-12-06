<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking History - Humber Hotel Group</title>
    <link rel="stylesheet" href="styles/bookingHistory.css">
    <script>
        // JavaScript to send a POST request on page load
        document.addEventListener("DOMContentLoaded", function () {
            const userId = '<%= session != null ? session.getAttribute("userId") : "" %>';
            if (userId) {
                fetch('BookingServlet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        action: 'userHistory',
                        userId: userId
                    })
                })
                .then(response => response.json())
                .then(data => {
                    if (data && Array.isArray(data)) {
                        if (data.length > 0) {
                            renderBookingHistory(data);
                        } else {
                            displayNoBookingsMessage();
                        }
                    } else {
                        displayNoBookingsMessage();
                    }
                })
                .catch(err => {
                    console.error('Error fetching booking history:', err);
                    displayErrorMessage();
                });
            } else {
                alert('User not logged in.');
            }
        });

        // Function to render booking history into a table
        function renderBookingHistory(bookings) {
            const table = document.createElement("table");
            table.innerHTML = `
                <thead>
                    <tr>
                        <th>Booking ID</th>
                        <th>Room Type</th>
                        <th>Check-In</th>
                        <th>Check-Out</th>
                        <th>Total Price</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            `;

            const tbody = table.querySelector("tbody");
            const today = new Date(); // Define 'today' here
            today.setHours(0, 0, 0, 0); // Ensure today has no time component

            bookings.forEach(booking => {
                const row = document.createElement("tr");

                // Set each cell with booking data
                const bookingIdCell = document.createElement("td");
                bookingIdCell.textContent = booking.bookingId;
                row.appendChild(bookingIdCell);

                const roomTypeCell = document.createElement("td");
                roomTypeCell.textContent = booking.roomType;
                row.appendChild(roomTypeCell);

                const checkInCell = document.createElement("td");
                checkInCell.textContent = booking.checkInDate;
                row.appendChild(checkInCell);

                const checkOutCell = document.createElement("td");
                checkOutCell.textContent = booking.checkOutDate;
                row.appendChild(checkOutCell);

                const totalPriceCell = document.createElement("td");
                totalPriceCell.textContent = booking.totalPrice.toFixed(2);
                row.appendChild(totalPriceCell);

                const statusCell = document.createElement("td");
                statusCell.textContent = booking.status;
                row.appendChild(statusCell);

                // Add Action column
                const actionCell = document.createElement("td");
                const checkInDate = new Date(booking.checkInDate); // Convert checkInDate to a Date object

                if (checkInDate >= today && booking.status.toLowerCase() !== "cancelled") {
                    // Allow cancellation for today and future bookings
                    const cancelButton = document.createElement("button");
                    cancelButton.textContent = "Cancel";
                    cancelButton.classList.add("cancel-button");
                    cancelButton.setAttribute("data-booking-id", booking.bookingId); // Add booking ID for reference
                    cancelButton.onclick = () => cancelBooking(booking.bookingId);
                    actionCell.appendChild(cancelButton);
                } else if (booking.status.toLowerCase() === "cancelled") {
                    // Already cancelled
                    actionCell.textContent = "Already Cancelled";
                } else {
                    // Past bookings - Cancellation not allowed
                    actionCell.textContent = "Not Allowed";
                }

                row.appendChild(actionCell);

                // Append row to the table body
                tbody.appendChild(row);
            });

            const bookingsContainer = document.querySelector(".booking-history");
            bookingsContainer.innerHTML = ""; // Clear any existing content
            bookingsContainer.appendChild(table); // Add the new table
        }

        function cancelBooking(bookingId) {
            if (confirm("Are you sure you want to cancel this booking?")) {
                fetch('BookingServlet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        action: 'cancelBooking',
                        bookingId: bookingId
                    })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert("Booking cancelled successfully.");
                        
                        // Update the action cell text dynamically
                        const actionCell = document.querySelector(`button[data-booking-id="${bookingId}"]`).parentElement;
                        actionCell.innerHTML = '<span class="cancelled-text">Cancelled</span>';
                    } else {
                        alert("Failed to cancel booking. Please try again.");
                    }
                })
                .catch(err => {
                    console.error('Error cancelling booking:', err);
                    alert("An error occurred. Please try again.");
                });
            }
        }

        // Function to display a message if no bookings are found
        function displayNoBookingsMessage() {
            const bookingsContainer = document.querySelector(".booking-history");
            bookingsContainer.innerHTML = '<p>No bookings found.</p>';
        }

        // Function to display an error message if fetching data fails
        function displayErrorMessage() {
            const bookingsContainer = document.querySelector(".booking-history");
            bookingsContainer.innerHTML = '<p>An error occurred while fetching your booking history. Please try again later.</p>';
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
                <li><a href="bookingHistory.jsp" class="active">Booking History</a></li>
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
        <section class="booking-history">
            <h1>Your Booking History</h1>
            <p>Loading booking history...</p>
        </section>
    </main>

    <footer>
        <p>&copy; 2024 Humber Hotel Group. All rights reserved. | <a href="privacy.jsp">Privacy Policy</a></p>
    </footer>
</body>
</html>
