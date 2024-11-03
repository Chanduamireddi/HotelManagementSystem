<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <link rel="stylesheet" href="styles/userprofile.css">
</head>
<body>
    <header>
        <h1>User Profile</h1>
    </header>

    <section class="profile-container">
        <div class="personal-info">
            <div class="profile-image">
                <img src="images/ProfilePic.jpg" alt="User Profile Picture">
            </div>
            <div class="profile-details">
                <h2>Personal Information</h2>
                <div class="detail-field"><strong>First Name: </strong>Chandu</div>
                <div class="detail-field"><strong>Middle Name: </strong>Sarath</div>
                <div class="detail-field"><strong>Last Name: </strong>Siva</div>
                <div class="detail-field"><strong>Email: </strong> chandu@gmail.com</div>
                <div class="detail-field"><strong>Phone Number: </strong>9999999999</div>
                <div class="detail-field"><strong>Address: </strong> 123 Main Street, City, Country</div>
                <button class="edit-button">Edit Profile</button>
            </div>
        </div>

        <div class="bookings-info">
            <h2>Your Booking History</h2>
            <div class="booking-cards">
                <div class="booking-card">
                    <img src="images/Room1.jpg" alt="Room Image">
                    <div class="booking-details">
                        <h3>Deluxe Suite</h3>
                        <p><strong>Booking ID:</strong> 12345</p>
                        <p><strong>Check-In:</strong> April 25, 2024</p>
                        <p><strong>Check-Out:</strong> April 30, 2024</p>
                        <p><strong>Total Price:</strong> $1,250</p>
                        <a href="Booking Confirmation.jsp" class="details-button">View Details</a>
                    </div>
                </div>
                <div class="booking-card">
                    <img src="images/Room2.jpg" alt="Room Image">
                    <div class="booking-details">
                        <h3>Standard Room</h3>
                        <p><strong>Booking ID:</strong> 67890</p>
                        <p><strong>Check-In:</strong> May 5, 2024</p>
                        <p><strong>Check-Out:</strong> May 10, 2024</p>
                        <p><strong>Total Price:</strong> $800</p>
                        <a href="Booking Confirmation.jsp" class="details-button">View Details</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <footer>
        <p>&copy; 2024 Humber International. All rights reserved.</p>
    </footer>
</body>
</html>
