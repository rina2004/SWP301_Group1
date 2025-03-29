<%-- 
    Document   : ListOrderPassenger
    Created on : Mar 28, 2025, 3:19:31 AM
    Author     : tungn
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       <title>List Order Passenger</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 20px;
            }

            .table-container {
                max-width: 800px;
                margin: 0 auto;
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
            }

            th, td {
                padding: 10px;
                text-align: center;
                border: 1px solid #ddd;
            }

            th {
                background-color: #007bff;
                color: white;
                font-weight: bold;
            }

            tr:hover {
                background-color: #f1f1f1;
            }

            .btn {
                text-decoration: none;
                padding: 5px 10px;
                border-radius: 5px;
                color: white;
                font-weight: bold;
                display: inline-block;
                transition: 0.3s;
            }

            .btn-success {
                background-color: #28a745;
            }

            .btn-success:hover {
                background-color: #218838;
            }

            .btn-edit {
                background-color: #ffc107;
            }

            .btn-edit:hover {
                background-color: #e0a800;
            }

            .btn-back {
                background-color: #dc3545;
                padding: 8px 15px;
                display: block;
                width: 120px;
                text-align: center;
                margin-top: 15px;
            }

            .btn-back:hover {
                background-color: #c82333;
            }
        </style>
    </head>
    <body>
        <div class="table-container">
            <h2 style="text-align: center;">Order Passenger List</h2>
            <table>
                <tr>
                    <th>Order Passenger ID</th>
                    <th>Type ID</th>
                    <th>Full Name</th>
                    <th>Date of Birth</th>
                    <th>Nation</th>
                    <th>Action</th>
                </tr>
                <c:forEach var="l" items="${list}">
                    <tr>
                        <td>${l.id}</td>
                        <td>${l.passengerType.name}</td>
                        <td>${l.name}</td>
                        <td>${l.dob}</td>
                        <td>${l.nation.name}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/listTicketCheckIn?id=${l.id}" class="btn btn-success">List Ticket</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
             <button onclick="goBack()" class="btn btn-back">Go Back</button>
        </div>
        <script>
             function goBack() {
                window.history.back();  // Quay lại trang trước đó
            }
        </script>
            
    </body>
</html>