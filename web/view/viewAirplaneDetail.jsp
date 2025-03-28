<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Airplane Details</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/viewAirplaneDetail.css">
        <script src ="${pageContext.request.contextPath}/js/viewAirplaneDetails.js" defer=""></script>
    </head>
    <body>
        <div class="header">
            <a href="${pageContext.request.contextPath}/airplane/view" class="back-link">Back to List</a>
            <button id="edit-btn" class="edit-link">Edit</button>
            <button id="save-btn" style="display: none;" class="edit-link">Save Changes</button>
            <button id="cancel-btn" style="display: none;" class="edit-link">Cancel</button>
        </div>
        <!-- Airplane Information Section -->
        <div class="airplane-info">
            <h2>Airplane Details</h2>
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
                    <div class="info-value">${airplane.status.name}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Number of Compartments</div>
                    <div class="info-value">${airplane.numOfComs}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Maintenance Time</div>
                    <div class="info-value">${airplane.maintainanceTime.toString().replace('T', ' ')}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Used Time</div>
                    <div class="info-value">${airplane.usedTime.toString().replace('T', ' ')}</div>
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
                                <span>${comp.type.type}</span>
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
                                                    <div class="seat-id" data-id="${seat.id}" data-status="${seat.status}">${seat.id}</div>
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
    </body>
</html>