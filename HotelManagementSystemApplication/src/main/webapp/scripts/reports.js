// Monthly Revenue Chart
const revenueCtx = document.getElementById('revenueChart').getContext('2d');
new Chart(revenueCtx, {
    type: 'line',
    data: {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        datasets: [{
            label: 'Revenue ($)',
            data: [15000, 18000, 20000, 25000, 30000, 40000, 35000, 30000, 25000, 40000, 45000, 50000],
            borderColor: '#4CAF50',
            borderWidth: 2,
            fill: false
        }]
    },
    options: {
        responsive: true,
        plugins: {
            legend: {
                position: 'top'
            }
        }
    }
});

// Room Occupancy Chart
const occupancyCtx = document.getElementById('occupancyChart').getContext('2d');
new Chart(occupancyCtx, {
    type: 'bar',
    data: {
        labels: ['Deluxe', 'Executive', 'Presidential', 'Standard'],
        datasets: [{
            label: 'Occupancy Rate (%)',
            data: [85, 90, 70, 75],
            backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4CAF50']
        }]
    },
    options: {
        responsive: true,
        plugins: {
            legend: {
                position: 'top'
            }
        }
    }
});
