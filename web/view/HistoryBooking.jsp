<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Order"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
    <head>
        <title>Order History</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f9f9f9;
                margin: 20px;
            }
            h2 {
                color: #333;
            }
            table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                background: #fff;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                border-radius: 8px;
                overflow: hidden;
            }
            th, td {
                padding: 12px 15px;
                text-align: center;
            }
            th {
                background-color: #4CAF50;
                color: white;
                text-transform: uppercase;
                letter-spacing: 0.05em;
            }
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            tr:hover {
                background-color: #e0f7fa;
            }
            .btn {
                padding: 6px 14px;
                background-color: #2196F3;
                color: #fff;
                text-decoration: none;
                border-radius: 4px;
                border: none;
                transition: background-color 0.3s;
                display: inline-block;
            }
            .btn:hover {
                background-color: #1976D2;
            }
            .btn-secondary {
                background-color: #9e9e9e;
            }
            .btn-secondary:hover {
                background-color: #757575;
            }
            .btn-disabled {
                background-color: #d3d3d3;
                cursor: not-allowed;
                pointer-events: none;
            }
            .table-container {
                margin-top: 20px;
            }
            .action-group {
                display: flex;
                justify-content: center;
                gap: 8px;
            }
        </style>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    </head>
    <body>
        <h2>My Orders</h2>

        <div class="table-container">
            <c:if test="${empty orders}">
                <p>You have no orders yet.</p>
            </c:if>

            <c:if test="${not empty orders}">
                <table>
                    <tr>
                        <th>Order ID</th>
                        <th>Time</th>
                        <td>Total Passenger</td>
                        <th>Total Price</th>
                    </tr>
                    <c:forEach var="order" items="${orders}">
                        <tr class="order-row">
                            <td>${order.id}</td>
                            <td>${order.time}</td>
                            <td>${order.finalNum}</td>
                            <td>${order.finalPrice}</td>
                        </tr>

                        <!-- Lấy danh sách hành khách của đơn hàng này -->
                        <c:set var="passengers" value="${passengersByOrder[order.id]}" />

                        <c:if test="${not empty passengers}">
                            <tr>
                                <td colspan="5">
                                    <table class="ticket-table">
                                        <tr class="passenger-header">
                                            <th colspan="5">Passengers</th>
                                        </tr>
                                        <c:forEach var="passenger" items="${passengers}">
                                            <tr>
                                                <td colspan="5"><strong>Passenger: ${passenger.name}</strong></td>
                                            </tr>

                                            <!-- Lấy danh sách vé của hành khách này -->
                                            <c:set var="tickets" value="${ticketsByPassenger[passenger.id]}" />

                                            <c:if test="${not empty tickets}">
                                                <tr>
                                                    <th>Ticket ID</th>
                                                    <th>Flight</th>
                                                    <th>Seat</th>
                                                    <th>Status</th>                                                  
                                                    <th>Actions</th>
                                                </tr>
                                                <c:forEach var="ticket" items="${tickets}">
                                                    <tr>
                                                        <td>${ticket.id}</td>
                                                        <td>${ticket.flight.id}</td>
                                                        <td>${ticket.seat.id}</td>
                                                        <td>${ticket.status}</td>                                                     
                                                        <td>
                                                            <a class="btn" href="${pageContext.request.contextPath}/historyBookingDetail?OrderPassengerID=${passenger.id}">View</a>
                                                            <c:if test="${ticket.status ne 'Cancelled' and ticket.status ne 'Pending' and ticket.status ne 'Processing' and ticket.status ne 'Rejected'}">
                                                                <a class="btn btn-secondary" href="#" onclick="confirmCancel('${passenger.id}')">Cancel</a>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:if>
                                        </c:forEach>
                                    </table>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </table>
            </c:if>
        </div>

        <a class="btn" href="${pageContext.request.contextPath}/view/Home.jsp">Back to Home</a>

        <!-- Form ẩn để gửi yêu cầu hủy vé -->
        <form id="cancelForm" method="POST" action="${pageContext.request.contextPath}/cancelTicket">
            <input type="hidden" name="OrderPassengerID" id="orderPassengerIdInput">
        </form>


        <script>
            function confirmCancel(orderPassengerId) {
                if (!orderPassengerId || orderPassengerId.trim() === '')
                    return;

                Swal.fire({
                    title: "Are you sure you want to cancel this ticket?",
                    text: "This action cannot be undone!",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#d33",
                    cancelButtonColor: "#3085d6",
                    confirmButtonText: "Yes, cancel now!",
                    cancelButtonText: "No"
                }).then((result) => {
                    if (result.isConfirmed) {
                        document.getElementById('orderPassengerIdInput').value = orderPassengerId;
                        document.getElementById('cancelForm').submit();
                    }
                });
            }

        </script>
    </body>

</html>
