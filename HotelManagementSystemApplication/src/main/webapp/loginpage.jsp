<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>USER & ADMIN LOGIN</title>
    <link rel="stylesheet" href="styles/login.css">
</head>
<body>
    <div class="login-container">
        <div class="image-card">
            <img src="images/Hotel Login Image.jpg" alt="Hotel Image">
        </div>

        <div class="form-card">
            <h2>USER/ADMIN LOGIN</h2>

            <div class="role-toggle">
                <span id="roleText">Admin</span>
                <label class="switch">
                    <input type="checkbox" id="roleSwitch" onclick="toggleRole()">
                    <span class="slider-round"></span>
                </label>
                <span id="roleTextAlt">Customer</span>
            </div>

            <form action="LoginServlet" method="post">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>

                <button type="submit">Login</button>
            </form>

            <p>Not registered yet? <a href="registration.jsp">Create a New Account</a>.</p>
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
