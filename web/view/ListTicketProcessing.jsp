<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Processing Orders</title>
        <link rel="stylesheet" href="styles.css"> <!-- Link CSS nếu có -->
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
            .btn-cancel {
                background-color: #dc3545;
            }
            .btn:hover {
                opacity: 0.8;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Processing Orders</h2>

            <c:if test="${not empty sessionScope.ticketUpdateMessage}">
                <div class="alert ${sessionScope.ticketUpdateMessageType eq 'success' ? 'alert-success' : 'alert-danger'}">
                    ${sessionScope.ticketUpdateMessage}
                </div>
                <c:remove var="ticketUpdateMessage" scope="session"/>
                <c:remove var="ticketUpdateMessageType" scope="session"/>
            </c:if>

            <c:choose>
                <c:when test="${not empty processingOrders}">
                    <table>
                        <tr>
                            <th>Ticket ID</th>
                            <th>Status</th>
                            <th>Flight ID</th>
                            <th>Seat ID</th> 
                            <th>Order passenger ID</th>
                            <th>Compartment ID</th>
                            <th>Actions</th>
                        </tr>
                        <c:forEach var="ticket" items="${processingOrders}">
                            <tr>
                                <td>${ticket.id}</td>
                                <td>${ticket.status}</td>
                                <td>${ticket.flight.id}</td>
                                <td>${ticket.seat.id}</td>
                                <td>${ticket.orderPassenger.id}</td>
                                <td>${ticket.compartment.id}</td>
                                <td>
                                    <c:if test="${ticket.status eq 'Processing'}">
                                        <form action="staffTicketProcessing" method="post">
                                            <input type="hidden" name="orderID" value="${ticket.orderPassenger.id}">
                                            <button type="submit" class="btn btn-cancel">Accept</button>
                                        </form>
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
        </div>
    </body>

</html>
