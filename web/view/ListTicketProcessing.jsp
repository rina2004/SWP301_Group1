<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Processing Orders</title>
        <link rel="stylesheet" href="styles.css"> <!-- Link CSS nếu có -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script> <!-- SweetAlert2 -->
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 20px;
                padding: 0;
            }
            .container {
                width: 80%;
                margin: auto;
                background: white;
                padding: 20px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
            }
            h2 {
                text-align: center;
                color: #333;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            table, th, td {
                border: 1px solid #ddd;
            }
            th, td {
                padding: 10px;
                text-align: center;
            }
            th {
                background-color: #007bff;
                color: white;
            }
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            .btn {
                padding: 8px 12px;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                display: inline-block;
                border: none;
                cursor: pointer;
            }
            .btn-accept {
                background-color: #28a745; /* Xanh lá */
            }
            .btn-reject {
                background-color: #dc3545; /* Đỏ */
            }
            .btn:hover {
                opacity: 0.8;
            }
            .cancelled {
                color: gray;
                font-weight: bold;
            }
            .rejected {
                color: red;
                font-weight: bold;
            }
        </style>
        <script>
            function confirmReject(orderPassengerId) {
                if (!orderPassengerId || orderPassengerId.trim() === '') return;

                Swal.fire({
                    title: "Are you sure you want to reject this order?",
                    text: "This action cannot be undone!",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#d33",
                    cancelButtonColor: "#3085d6",
                    confirmButtonText: "Yes, reject now!",
                    cancelButtonText: "No"
                }).then((result) => {
                    if (result.isConfirmed) {
                        document.getElementById('orderPassengerIdRejectInput').value = orderPassengerId;
                        document.getElementById('rejectForm').submit();
                    }
                });
            }

            function confirmAccept(orderPassengerId) {
                if (!orderPassengerId || orderPassengerId.trim() === '') return;

                Swal.fire({
                    title: "Are you sure you want to accept this order?",
                    text: "This will change status to 'Cancelled'!",
                    icon: "success",
                    showCancelButton: true,
                    confirmButtonColor: "#28a745",
                    cancelButtonColor: "#3085d6",
                    confirmButtonText: "Yes, accept now!",
                    cancelButtonText: "No"
                }).then((result) => {
                    if (result.isConfirmed) {
                        document.getElementById('orderPassengerIdAcceptInput').value = orderPassengerId;
                        document.getElementById('acceptForm').submit();
                    }
                });
            }
        </script>
    </head>
    <body>
        <div class="container">
            <h2>Processing Orders</h2>

            <c:choose>
                <c:when test="${not empty processingOrders}">
                    <table>
                        <tr>
                            <th>Ticket ID</th>
                            <th>Status</th>
                            <th>Flight ID</th>
                            <th>Seat ID</th> 
                            <th>Order Passenger ID</th>
                            <th>Compartment ID</th>
                            <th>Actions</th>
                        </tr>
                        <c:forEach var="ticket" items="${processingOrders}">
                            <tr>
                                <td>${ticket.id}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${ticket.status eq 'Cancelled'}">
                                            <span class="cancelled">Cancelled</span>
                                        </c:when>
                                        <c:when test="${ticket.status eq 'Rejected'}">
                                            <span class="rejected">Rejected</span>
                                        </c:when>
                                        <c:otherwise>
                                            ${ticket.status}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${ticket.flight.id}</td>
                                <td>${ticket.seat.id}</td>
                                <td>${ticket.orderP.id}</td>
                                <td>${ticket.compartment.id}</td>
                                <td>
                                    <c:if test="${ticket.status eq 'Processing'}">
                                        <!-- Accept Button with SweetAlert2 -->
                                        <button type="button" class="btn btn-accept" onclick="confirmAccept('${ticket.orderP.id}')">
                                            Accept
                                        </button>

                                        <!-- Reject Button with SweetAlert2 -->
                                        <button type="button" class="btn btn-reject" onclick="confirmReject('${ticket.orderP.id}')">
                                            Reject
                                        </button>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:when>
                <c:otherwise>
                    <p style="text-align: center; color: red;">No processing orders found.</p>
                </c:otherwise>
            </c:choose>

            <a class="btn" href="${pageContext.request.contextPath}/view/Home.jsp">Back to Home</a>

            <!-- Hidden Accept Form -->
            <form id="acceptForm" action="staffTicketProcessing" method="post" style="display: none;">
                <input type="hidden" id="orderPassengerIdAcceptInput" name="orderID">
                <input type="hidden" name="action" value="accept">
            </form>

            <!-- Hidden Reject Form -->
            <form id="rejectForm" action="staffTicketProcessing" method="post" style="display: none;">
                <input type="hidden" id="orderPassengerIdRejectInput" name="orderID">
                <input type="hidden" name="action" value="reject">
            </form>
        </div>
    </body>
</html>
