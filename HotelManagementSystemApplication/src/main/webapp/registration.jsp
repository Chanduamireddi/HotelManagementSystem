<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User/Customer Registration</title>
    <link rel="stylesheet" href="styles/registration.css">
</head>
<body>
    <div class="registration-page">

        <div class="image-section">
            <img src="images/Hotel Login Image.jpg" alt="Hotel Image">
        </div>

        <div class="form-section">
            <div class="form-card">
                <h2>USER/CUSTOMER REGISTRATION</h2>

                <!-- Role Toggle -->
                <div class="role-toggle">
                    <span id="roleText">User</span>
                    <label class="switch">
                        <input type="checkbox" id="roleSwitch" onclick="toggleRole()">
                        <span class="slider-round"></span>
                    </label>
                    <span id="roleTextAlt">Customer</span>
                </div>

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
    </div>

    <script>
        function toggleRole() {
            const roleSwitch = document.getElementById("roleSwitch");
            const roleText = document.getElementById("roleText");
            const roleTextAlt = document.getElementById("roleTextAlt");

            if (roleSwitch.checked) {
                roleText.style.color = "#ccc";
                roleTextAlt.style.color = "#4CAF50";
            } else {
                roleText.style.color = "#4CAF50";
                roleTextAlt.style.color = "#ccc";
            }
        }
    </script>
</body>
</html>
