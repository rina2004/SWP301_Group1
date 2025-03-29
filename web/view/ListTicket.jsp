<%-- 
    Document   : ListTicket
    Created on : Mar 24, 2025, 2:00:30 PM
    Author     : tungn
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Ticket</title>
        <style>
            /* Reset CSS */
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                font-family: Arial, sans-serif;
                background-color: #f0f2f5;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                padding: 20px;
            }

            .container {
                width: 90%;
                max-width: 1000px;
                background: white;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.15);
                text-align: center;
            }

            h2 {
                color: #007bff;
                font-size: 24px;
                margin-bottom: 20px;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
            }

            th, td {
                padding: 12px;
                border: 1px solid #ddd;
                font-size: 14px;
            }

            th {
                background-color: #007bff;
                color: white;
                font-size: 16px;
            }

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            tr:hover {
                background-color: #e0f7fa;
                transition: 0.3s;
            }

            .btn {
                display: inline-block;
                padding: 10px 14px;
                background: #28a745;
                color: white;
                text-decoration: none;
                border-radius: 6px;
                font-size: 14px;
                transition: 0.3s;
                font-weight: bold;
            }

            .btn:hover {
                background: #218838;
                transform: scale(1.05);
            }

            @media (max-width: 768px) {
                table {
                    font-size: 12px;
                }
                th, td {
                    padding: 8px;
                }
                .btn {
                    padding: 8px 12px;
                    font-size: 12px;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Danh Sách Vé</h2>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Flight ID</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                <c:forEach var="l" items="${list}">
                    <tr>
                        <td>${l.id}</td>
                        <td>${l.flight.id}</td>
                        <td>${l.status}</td>
                        <td>
                            <c:if test="${l.status == 'Confirmed'}">
                                <a href="<%= request.getContextPath() %>/listSeatsUser?id=${l.flight.airplane.id}&ticketId=${l.id}" class="btn">
                                    Check - in
                                </a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </body>
</html>
</html>
