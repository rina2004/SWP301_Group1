<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Airplane Details</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/viewAirplaneDetail.css">
    </head>
    <body>
        <h1>Airplane Details</h1>

        <!-- Airplane Information Section -->
        <div class="airplane-info">
            <h2>Aircraft Information</h2>
            <div class="info-grid">
                <div class="info-item">
                    <div class="info-label">ID</div>
                    <div class="info-value">${airplane.id}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Name</div>
                    <div class="info-value">${airplane.name}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Status</div>
                    <div class="info-value">${airplane.status.id}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Number of Compartments</div>
                    <div class="info-value">${airplane.numOfComs}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Maintenance Time</div>
                    <div class="info-value">${airplane.maintainanceTime}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Used Time</div>
                    <div class="info-value">${airplane.usedTime}</div>
                </div>
            </div>
        </div>

        <!-- Visual Representation of Compartments and Seats -->
        <div class="airplane-layout">
            <h2>Airplane Layout</h2>

            <c:set var="totalSeats" value="0" />
            <c:forEach items="${airplane.compartments}" var="comp">
                <c:set var="totalSeats" value="${totalSeats + comp.capacity}" />
            </c:forEach>

            <div class="airplane-body
                 <c:choose>
                     <c:when test="${totalSeats <= 30}">airplane-small</c:when>
                     <c:when test="${totalSeats <= 60}">airplane-medium</c:when>
                     <c:otherwise>airplane-large</c:otherwise>
                 </c:choose>
                 ">
                <!-- Decorative elements -->
                <div class="airplane-nose"></div>
                <div class="airplane-tail"></div>
                <div class="airplane-wings"></div>
                <div class="airplane-windows">
                    <c:set var="windowCount" value="3" />
                    <c:if test="${totalSeats > 30}">
                        <c:set var="windowCount" value="5" />
                    </c:if>
                    <c:if test="${totalSeats > 60}">
                        <c:set var="windowCount" value="7" />
                    </c:if>
                    <c:forEach begin="1" end="${windowCount}">
                        <div class="window"></div>
                    </c:forEach>
                </div>
                <div class="airplane-windows-bottom">
                    <c:forEach begin="1" end="${windowCount}">
                        <div class="window"></div>
                    </c:forEach>
                </div>

                <!-- Compartments -->
                <div class="compartments-row">
                    <c:forEach items="${airplane.compartments}" var="comp" varStatus="status">
                        <div class="compartment" data-capacity="${comp.capacity}">
                            <div class="compartment-header">
                                <span>${comp.name}</span>
                                <span>Capacity: ${comp.capacity}</span>
                            </div>

                            <div class="seats-container" data-seats="${comp.capacity}">
                                <c:set var="seatIndex" value="0" />
                                <c:forEach begin="1" end="6" var="row">
                                    <div class="seat-row">
                                        <c:forEach items="${comp.seats}" var="seat" varStatus="seatStatus">
                                            <c:if test="${seatStatus.index >= (row-1) * (comp.capacity / 6) && seatStatus.index < row * (comp.capacity / 6)}">
                                                <div class="seat
                                                     <c:choose>
                                                         <c:when test="${seat.status == 'Available'}">seat-available</c:when>
                                                         <c:when test="${seat.status == 'In progress'}">seat-in-progress</c:when>
                                                         <c:otherwise>seat-not-available</c:otherwise>
                                                     </c:choose>
                                                     ">
                                                    <div class="seat-id">${seat.id}</div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Add aisle between compartments except after the last one -->
                        <c:if test="${!status.last}">
                            <div class="aisle"></div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>

            <!-- Seat Status Legend -->
            <div class="seat-legend">
                <div class="legend-item">
                    <div class="legend-color seat-available"></div>
                    <span>Available</span>
                </div>
                <div class="legend-item">
                    <div class="legend-color seat-in-progress"></div>
                    <span>In Progress</span>
                </div>
                <div class="legend-item">
                    <div class="legend-color seat-not-available"></div>
                    <span>Not Available</span>
                </div>
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/airplane/view" class="back-link">Back to List</a>

        <script>
            // JavaScript để điều chỉnh kích thước ghế và khoang dựa trên số lượng ghế
            document.addEventListener('DOMContentLoaded', function () {
            // Thiết lập các biến CSS cho kích thước và khoảng cách ghế
            const root = document.documentElement;
                    const seatsContainer = compartment.querySelector('.seats-container');
                    const seatRows = compartment.querySelectorAll('.seat-row');
                    const capacity = parseInt(compartment.dataset.capacity) || 0;
                    root.style.setProperty('--seat-size', `${seatSize}px`);
                    root.style.setProperty('--seat-x-spacing', `${seatXSpacing}px`);
                    root.style.setProperty('--seat-y-spacing', `${seatYSpacing}px`);
                    const compartments = document.querySelectorAll('.compartment');
                    compartments.forEach(compartment => {
                    const seatsContainer = compartment.querySelector('.seats-container');
                            const seatRows = compartment.querySelectorAll('.seat-row');
                            const capacity = parseInt(compartment.dataset.capacity) || 0;
                            seatRows.forEach(row => {
                            const seatsInRow = row.querySelectorAll('.seat').length;
                                    const rowWidth = seatsInRow * seatSize + (seatsInRow - 1) * seatXSpacing;
                                    row.style.width = `${rowWidth}px`;
                            });
                            const compartmentWidth = rowWidth;
                            compartment.style.width = `${compartmentWidth}px`;
                            const compartmentHeight = 6 * seatSize + 5 * seatYSpacing + 60;
                            compartment.style.height = `${compartmentHeight}px`;
                            // Điều chỉnh kích thước máy bay dựa trên tổng số ghế
                            const airplaneBody = document.querySelector('.airplane-body');
                            // Điều chỉnh chiều rộng của máy bay dựa trên chiều rộng tổng cộng của các khoang
                            const totalCompartmentWidth = Array.from(compartments).reduce((total, comp) => {
                    return total + comp.offsetWidth;
                    }, 0);
                            // Thêm khoảng cách giữa các khoang và padding
                            const aisles = document.querySelectorAll('.aisle');
                            const aisleWidth = aisles.length * 20;
                            const minAirplaneWidth = totalCompartmentWidth + aisleWidth + 120; // 120px cho mũi và đuôi

                            // Đảm bảo máy bay đủ rộng để chứa tất cả khoang
                            if (minAirplaneWidth > airplaneBody.offsetWidth) {
                    airplaneBody.style.width = `${minAirplaneWidth}px`;
                    }
                    });
        </script>
    </body>
</html>