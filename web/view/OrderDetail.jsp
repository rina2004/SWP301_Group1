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
                background-image: url('https://files.oaiusercontent.com/file-6Cvcrn7v5bPrBuncAEZZTp?se=2025-03-24T09%3A58%3A48Z&sp=r&sv=2024-08-04&sr=b&rscc=max-age%3D604800%2C%20immutable%2C%20private&rscd=attachment%3B%20filename%3D234a0dac-7eb7-4932-8c8e-4a045fd4d52b.webp&sig=MBH%2BlRf%2BnEf/WqvWP0F4yW8JFEmxbPkgEOZTAEzxDMY%3D');
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
                width: 450px;
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
                            <div>${ticket.type}</div>
                            <div class="ticket-label">Price:</div>
                            <div>$${ticket.price}</div>
                            <div class="ticket-label">Status:</div>
                            <div>${ticket.status}</div>
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
