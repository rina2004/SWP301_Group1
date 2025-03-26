<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Update Airplane</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
                background-color: #f5f5f5;
            }
            
            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }
            
            .back-link, .edit-link {
                display: inline-block;
                background-color: #3498db;
                color: white;
                padding: 10px 15px;
                text-decoration: none;
                border-radius: 4px;
                font-weight: bold;
            }
            
            .edit-link {
                background-color: #e74c3c;
            }
            
            .airplane-info {
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }
            
            .info-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 15px;
            }
            
            .info-item {
                background-color: #f9f9f9;
                padding: 15px;
                border-radius: 4px;
            }
            
            .info-item label {
                display: block;
                font-weight: bold;
                margin-bottom: 8px;
            }
            
            .info-item input, .info-item select {
                width: 100%;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            
            .airplane-layout {
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }
            
            .compartments-container {
            }
            
            .compartment {
                background-color: #f0f0f0;
                border: 2px solid #999;
                border-radius: 10px;
                padding: 20px;
                margin-bottom: 20px;
            }
            
            .compartment h3 {
                background-color: #2c3e50;
                color: white;
                padding: 10px;
                border-radius: 5px;
                margin-top: 0;
                margin-bottom: 15px;
            }
            
            .compartment label {
                display: block;
                font-weight: bold;
                margin-bottom: 5px;
            }
            
            .compartment input, .compartment select {
                width: 100%;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                margin-bottom: 15px;
            }
            
            .seats {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
                gap: 10px;
            }
            
            .seat {
                background-color: #f9f9f9;
                border-radius: 5px;
                padding: 10px;
            }
            
            .seat label {
                font-size: 0.9em;
            }
            
            .seat select {
                width: 100%;
                padding: 5px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 0.9em;
            }
            
            button[type="submit"] {
                display: block;
                width: 200px;
                margin: 20px auto;
                padding: 12px;
                background-color: #27ae60;
                color: white;
                border: none;
                border-radius: 4px;
                font-size: 1.1em;
                font-weight: bold;
                cursor: pointer;
            }
            
            .status-indicator {
                display: inline-block;
                width: 12px;
                height: 12px;
                border-radius: 50%;
                margin-right: 5px;
            }
            
            .status-available {
                background-color: #2ecc71;
            }
            
            .status-in-progress {
                background-color: #f1c40f;
            }
            
            .status-not-available {
                background-color: #e74c3c;
            }
            
            .new-compartment {
                background-color: #e8f4fc;
                border: 2px dashed #3498db;
            }
            
            .new-seat {
                background-color: #eafaf1;
                border: 1px dashed #2ecc71;
            }
            
            .compartment-type-select {
                margin-bottom: 15px;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <a href="${pageContext.request.contextPath}/airplane/view" class="back-link">Back to List</a>
            <h1>Update Airplane</h1>
            <a href="${pageContext.request.contextPath}/airplane/view/detail?id=${airplane.id}" class="edit-link">Cancel</a>
        </div>

        <form action="${pageContext.request.contextPath}/airplane/update" method="post" id="updateForm">
            <input type="hidden" name="airplaneId" value="${airplane.id}">

            <div class="airplane-info">
                <h2>Airplane Information</h2>
                <div class="info-grid">
                    <div class="info-item">
                        <label for="statusID">Status</label>
                        <select name="statusID" id="statusID">
                            <c:forEach items="${statuses}" var="status">
                                <option value="${status.id}" ${status.id == airplane.status.id ? 'selected' : ''}>
                                    ${status.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="info-item">
                        <label for="numOfComs">Number of Compartments</label>
                        <input type="number" id="numOfComs" name="numOfComs" value="${airplane.numOfComs}" min="${airplane.numOfComs}" onchange="handleCompartmentChange(this)">
                    </div>
                </div>
            </div>

            <div class="airplane-layout">
                <h2>Compartments</h2>
                <div class="compartments-container" id="compartmentsContainer">
                    <c:forEach items="${airplane.compartments}" var="comp" varStatus="compStatus">
                        <div class="compartment" id="compartment_${comp.id}" data-comp-id="${comp.id}" data-comp-index="${compStatus.index}">
                            <input type="hidden" name="compartmentIds" value="${comp.id}">
                            <h3>${comp.type.type}</h3>
                            
                            <label for="capacity_${comp.id}">Capacity</label>
                            <input type="number" id="capacity_${comp.id}" name="capacity_${comp.id}" 
                                   value="${comp.capacity}" min="${comp.capacity}" 
                                   data-original-capacity="${comp.capacity}"
                                   onchange="handleCapacityChange(this, ${comp.id})">
                            
                            <h4>Seats</h4>
                            <div class="seats" id="seats_${comp.id}">
                                <c:forEach items="${comp.seats}" var="seat" varStatus="seatStatus">
                                    <div class="seat" id="seat_${seat.id}" data-seat-id="${seat.id}">
                                        <input type="hidden" name="seatIds" value="${seat.id}">
                                        <label for="seatStatus_${seat.id}">
                                            <span class="status-indicator 
                                                <c:choose>
                                                    <c:when test="${seat.status == 'Available'}">status-available</c:when>
                                                    <c:when test="${seat.status == 'In progress'}">status-in-progress</c:when>
                                                    <c:otherwise>status-not-available</c:otherwise>
                                                </c:choose>
                                            "></span>
                                            ${seat.id}
                                        </label>
                                        <select name="seatStatus_${seat.id}" id="seatStatus_${seat.id}" onchange="updateStatusIndicator(this)">
                                            <option value="Available" ${seat.status == 'Available' ? 'selected' : ''}>Available</option>
                                            <option value="In progress" ${seat.status == 'In progress' ? 'selected' : ''}>In Progress</option>
                                            <option value="Not available" ${seat.status == 'Not available' ? 'selected' : ''}>Not Available</option>
                                        </select>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <button type="submit">Save Changes</button>
        </form>

        <script>
            const airplaneData = {
                id: "${airplane.id}",
                numOfComs: ${airplane.numOfComs},
                compartments: []
            };
            
            const compartmentTypes = [
                <c:forEach items="${compartmentTypes}" var="type" varStatus="status">
                    {name: "${type.type}" }${!status.last ? ',' : ''}
                </c:forEach>
            ];
            
            <c:forEach items="${airplane.compartments}" var="comp">
                airplaneData.compartments.push({
                    id: "${comp.id}",
                    typeName: "${comp.type.type}",
                    capacity: ${comp.capacity},
                    seats: []
                });
                
                <c:forEach items="${comp.seats}" var="seat">
                    airplaneData.compartments[airplaneData.compartments.length - 1].seats.push({
                        id: "${seat.id}",
                        status: "${seat.status}"
                    });
                </c:forEach>
            </c:forEach>
            
            function handleCompartmentChange(input) {
                const newNumOfComs = parseInt(input.value);
                const currentNumOfComs = airplaneData.numOfComs;
                
                if (newNumOfComs > currentNumOfComs) {
                    for (let i = currentNumOfComs; i < newNumOfComs; i++) {
                        addNewCompartment();
                    }
                } else if (newNumOfComs < currentNumOfComs) {
                    input.value = currentNumOfComs;
                    alert("Không thể giảm số lượng khoang. Chỉ có thể thêm khoang mới.");
                }
            }
            
            function addNewCompartment() {
                const container = document.getElementById('compartmentsContainer');
                const newCompId = `new_comp_${Date.now()}`;
                const compIndex = airplaneData.compartments.length;
                
                const newCompElement = document.createElement('div');
                newCompElement.className = 'compartment new-compartment';
                newCompElement.id = `compartment_${newCompId}`;
                newCompElement.setAttribute('data-comp-id', newCompId);
                newCompElement.setAttribute('data-comp-index', compIndex.toString());
                
                let typeOptions = '';
                compartmentTypes.forEach(type => {
                    typeOptions += `<option value="${type.type}">${type.type}</option>`;
                });
                
                newCompElement.innerHTML = `
                    <input type="hidden" name="newCompartmentIds" value="${newCompId}">
                    <div class="compartment-type-select">
                        <label for="compType_${newCompId}">Compartment Type</label>
                        <select name="compType_${newCompId}" id="compType_${newCompId}" required>
                            <option value="">Select Type</option>
                            ${typeOptions}
                        </select>
                    </div>
                    <h3>New Compartment</h3>
                    
                    <label for="capacity_${newCompId}">Capacity</label>
                    <input type="number" id="capacity_${newCompId}" name="capacity_${newCompId}" 
                           value="0" min="0" onchange="handleCapacityChange(this, '${newCompId}')">
                    
                    <h4>Seats</h4>
                    <div class="seats" id="seats_${newCompId}">
                        <!-- Seats will be added dynamically -->
                    </div>
                `;
                
                container.appendChild(newCompElement);
                
                airplaneData.compartments.push({
                    id: newCompId,
                    typeId: "",
                    typeName: "New Compartment",
                    capacity: 0,
                    seats: []
                });
                
                airplaneData.numOfComs++;
            }
            
            function handleCapacityChange(input, compId) {
                const newCapacity = parseInt(input.value);
                const compIndex = findCompartmentIndexById(compId);
                
                if (compIndex === -1) return;
                
                const comp = airplaneData.compartments[compIndex];
                const originalCapacity = parseInt(input.getAttribute('data-original-capacity') || "0");
                
                if (newCapacity < originalCapacity) {
                    input.value = originalCapacity;
                    alert("Không thể giảm số lượng ghế. Chỉ có thể thêm ghế mới.");
                    return;
                }
                
                if (newCapacity > comp.seats.length) {
                    addNewSeats(compId, newCapacity - comp.seats.length);
                }
            }
            
            function addNewSeats(compId, numSeatsToAdd) {
                const seatsContainer = document.getElementById(`seats_${compId}`);
                const compIndex = findCompartmentIndexById(compId);
                
                if (compIndex === -1 || !seatsContainer) return;
                
                const comp = airplaneData.compartments[compIndex];
                
                let maxSeatId = getMaxSeatId(comp);
                
                for (let i = 0; i < numSeatsToAdd; i++) {
                    const newSeatId = generateNextSeatId(maxSeatId, compId);
                    maxSeatId = newSeatId;
                    
                    const newSeatElement = document.createElement('div');
                    newSeatElement.className = 'seat new-seat';
                    newSeatElement.id = `seat_${newSeatId}`;
                    newSeatElement.setAttribute('data-seat-id', newSeatId);
                    
                    newSeatElement.innerHTML = `
                        <input type="hidden" name="newSeatIds" value="${newSeatId}">
                        <input type="hidden" name="newSeatCompartmentIds" value="${compId}">
                        <label for="seatStatus_${newSeatId}">
                            <span class="status-indicator status-available"></span>
                            ${newSeatId}
                        </label>
                        <select name="seatStatus_${newSeatId}" id="seatStatus_${newSeatId}" onchange="updateStatusIndicator(this)">
                            <option value="Available" selected>Available</option>
                            <option value="In progress">In Progress</option>
                            <option value="Not available">Not Available</option>
                        </select>
                    `;
                    
                    seatsContainer.appendChild(newSeatElement);
                    
                    comp.seats.push({
                        id: newSeatId,
                        status: "Available"
                    });
                }
            }
            
            function findCompartmentIndexById(compId) {
                return airplaneData.compartments.findIndex(comp => comp.id == compId);
            }
            
            function getMaxSeatId(compartment) {
                if (!compartment.seats || compartment.seats.length === 0) {
                    return null;
                }
                
                let maxId = compartment.seats[0].id;
                compartment.seats.forEach(seat => {
                    if (seat.id > maxId) {
                        maxId = seat.id;
                    }
                });
                
                return maxId;
            }
            
            function generateNextSeatId(currentMaxId, compId) {
                if (!currentMaxId) {
                    return `${compId}-S1`;
                }
                
                if (currentMaxId.includes('-')) {
                    const parts = currentMaxId.split('-');
                    const lastPart = parts[parts.length - 1];
                    
                    if (!isNaN(lastPart)) {
                        const nextNum = parseInt(lastPart) + 1;
                        parts[parts.length - 1] = nextNum.toString();
                        return parts.join('-');
                    }
                }
                
                return `${compId}-S${Date.now()}`;
            }
            
            function updateStatusIndicator(selectElement) {
                const indicator = selectElement.parentElement.querySelector('.status-indicator');
                
                indicator.classList.remove('status-available', 'status-in-progress', 'status-not-available');
                
                switch(selectElement.value) {
                    case 'Available':
                        indicator.classList.add('status-available');
                        break;
                    case 'In progress':
                        indicator.classList.add('status-in-progress');
                        break;
                    case 'Not available':
                        indicator.classList.add('status-not-available');
                        break;
                }
            }
        </script>
    </body>
</html>