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
                    <span id="roleTextAlt">Admin</span>
                </div>

                <!-- Registration Form -->
                <form action="RegistrationServlet" method="post">
                    <!-- Hidden input to send role value -->
                    <input type="hidden" id="role" name="role" value="user">

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
        // Function to toggle role value
        function toggleRole() {
            const roleSwitch = document.getElementById("roleSwitch");
            const roleInput = document.getElementById("role");
            const roleText = document.getElementById("roleText");
            const roleTextAlt = document.getElementById("roleTextAlt");

            // Update the hidden role input and role label colors
            if (roleSwitch.checked) {
                roleInput.value = "admin";
                roleText.style.color = "#ccc";
                roleTextAlt.style.color = "#4CAF50";
            } else {
                roleInput.value = "user";
                roleText.style.color = "#4CAF50";
                roleTextAlt.style.color = "#ccc";
            }
        }

        // Check for error message from server
        const errorMessage = "<%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>";
        if (errorMessage) {
            alert(errorMessage);
        }
    </script>
</body>
</html>
