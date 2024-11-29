// Function to open the "Add Booking" modal
function openAddBookingModal() {
    document.getElementById('addBookingModal').style.display = 'block';
}

// Function to close the "Add Booking" modal
function closeAddBookingModal() {
    document.getElementById('addBookingModal').style.display = 'none';
}

// Function to open the "Edit Booking" modal
function openEditBookingModal(bookingId) {
    // Pre-fill modal with existing booking details
    document.getElementById('editBookingId').value = bookingId;
    // Fetch details from backend and populate fields (mocked here)
    document.getElementById('editGuestName').value = 'John Doe';
    document.getElementById('editRoomType').value = 'Deluxe Room';
    document.getElementById('editCheckIn').value = '2024-12-01';
    document.getElementById('editCheckOut').value = '2024-12-05';
    document.getElementById('editStatus').value = 'Confirmed';

    document.getElementById('editBookingModal').style.display = 'block';
}

// Function to close the "Edit Booking" modal
function closeEditBookingModal() {
    document.getElementById('editBookingModal').style.display = 'none';
}

// Function to delete a booking
function deleteBooking(bookingId) {
    if (confirm(`Are you sure you want to delete booking ID ${bookingId}?`)) {
        // Implement deletion logic
        alert(`Booking ID ${bookingId} deleted successfully.`);
    }
}

// Function to view booking details
function viewBookingDetails(bookingId) {
    alert(`Viewing details for Booking ID: ${bookingId}`);
}
