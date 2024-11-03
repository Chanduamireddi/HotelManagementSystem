<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking Confirmation - [Hotel Name]</title>
    <link rel="stylesheet" href="styles/bookingconfirmation.css">
</head>
<body>
    <header>
        <h1>Booking Confirmation</h1>
    </header>
    
    <section class="confirmation-container">
        <div class="fixed-section">
            <h1 class="booking-details-title">Booking Details</h1>
            <div class="room-image">
                <img src="images/Room1.jpg" alt="Deluxe Suite">
            </div>
        </div>

        <div class="scrollable-details">
            <h2>Thank you for your reservation!</h2>
            <p>Your booking has been confirmed. Please review your booking details below:</p>

            <div class="booking-summary">
                <h3>Booking Summary</h3>
                <div class="summary-item">
                    <span>Room Type:</span>
                    <span>Deluxe Suite</span>
                </div>
                <div class="summary-item">
                    <span>Features:</span>
                    <span>King Bed, Ocean View, Free Wi-Fi</span>
                </div>
                <div class="summary-item">
                    <span>Check-In Date:</span>
                    <span>April 25, 2024</span>
                </div>
                <div class="summary-item">
                    <span>Check-Out Date:</span>
                    <span>April 30, 2024</span>
                </div>
                <div class="summary-item">
                    <span>Guests:</span>
                    <span>2 Adults, 1 Child</span>
                </div>
                <div class="summary-item">
                    <span>Total Price:</span>
                    <span>$1,250</span>
                </div>
            </div>

            <div class="confirmation-message">
                <p>If you have any questions or need further assistance, please contact us at (123) 456-7890 or email us at support@humber.com.</p>
                <p>We look forward to welcoming you!</p>
            </div>

            <div class="button-group">
                <a href="cancel-booking.jsp" class="action-button cancel">Cancel Booking</a>
                <a href="modify-booking.jsp" class="action-button modify">Modify Booking</a>
                <a href="index.jsp" class="action-button home">Home</a>
            </div>
        </div>
    </section>

    <footer>
        <p>&copy; 2024 [Humber Hotel]. All rights reserved.</p>
    </footer>
</body>
</html>
