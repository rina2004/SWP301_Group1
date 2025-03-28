/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


document.addEventListener('DOMContentLoaded', function () {
    const seatIds = document.querySelectorAll('.seat-id');

    seatIds.forEach(seatId => {
        seatId.addEventListener('mousedown', function (event) {
            event.preventDefault();
        });

        seatId.addEventListener('selectstart', function (event) {
            event.preventDefault();
        });
    });

    const root = document.documentElement;
    const seatSize = 30;
    const seatXSpacing = seatSize * 0.25;
    const seatYSpacing = seatSize * 0.25;
    const compartments = document.querySelectorAll('.compartment');
    console.log("Total compartments found:", compartments.length);
    root.style.setProperty('--seat-size', `${seatSize}px`);
    root.style.setProperty('--seat-x-spacing', `${seatXSpacing}px`);
    root.style.setProperty('--seat-y-spacing', `${seatYSpacing}px`);
    compartments.forEach(compartment => {
        const seatsContainer = compartment.querySelector('.seats-container');
        const seatRows = compartment.querySelectorAll('.seat-row');
        const capacity = parseInt(compartment.dataset.capacity) || 0;
        seatRows.forEach(row => {
            const seatsInRow = row.querySelectorAll('.seat').length;
            const rowWidth = seatsInRow * seatSize + (seatsInRow - 1) * seatXSpacing;
            row.style.width = `${rowWidth}px`;
        });
        let maxRowWidth = 0;
        seatRows.forEach(row => {
            const seatsInRow = row.querySelectorAll('.seat').length;
            const rowWidth = seatsInRow * seatSize + (seatsInRow - 1) * seatXSpacing;
            row.style.width = `${rowWidth}px`;
            if (rowWidth > maxRowWidth) {
                maxRowWidth = rowWidth;
            }
        });
        const compartmentWidth = maxRowWidth;
        compartment.style.width = `${compartmentWidth}px`;
        compartment.style.width = `${compartmentWidth}px`;
        const compartmentHeight = 6 * seatSize + 5 * seatYSpacing + 60;
        compartment.style.height = `${compartmentHeight}px`;
        const airplaneBody = document.querySelector('.airplane-body');
        const totalCompartmentWidth = Array.from(compartments).reduce((total, comp) => {
            return total + comp.offsetWidth;
        }, 0);
        const aisles = document.querySelectorAll('.aisle');
        const aisleWidth = aisles.length * 20;
        const minAirplaneWidth = totalCompartmentWidth + aisleWidth + 120;
        if (minAirplaneWidth > airplaneBody.offsetWidth) {
            airplaneBody.style.width = `${minAirplaneWidth}px`;
        }
    });

    let editMode = false;
    const seats = document.querySelectorAll('.seat-id');
    const editBtn = document.getElementById("edit-btn");
    const saveBtn = document.getElementById("save-btn");
    const cancelBtn = document.getElementById("cancel-btn");

    let originalSeatStates = new Map(); // Lưu trạng thái ban đầu của ghế

    if (editBtn && saveBtn && cancelBtn) {
        editBtn.addEventListener("click", function () {
            editMode = true;
            editBtn.style.display = "none";
            saveBtn.style.display = "inline-block";
            cancelBtn.style.display = "inline-block";

            // Lưu trạng thái ban đầu của các seat-id
            seats.forEach(seatId => {
                originalSeatStates.set(seatId, seatId.dataset.status);
            });
        });

        seats.forEach(seatId => {
            seatId.addEventListener("click", function () {
                if (!editMode)
                    return;

                const seat = seatId.closest('.seat');
                seat.classList.remove("seat-available", "seat-in-progress", "seat-not-available");

                if (seatId.dataset.status === "Available") {
                    seatId.dataset.status = "In progress";
                    seat.classList.add("seat-in-progress");
                } else if (seatId.dataset.status === "In progress") {
                    seatId.dataset.status = "Not Available";
                    seat.classList.add("seat-not-available");
                } else {
                    seatId.dataset.status = "Available";
                    seat.classList.add("seat-available");
                }
            });
        });

        saveBtn.addEventListener("click", function () {
            let seatUpdates = [];
            seats.forEach(seatId => {
                seatUpdates.push({
                    id: seatId.dataset.id,
                    status: seatId.dataset.status
                });
            });

            fetch('/webapp/airplane/updateSeats', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify(seatUpdates)
            }).then(response => response.json()).then(data => {
                if (data.success) {
                    alert("Seats updated successfully!");

                    editMode = false;
                    editBtn.style.display = "inline-block";
                    saveBtn.style.display = "none";
                    cancelBtn.style.display = "none";
                } else {
                    alert("Failed to update seats: " + (data.error || "Unknown error"));
                }
            }).catch(error => {
                console.error('Error:', error);
                alert("Failed to update seats. Server not responding.");
            });
        });

        cancelBtn.addEventListener("click", function () {
            editMode = false;
            editBtn.style.display = "inline-block";
            saveBtn.style.display = "none";
            cancelBtn.style.display = "none";

            // Khôi phục trạng thái ban đầu
            seats.forEach(seatId => {
                seatId.dataset.status = originalSeatStates.get(seatId);
                const seat = seatId.closest('.seat');
                seat.classList.remove("seat-available", "seat-in-progress", "seat-not-available");

                if (seatId.dataset.status === "Available") {
                    seat.classList.add("seat-available");
                } else if (seatId.dataset.status === "In progress") {
                    seat.classList.add("seat-in-progress");
                } else {
                    seat.classList.add("seat-not-available");
                }
            });
        });
    } else {
        console.error("Edit, Save or Cancel button not found");
    }
});