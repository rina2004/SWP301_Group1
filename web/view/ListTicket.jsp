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

            /* Căn giữa nội dung */
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }

            /* Khung chứa bảng */
            .container {
                width: 90%;
                max-width: 1000px;
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

            /* Tiêu đề */
            th {
                background-color: #007bff;
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

            /* Dòng xen kẽ */
            tr:nth-child(even) {
                background: #f9f9f9;
            }

            /* Hiệu ứng hover */
            tr:hover {
                background-color: #e9ecef;
                transition: 0.2s ease-in-out;
            }

            /* Nút hành động */
            .btn {
                display: inline-block;
                padding: 8px 12px;
                background: #28a745;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                font-size: 14px;
                transition: 0.3s;
            }

            .btn:hover {
                background: #218838;
            }

            /* Responsive cho màn hình nhỏ */
            @media (max-width: 768px) {
                .container {
                    width: 100%;
                    padding: 15px;
                }

                table {
                    font-size: 12px;
                }

                th, td {
                    padding: 8px;
                }

                .btn {
                    padding: 6px 10px;
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
                            <c:if test="${l.status != 'Checked'}">
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
