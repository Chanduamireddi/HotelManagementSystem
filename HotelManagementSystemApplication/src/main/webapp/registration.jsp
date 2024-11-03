<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Registration Page</title>
    <link rel="stylesheet" href="styles/registration.css">
</head>
<body>
    <div class="registration-container">
        <div class="image-card">
            <img src="images/Hotel Login Image.jpg" alt="Hotel Image">
        </div>
        <div class="form-card">
            <h2>Register As New Customer</h2>
            <form action="RegisterServlet" method="post">
                <label for="firstName">First Name:</label>
                <input type="text" id="firstName" name="firstName" required>

                <label for="middleName">Middle Name:</label>
                <input type="text" id="middleName" name="middleName">

                <label for="lastName">Last Name:</label>
                <input type="text" id="lastName" name="lastName" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>

                <label for="phone">Phone Number:</label>
                <input type="tel" id="phone" name="phone" required>

                <button type="submit">Register</button>
            </form>
            
            <p>Already registered? <a href="loginpage.jsp">Login here</a>.</p>
        </div>
    </div>
</body>
</html>
