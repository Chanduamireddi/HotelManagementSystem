// Modal Handling
function openAddRoomModal() {
    document.getElementById('addRoomModal').style.display = 'block';
}

function closeAddRoomModal() {
    document.getElementById('addRoomModal').style.display = 'none';
}

function openEditRoomModal(roomType) {
    document.getElementById('editRoomModal').style.display = 'block';
    document.getElementById('editRoomType').value = roomType;
}

function closeEditRoomModal() {
    document.getElementById('editRoomModal').style.display = 'none';
}

// Close modals when clicking outside
window.onclick = function (event) {
    const addModal = document.getElementById('addRoomModal');
    const editModal = document.getElementById('editRoomModal');
    if (event.target === addModal) {
        addModal.style.display = 'none';
    }
    if (event.target === editModal) {
        editModal.style.display = 'none';
    }
};
