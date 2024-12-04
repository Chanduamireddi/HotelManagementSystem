<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Rooms Management - Humber Hotel</title>
<link rel="stylesheet" href="styles/roomsManagement.css">
<script>
 // Open the Add Room Modal
    function openAddRoomModal() {
        const modal = document.getElementById('addRoomModal');
        modal.style.display = 'block'; // Show the modal
    }

    // Close the Add Room Modal
    function closeAddRoomModal() {
        const modal = document.getElementById('addRoomModal');
        modal.style.display = 'none'; // Hide the modal
    }

    // Close the modal when clicking outside of it
    window.onclick = function (event) {
        const modal = document.getElementById('addRoomModal');
        if (event.target === modal) {
            modal.style.display = 'none'; // Hide the modal
        }
    };
    
    function openEditRoomModal(roomId) {
        // Find the table row corresponding to the clicked Edit button
        const tableRow = Array.from(document.querySelectorAll('.rooms-table tbody tr'))
            .find(row => row.querySelector('td').textContent === roomId);

        if (!tableRow) {
            console.error(`Room with ID ${roomId} not found in the table.`);
            return;
        }

        // Extract data from the table row cells
        const cells = tableRow.querySelectorAll('td');
        document.getElementById('editRoomType').value = cells[0].textContent; // Room ID
        document.getElementById('editActualPrice').value = cells[2].textContent; // Actual Price
        document.getElementById('editDiscountedPrice').value = cells[3].textContent === 'N/A' ? '' : cells[3].textContent; // Discounted Price
        document.getElementById('editFeatures').value = cells[4].textContent; // Features
        document.getElementById('editStartDate').value = cells[5].textContent; // Start Date
        document.getElementById('editEndDate').value = cells[6].textContent; // End Date
        document.getElementById('editMaxAdults').value = cells[7].textContent; // Max Adults
        document.getElementById('editMaxChildren').value = cells[8].textContent; // Max Children

        // Open the edit modal
        const modal = document.getElementById('editRoomModal');
        modal.style.display = 'block';
    }

    // Close the Edit Room Modal
    function closeEditRoomModal() {
        const modal = document.getElementById('editRoomModal');
        modal.style.display = 'none';
    }

    // Close the modal when clicking outside of it
    window.onclick = function (event) {
        const editModal = document.getElementById('editRoomModal');
        if (event.target === editModal) {
            editModal.style.display = 'none';
        }
    };

    function deleteRoom(roomId) {
        // Show a confirmation popup
        const isConfirmed = confirm(`Are you sure you want to delete the room with ID: ${roomId}?`);
        if (isConfirmed) {
            // Create a form dynamically to send the POST request
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'RoomSearchServlet';

            // Add hidden input fields for roomId and action
            const roomIdField = document.createElement('input');
            roomIdField.type = 'hidden';
            roomIdField.name = 'roomId';
            roomIdField.value = roomId;

            const actionField = document.createElement('input');
            actionField.type = 'hidden';
            actionField.name = 'action';
            actionField.value = 'deleteRoom';

            // Append fields to the form
            form.appendChild(roomIdField);
            form.appendChild(actionField);

            // Append form to the body and submit it
            document.body.appendChild(form);
            form.submit();
        }
    }

    function fetchRoomsData() {
        fetch('RoomSearchServlet') // Backend endpoint for room data
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                const tableBody = document.querySelector('.rooms-table tbody');
                tableBody.innerHTML = ''; // Clear existing rows
                
                // Ensure data is an array
                if (!Array.isArray(data)) {
                    console.error('Expected an array of rooms, received:', data);
                    return;
                }
                
                // Loop through each room and append to the table
                for (const room of data) {
                    const row = document.createElement('tr');

                    // Create table cells
                    const roomIdCell = document.createElement('td');
                    roomIdCell.textContent = room.room_id;

                    const roomNameCell = document.createElement('td');
                    roomNameCell.textContent = room.room_name;

                    const actualPriceCell = document.createElement('td');
                    actualPriceCell.textContent = room.actual_price;

                    const discountedPriceCell = document.createElement('td');
                    discountedPriceCell.textContent = room.discounted_price || 'N/A';

                    const featuresCell = document.createElement('td');
                    featuresCell.textContent = room.features;

                    const startDateCell = document.createElement('td');
                    startDateCell.textContent = room.start_date;

                    const endDateCell = document.createElement('td');
                    endDateCell.textContent = room.end_date;

                    const maxAdultsCell = document.createElement('td');
                    maxAdultsCell.textContent = room.max_adults;

                    const maxChildrenCell = document.createElement('td');
                    maxChildrenCell.textContent = room.max_children;

                    // Action buttons
                    const actionsCell = document.createElement('td');
                    const editButton = document.createElement('button');
                    editButton.textContent = 'Edit';
                    editButton.className = 'edit-btn';
                    editButton.onclick = () => openEditRoomModal(room.room_id);

                    const deleteButton = document.createElement('button');
                    deleteButton.textContent = 'Delete';
                    deleteButton.className = 'delete-btn';
                    deleteButton.onclick = () => deleteRoom(room.room_id);

                    actionsCell.appendChild(editButton);
                    actionsCell.appendChild(deleteButton);

                    // Append cells to row
                    row.appendChild(roomIdCell);
                    row.appendChild(roomNameCell);
                    row.appendChild(actualPriceCell);
                    row.appendChild(discountedPriceCell);
                    row.appendChild(featuresCell);
                    row.appendChild(startDateCell);
                    row.appendChild(endDateCell);
                    row.appendChild(maxAdultsCell);
                    row.appendChild(maxChildrenCell);
                    row.appendChild(actionsCell);

                    // Append row to table body
                    tableBody.appendChild(row);
                }
            })
            .catch(error => {
                console.error('Error fetching room data:', error);
            });
    }


        // Call fetchRoomsData on page load
        document.addEventListener('DOMContentLoaded', fetchRoomsData);
    </script>
</head>
<body>

	<header>
		<div class="header-left">
			<img src="images/HumberLogo.jpg" alt="Logo" class="logo"> <span
				class="hotel-name">Humber Hotel</span>
		</div>

		<nav class="header-center">
			<ul>
				<li><a href="adminHome.jsp">Admin Home</a></li>
				<li><a href="roomsManagement.jsp" class="active">Rooms
						Management</a></li>
				<li><a href="bookingsManagement.jsp">Bookings Management</a></li>
				<li><a href="reports.jsp">Reports</a></li>
			</ul>
		</nav>

		<div class="header-right">
			<div class="user-profile">
				<span class="username">Admin User</span>
				<div class="dropdown-menu">
					<a href="userprofile.jsp">User Profile</a> <a href="logout.jsp">Logout</a>
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
						<th>Room ID</th>
						<th>Room Name</th>
						<th>Actual Price</th>
						<th>Discounted Price</th>
						<th>Features</th>
						<th>Start Date</th>
						<th>End Date</th>
						<th>Max Adults</th>
						<th>Max Children</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<%-- Rows will be dynamically inserted via JavaScript --%>
				</tbody>
			</table>
			<div class="room-actions">
				<button class="add-room-btn" onclick="openAddRoomModal()">Add
					New Room Type</button>
			</div>
		</section>
	</main>

	<!-- Modal for Adding a New Room -->
	<div id="addRoomModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeAddRoomModal()">&times;</span>
			<h3>Add New Room Type</h3>
			<form action="RoomSearchServlet" method="POST">
				<!-- Hidden field to set action as 'addRoom' -->
				<input type="hidden" name="action" value="addRoom"> <label
					for="roomType">Room Type:</label> <input type="text" id="roomType"
					name="roomType" required> <label for="description">Description:</label>
				<textarea id="description" name="description" required></textarea>

				<label for="actualPrice">Actual Price:</label> <input type="number"
					id="actualPrice" name="actualPrice" required> <label
					for="discountedPrice">Discounted Price:</label> <input
					type="number" id="discountedPrice" name="discountedPrice">

				<label for="features">Features:</label>
				<textarea id="features" name="features" required></textarea>

				<label for="startDate">Start Date:</label> <input type="date"
					id="startDate" name="startDate" required> <label
					for="endDate">End Date:</label> <input type="date" id="endDate"
					name="endDate" required> <label for="maxAdults">Max
					Adults:</label> <input type="number" id="maxAdults" name="maxAdults"
					required> <label for="maxChildren">Max Children:</label> <input
					type="number" id="maxChildren" name="maxChildren" required>

				<button type="submit" class="save-btn">Save</button>
			</form>


		</div>
	</div>

	<div id="editRoomModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeEditRoomModal()">&times;</span>
        <h3>Edit Room Type</h3>
        <form action="RoomSearchServlet" method="POST">
            <!-- Hidden field for action -->
            <input type="hidden" name="action" value="updateRoom">
            
            <!-- Hidden field for room ID -->
            <input type="hidden" id="editRoomType" name="roomId">

            <label for="editActualPrice">Actual Price:</label>
            <input type="number" id="editActualPrice" name="actualPrice" required>
            
            <label for="editDiscountedPrice">Discounted Price:</label>
            <input type="number" id="editDiscountedPrice" name="discountedPrice">
            
            <label for="editFeatures">Features:</label>
            <textarea id="editFeatures" name="features" required></textarea>
            
            <label for="editStartDate">Start Date:</label>
            <input type="date" id="editStartDate" name="startDate" required>
            
            <label for="editEndDate">End Date:</label>
            <input type="date" id="editEndDate" name="endDate" required>
            
            <label for="editMaxAdults">Max Adults:</label>
            <input type="number" id="editMaxAdults" name="maxAdults" required>
            
            <label for="editMaxChildren">Max Children:</label>
            <input type="number" id="editMaxChildren" name="maxChildren" required>
            
            <button type="submit" class="save-btn">Update</button>
        </form>
    </div>
</div>


	<footer>
		<p>
			&copy; 2024 Humber Hotel Group. All rights reserved. | <a
				href="privacy.jsp">Privacy Policy</a>
		</p>
	</footer>

</body>
</html>
