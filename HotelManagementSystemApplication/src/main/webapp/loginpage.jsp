<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Login</title>
    <link rel="stylesheet" href="styles/login.css">
</head>
<body>
    <div class="login-container">
        <div class="image-card">
            <img src="images/Hotel Login Image.jpg" alt="Hotel Image">
        </div>

        <div class="form-card">
            <h2>User Login</h2>
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
</body>
</html>
