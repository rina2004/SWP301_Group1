<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Processing Orders</title>
        <link rel="stylesheet" href="styles.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
                background-color: #28a745;
            }
            .btn-reject {
                background-color: #dc3545;
            }
            .btn:hover {
                opacity: 0.8;
            }
            .pagination {
                margin-top: 20px;
                text-align: center;
            }
            .pagination a {
                margin: 0 5px;
                padding: 8px 12px;
                text-decoration: none;
                color: white;
                background-color: #007bff;
                border-radius: 5px;
            }
            .pagination a.disabled {
                background-color: #ccc;
                pointer-events: none;

                .btn-search, .btn-reset {
                    padding: 8px 15px;
                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                    font-size: 14px;
                }

                .btn-search {
                    background-color: #007bff;
                    color: white;
                }

                .btn-reset {
                    background-color: #dc3545;
                    color: white;
                }

                .btn-search:hover, .btn-reset:hover {
                    opacity: 0.8;
                }

            }
        </style>
        <script>
            function confirmReject(orderPassengerId) {
                if (!orderPassengerId || orderPassengerId.trim() === '')
                    return;
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
                if (!orderPassengerId || orderPassengerId.trim() === '')
                    return;
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
            <form action="staffTicketProcessing" method="get" style="display: flex; gap: 10px; align-items: center;">
                <input type="text" name="search" placeholder="Enter OrderPassenger ID" value="${search}" style="padding: 8px; border: 1px solid #ccc; border-radius: 5px;">
                <button type="submit" class="btn-search">Search</button>
                <button type="button" class="btn-reset" onclick="window.location.href = 'staffTicketProcessing'">Reset</button>
            </form>



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
                                        <button type="button" class="btn btn-accept" onclick="confirmAccept('${ticket.orderP.id}')">
                                            Accept
                                        </button>
                                        <button type="button" class="btn btn-reject" onclick="confirmReject('${ticket.orderP.id}')">
                                            Reject
                                        </button>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>

                    <!-- Pagination -->
                    <div class="pagination">
                        <c:if test="${currentPage > 1}">
                            <a href="staffTicketProcessing?page=${currentPage - 1}">Previous</a>
                        </c:if>

                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <a href="staffTicketProcessing?page=${i}" 
                               class="${i == currentPage ? 'disabled' : ''}">
                                ${i}
                            </a>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages}">
                            <a href="staffTicketProcessing?page=${currentPage + 1}">Next</a>
                        </c:if>
                    </div>
                </c:when>
                <c:otherwise>
                    <p style="text-align: center; color: red;">No processing orders found.</p>
                </c:otherwise>
            </c:choose>

            <a class="btn" href="${pageContext.request.contextPath}/view/Home.jsp">Back to Home</a>




            <form id="acceptForm" action="staffTicketProcessing" method="post" style="display: none;">
                <input type="hidden" id="orderPassengerIdAcceptInput" name="orderID">
                <input type="hidden" name="action" value="accept">
            </form>

            <form id="rejectForm" action="staffTicketProcessing" method="post" style="display: none;">
                <input type="hidden" id="orderPassengerIdRejectInput" name="orderID">
                <input type="hidden" name="action" value="reject">
            </form>
        </div>
    </body>
</html>
