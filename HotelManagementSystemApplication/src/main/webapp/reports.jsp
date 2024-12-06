<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports - Humber Hotel</title>
    <link rel="stylesheet" href="styles/reports.css">
</head>
<body>

<header>
    <div class="header-left">
        <img src="images/HumberLogo.jpg" alt="Logo" class="logo">
        <span class="hotel-name">Humber Hotel</span>
    </div>

    <nav class="header-center">
        <ul>
            <li><a href="adminHome.jsp">Admin Home</a></li>
            <li><a href="roomsManagement.jsp">Rooms Management</a></li>
            <li><a href="bookingsManagement.jsp">Bookings Management</a></li>
            <li><a href="reports.jsp" class="active">Reports</a></li>
        </ul>
    </nav>

    <div class="header-right">
        <div class="user-profile">
            <span class="username">Admin User</span>
            <div class="dropdown-menu">
                <a href="userprofile.jsp">User Profile</a>
                <a href="logout.jsp">Logout</a>
            </div>
        </div>
    </div>
</header>

<main>
    <section class="reports">
        <h2>Reports</h2>

        <div class="chart-container">
            <div class="chart">
                <h3>Monthly Revenue (Line Graph)</h3>
                <canvas id="revenueChart" width="400" height="200"></canvas>
            </div>
            <div class="chart">
                <h3>Room Occupancy (Bar Chart)</h3>
                <canvas id="occupancyChart" width="400" height="200"></canvas>
            </div>
        </div>
    </section>
</main>

<footer>
    <p>&copy; 2024 Humber Hotel Group. All rights reserved. | <a href="privacy.jsp">Privacy Policy</a></p>
</footer>
<script>
    // Fetch data from the servlet
    fetch('BookingServlet?json=true')
        .then(response => {
            if (!response.ok) {
                throw new Error(`Failed to fetch data. Status: ${response.status}`);
            }
            return response.json();
        })
        .then(data => {
            const months = [
                "2024-01", "2024-02", "2024-03", "2024-04", "2024-05",
                "2024-06", "2024-07", "2024-08", "2024-09", "2024-10",
                "2024-11", "2024-12"
            ];

            // Ensure all months are represented, even with 0 values
            const completeData = months.reduce((acc, month) => {
                acc[month] = data[month] || 0; // Default to 0 if missing
                return acc;
            }, {});

            drawLineChart(completeData, 'revenueChart', 'Monthly Revenue ($)');
            drawBarChart(completeData, 'occupancyChart', 'Room Occupancy (%)');
        })
        .catch(error => {
            console.error('Error fetching or processing data:', error);
            alert('Failed to load chart data. Please try again later.');
        });

    function drawLineChart(data, canvasId, label) {
        const canvas = document.getElementById(canvasId);
        const ctx = canvas.getContext('2d');

        canvas.width = 600;
        canvas.height = 300;

        const labels = Object.keys(data);
        const values = Object.values(data);

        const chartPadding = 60;
        const chartHeight = canvas.height - chartPadding * 2;
        const chartWidth = canvas.width - chartPadding * 2;

        const maxValue = Math.max(...values) || 100;
        const xStep = chartWidth / (labels.length - 1);
        const yStep = chartHeight / maxValue;

        ctx.clearRect(0, 0, canvas.width, canvas.height);

        ctx.beginPath();
        ctx.moveTo(chartPadding, chartPadding);
        ctx.lineTo(chartPadding, canvas.height - chartPadding);
        ctx.lineTo(canvas.width - chartPadding, canvas.height - chartPadding);
        ctx.strokeStyle = '#333';
        ctx.lineWidth = 2;
        ctx.stroke();

        ctx.font = '10px Arial';
        ctx.textAlign = 'right';
        for (let i = 0; i <= maxValue; i += maxValue / 5) {
            const y = canvas.height - chartPadding - i * yStep;
            ctx.fillText(i.toFixed(0), chartPadding - 10, y);
        }

        ctx.textAlign = 'center';
        labels.forEach((label, index) => {
            const x = chartPadding + index * xStep;
            ctx.fillText(label, x, canvas.height - chartPadding + 15);
        });

        ctx.beginPath();
        ctx.strokeStyle = 'blue';
        ctx.lineWidth = 2;

        labels.forEach((label, index) => {
            const x = chartPadding + index * xStep;
            const y = canvas.height - chartPadding - values[index] * yStep;

            if (index === 0) ctx.moveTo(x, y);
            else ctx.lineTo(x, y);
        });
        ctx.stroke();

        labels.forEach((label, index) => {
            const x = chartPadding + index * xStep;
            const y = canvas.height - chartPadding - values[index] * yStep;

            ctx.beginPath();
            ctx.arc(x, y, 4, 0, Math.PI * 2);
            ctx.fillStyle = 'blue';
            ctx.fill();
            ctx.closePath();
        });
    }

    function drawBarChart(data, canvasId, label) {
        const canvas = document.getElementById(canvasId);
        const ctx = canvas.getContext('2d');

        canvas.width = 600;
        canvas.height = 300;

        const labels = Object.keys(data);
        const values = Object.values(data);

        const chartPadding = 60;
        const chartHeight = canvas.height - chartPadding * 2;
        const chartWidth = canvas.width - chartPadding * 2;

        const maxValue = Math.max(...values) || 100;
        const xStep = chartWidth / labels.length;
        const yStep = chartHeight / maxValue;

        ctx.clearRect(0, 0, canvas.width, canvas.height);

        ctx.beginPath();
        ctx.moveTo(chartPadding, chartPadding);
        ctx.lineTo(chartPadding, canvas.height - chartPadding);
        ctx.lineTo(canvas.width - chartPadding, canvas.height - chartPadding);
        ctx.strokeStyle = '#333';
        ctx.lineWidth = 2;
        ctx.stroke();

        ctx.font = '10px Arial';
        ctx.textAlign = 'right';
        for (let i = 0; i <= maxValue; i += maxValue / 5) {
            const y = canvas.height - chartPadding - i * yStep;
            ctx.fillText(i.toFixed(0), chartPadding - 10, y + 4);
        }

        ctx.textAlign = 'center';
        labels.forEach((label, index) => {
            const x = chartPadding + index * xStep + xStep / 2;
            ctx.fillText(label, x, canvas.height - chartPadding + 15);
        });

        labels.forEach((label, index) => {
            const x = chartPadding + index * xStep + xStep / 4;
            const y = canvas.height - chartPadding - values[index] * yStep;
            const barWidth = xStep / 2;

            ctx.fillStyle = 'green';
            ctx.fillRect(x, y, barWidth, values[index] * yStep);
        });
    }
</script>
</body>
</html>
