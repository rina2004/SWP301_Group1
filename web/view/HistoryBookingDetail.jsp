<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Ticket"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<html>
    <head>
        <title>History Booking Detail</title>
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

        <c:if test="${empty ticketList}">
            <p style="text-align: center; font-size: 18px;">No tickets found for this order.</p>
        </c:if>

        <c:if test="${not empty ticketList}">
            <div class="ticket-container">
                <c:forEach var="ticket" items="${ticketList}">
                    <div class="ticket-card">
                        <div class="ticket-header">
                            ✈️ Flight: ${ticket.flight.code} - ${ticket.flight.name}
                        </div>
                        <div class="ticket-body">
                            <div class="ticket-label">From:</div>
                            <div>${ticket.flight.departure.name}</div>
                            <div class="ticket-label">To:</div>
                            <div>${ticket.flight.destination.name}</div>
                            <div class="ticket-label">Starting time:</div>
                            <div>${ticket.flight.startingTime}</div>
                            <div class="ticket-label">Landing time:</div>
                            <div>${ticket.flight.landingTime}</div>
                            <div class="ticket-label">Price:</div>
                            <div id="ticket-price" data-price="${ticket.flight.price}"></div>                            <div class="ticket-label">Seat:</div>
                            <div>${ticket.seat.id}</div>
                            <div class="ticket-label">Ticket Status:</div>
                            <div>${ticket.status}</div>

                            <div class="ticket-label">Ticket type:</div>
                            <div>${ticket.orderP.order.tt.type}</div>
                            <div class="ticket-label">Ticket checked weight:</div>
                            <div>${ticket.orderP.order.tt.checkedweightneed}kg</div>
                            <div class="ticket-label">Ticket handed weight:</div>
                            <div>${ticket.orderP.order.tt.handedweightneed}kg</div>

                            <div class="ticket-label">Airplane:</div>
                            <div>${ticket.flight.airplane.name}</div>


                        </div>

                        <div class="ticket-footer">
                            Ticket ID: ${ticket.id}
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                let priceElement = document.getElementById("ticket-price");
                let price = parseFloat(priceElement.getAttribute("data-price")) || 0;
                priceElement.innerText = price.toLocaleString("vi-VN", {
                    style: "currency",
                    currency: "VND",
                    minimumFractionDigits: 0,
                    maximumFractionDigits: 0
                });
            });
        </script>


        <div style="text-align: center;">
            <a class="btn" href="${pageContext.request.contextPath}/historyBooking">Back to Order History</a>
        </div>

    </body>
</html>
