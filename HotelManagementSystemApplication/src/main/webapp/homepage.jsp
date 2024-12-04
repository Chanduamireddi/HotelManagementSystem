<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to Humber Hotel Group</title>
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
                <li><a href="homepage.jsp">Home</a></li>
                <li><a href="rooms.jsp">Rooms</a></li>
                <li><a href="bookingHistory.jsp">Book History</a></li>
                <li><a href="contactus.jsp">Contact Us</a></li>
            </ul>
        </nav>

        <div class="header-right">
            <div class="user-profile">
                <span class="username">User Account</span>
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
                <a href="Booking Confirmation.jsp" class="hero-button">Book Your Stay</a>
            </div>
        </div>
        <div class="carousel-slide fade">
            <img src="images/Banner1.jpg" alt="Discover Elegance">
            <div class="carousel-content">
                <h2>Discover Elegance</h2>
                <p>Unmatched luxury with breathtaking views.</p>
                <a href="Booking Confirmation.jsp" class="hero-button">Explore More</a>
            </div>
        </div>
    </section>

    <section class="hotel-overview">
        <div class="overview-card">
            <img src="images/HotelOverview.jpg" alt="Hotel Overview">
            <div class="overview-text">
                <h3>Humber Hotel Group</h3>
                <p>Located in a prime location, Humber Hotel Group combines elegance, comfort, and superior service for an unforgettable experience. Our hotel provides stunning city views, luxurious accommodations, and exclusive amenities, perfect for business or leisure stays.</p>
            </div>
        </div>
    </section>

    <section class="customer-favourites">
        <h3>Customer Favourites</h3>
        <div class="flip-card-container">
            <div class="flip-card">
                <div class="flip-card-inner">
                    <div class="flip-card-front">
                        <img src="images/Room1.jpg" alt="Deluxe Suite">
                        <div class="room-name">Deluxe Suite</div>
                    </div>
                    <div class="flip-card-back">
                        <p>A spacious suite with a king-size bed, city views, and premium amenities.</p>
                        <ul>
                            <li>Free Wi-Fi</li>
                            <li>24-Hour Room Service</li>
                            <li>Access to Pool</li>
                        </ul>
                        <a href="Booking Confirmation.jsp" class="book-button">Book Now</a>
                    </div>
                </div>
            </div>
            <div class="flip-card">
                <div class="flip-card-inner">
                    <div class="flip-card-front">
                        <img src="images/Room2.jpg" alt="Executive Room">
                        <div class="room-name">Executive Room</div>
                    </div>
                    <div class="flip-card-back">
                        <p>Elegant room with exclusive amenities for a luxurious stay.</p>
                        <ul>
                            <li>Free Wi-Fi</li>
                            <li>Complimentary Breakfast</li>
                            <li>Business Desk</li>
                        </ul>
                        <a href="Booking Confirmation.jsp" class="book-button">Book Now</a>
                    </div>
                </div>
            </div>
            <div class="flip-card">
                <div class="flip-card-inner">
                    <div class="flip-card-front">
                        <img src="images/Room3.jpg" alt="Presidential Suite">
                        <div class="room-name">Presidential Suite</div>
                    </div>
                    <div class="flip-card-back">
                        <p>A luxurious suite offering top-notch amenities and services.</p>
                        <ul>
                            <li>Free Wi-Fi</li>
                            <li>Private Balcony</li>
                            <li>Personal Butler</li>
                        </ul>
                        <a href="Booking Confirmation.jsp" class="book-button">Book Now</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="features">
        <h3>Hotel Features</h3>
        <div class="feature-list">
            <div class="feature-item">
                <img src="images/wifi.jpg" alt="Free Wi-Fi">
                <p>Free High-Speed Wi-Fi</p>
            </div>
            <div class="feature-item">
                <img src="images/pool.jpg" alt="Swimming Pool">
                <p>Infinity Pool</p>
            </div>
            <div class="feature-item">
                <img src="images/spa.jpg" alt="Spa & Wellness">
                <p>Spa & Wellness Center</p>
            </div>
            <div class="feature-item">
                <img src="images/room_service.png" alt="Room Service">
                <p>24-Hour Room Service</p>
            </div>
        </div>
    </section>

<section class="customer-reviews">
    <h3>Customer Reviews</h3>
    <div class="review-cards">
        <div class="review-card">
            <div class="review-image">
                <img src="images/ProfilePic.jpg" alt="Customer Photo">
            </div>
            <div class="review-text">
                <p>"An amazing experience! The rooms were spotless, and the staff was incredibly attentive."</p>
                <p class="review-author">- Sarah, Guest</p>
            </div>
        </div>
        <div class="review-card">
            <div class="review-image">
                <img src="images/Comment1.jpg" alt="Customer Photo">
            </div>
            <div class="review-text">
                <p>"Luxurious and comfortable stay with top-notch facilities. Highly recommended!"</p>
                <p class="review-author">- Michael, Business Traveler</p>
            </div>
        </div>
        <div class="review-card">
            <div class="review-image">
                <img src="images/Comment2.jpg" alt="Customer Photo">
            </div>
            <div class="review-text">
                <p>"The ambiance and amenities were just perfect for our getaway."</p>
                <p class="review-author">- Jessica, Tourist</p>
            </div>
        </div>
        <div class="review-card">
            <div class="review-image">
                <img src="images/Comment3.jpg" alt="Customer Photo">
            </div>
            <div class="review-text">
                <p>"Top-quality service from start to finish. I’ll definitely come back."</p>
                <p class="review-author">- Raj, Business Traveler</p>
            </div>
        </div>
        <div class="review-card">
            <div class="review-image">
                <img src="images/Comment5.jpg" alt="Customer Photo">
            </div>
            <div class="review-text">
                <p>"Perfect location with all the amenities I needed. Highly recommended!"</p>
                <p class="review-author">- Alex, Solo Traveler</p>
            </div>
        </div>
    </div>
</section>

    <footer>
        <p>&copy; 2024 Humber Hotel Group. All rights reserved. | <a href="privacy.jsp">Privacy Policy</a></p>
    </footer>

    <script src="scripts/hero.js"></script>
</body>
</html>