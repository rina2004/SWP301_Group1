<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Ticket"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
    <head>
        <title>Order Details</title>
        <style>
            body {
                font-family: 'Arial', sans-serif;
                background-color: #f0f2f5;
                padding: 20px;
                background-image: url('https://files.oaiusercontent.com/file-6Cvcrn7v5bPrBuncAEZZTp?...');
                background-repeat: no-repeat;
                background-size: cover;
                background-position: center;
            }
            h2 {
                color: #333;
                text-align: center;
                margin-bottom: 30px;
                font-size: 28px;
            }
            .ticket-container {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 25px;
            }
            .ticket-card {
                width: 480px;
                background: #fff;
                border-radius: 15px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                overflow: hidden;
                position: relative;
                transition: transform 0.3s ease;
            }
            .ticket-card:hover {
                transform: translateY(-5px);
            }
            .ticket-header {
                background-color: #007bff;
                color: #fff;
                padding: 20px;
                text-align: center;
                font-size: 20px;
                font-weight: bold;
                letter-spacing: 1px;
            }
            .ticket-body {
                padding: 20px;
                display: grid;
                grid-template-columns: 1fr 1fr;
                row-gap: 12px;
                column-gap: 10px;
                font-size: 16px;
            }
            .ticket-body div {
                color: #333;
            }
            .ticket-label {
                font-weight: bold;
                color: #555;
            }
            .ticket-footer {
                background: #f8f9fa;
                padding: 12px 20px;
                font-size: 14px;
                text-align: center;
                color: #666;
                border-top: 1px dashed #ccc;
            }
            .passenger-list {
                margin-top: 10px;
                padding: 10px;
                background: #f7f7f7;
                border-radius: 8px;
                grid-column: 1 / span 2;
            }
            .passenger-item {
                padding: 5px 0;
                border-bottom: 1px solid #ddd;
                font-size: 14px;
            }
            .passenger-item:last-child {
                border-bottom: none;
            }
            .btn {
                padding: 12px 25px;
                background-color: #28a745;
                color: #fff;
                text-decoration: none;
                border-radius: 5px;
                display: inline-block;
                margin-top: 30px;
                font-size: 16px;
            }
            .btn:hover {
                background-color: #218838;
            }
        </style>
    </head>
    <body>
        <h2>Order Details</h2>

        <c:if test="${empty tickets}">
            <p style="text-align: center; font-size: 18px;">No tickets found for this order.</p>
        </c:if>

        <c:if test="${not empty tickets}">
            <div class="ticket-container">
                <c:forEach var="ticket" items="${tickets}">
                    <div class="ticket-card">
                        <div class="ticket-header">
                            ✈️ Flight: ${ticket.flightCode} - ${ticket.flightName}
                        </div>
                        <div class="ticket-body">
                            <div class="ticket-label">From:</div>
                            <div>${ticket.departureName}</div>
                            <div class="ticket-label">To:</div>
                            <div>${ticket.destinationName}</div>
                            <div class="ticket-label">Start:</div>
                            <div>${ticket.startingTime}</div>
                            <div class="ticket-label">Landing:</div>
                            <div>${ticket.landingTime}</div>
                            <div class="ticket-label">Seat:</div>
                            <div>${ticket.seatCode} (${ticket.compartmentName})</div>
                            <div class="ticket-label">Type:</div>
                            <div>${ticket.ticketType.type}</div>
                            <div class="ticket-label">Price:</div>
                            <div>$${ticket.price}</div>
                            <div class="ticket-label">Status:</div>
                            <div>${ticket.status}</div>

                            <!-- NEW FIELDS (Lấy từ ticket.ticketType) -->
                            <c:if test="${not empty ticket.ticketType}">
                               
                                <div class="ticket-label">Hand Luggage:</div>
                                <div>${ticket.ticketType.handLuggageWeight} kg</div>
                                <div class="ticket-label">Checked Luggage:</div>
                                <div>${ticket.ticketType.checkedLuggageWeight} kg</div>
                                <div class="ticket-label">Luggage Quantity:</div>
                                <div>${ticket.ticketType.luggageQuantity}</div>
                                <div class="ticket-label">Services:</div>
                                <div>${ticket.ticketType.additionalServices}</div>
                            </c:if>

                            <div class="ticket-label">Airplane:</div>
                            <div>${ticket.airplaneName}</div>

                            <!-- Passengers -->
                            <c:if test="${not empty ticket.passengers}">
                                <div class="passenger-list">
                                    <strong>Passengers:</strong>
                                    <c:forEach var="p" items="${ticket.passengers}">
                                        <div class="passenger-item">
                                            ${p.fullName} (${p.nation.name})
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:if>
                        </div>

                        <div class="ticket-footer">
                            Ticket ID: ${ticket.id}
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>


        <div style="text-align: center;">
            <a class="btn" href="${pageContext.request.contextPath}/historyBooking">Back to Order History</a>
        </div>

    </body>
</html>
