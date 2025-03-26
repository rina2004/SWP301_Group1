<%-- 
    Document   : ListLuggage
    Created on : Mar 24, 2025, 8:13:56 PM
    Author     : tungn
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Luggage</title>
        <style>
            /* Căn giữa nội dung */
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }

            /* Khung chứa bảng */
            .container {
                width: 80%;
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            }

            h2 {
                text-align: center;
                color: #333;
                margin-bottom: 20px;
            }

            /* Bảng */
            table {
                width: 100%;
                border-collapse: collapse;
                text-align: center;
            }

            /* Header */
            th {
                background-color: #28a745;
                color: white;
                padding: 12px;
                font-size: 16px;
                border: 1px solid #ddd;
            }

            /* Dòng dữ liệu */
            td {
                padding: 10px;
                border: 1px solid #ddd;
                font-size: 14px;
                background: #fff;
            }

            /* Hiệu ứng hover */
            tr:hover {
                background-color: #f1f1f1;
                transition: 0.2s ease-in-out;
            }

            /* Căn giữa nội dung trong bảng */
            td, th {
                text-align: center;
            }

            /* Responsive cho màn hình nhỏ */
            @media (max-width: 768px) {
                .container {
                    width: 100%;
                }

                table {
                    font-size: 12px;
                }

                th, td {
                    padding: 8px;
                }
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h2>Danh Sách Hành Lý</h2>
            <table>
                <tr>
                    <th>Luggage ID</th>
                    <th>Account ID</th>
                    <th>Ticket ID</th>
                    <th>Type</th>
                    <th>Weight</th>
                    <th>Price</th>
                </tr>
                <c:forEach var="list" items="${list}">
                    <tr>
                        <td>${list.id}</td>
                        <td>${list.acc.id}</td>
                        <td>${list.ticket.id}</td>
                        <td>${list.type}</td>
                        <td>${list.weight} kg</td>
                        <td>${list.price} VNĐ</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </body>
</html>
