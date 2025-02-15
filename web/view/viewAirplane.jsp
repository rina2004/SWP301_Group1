<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Airplane List</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f9f9f9;
                margin: 0;
                padding: 0;
            }

            .header-section {
                background: #ffffff;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                padding: 1rem 2rem;
                position: sticky;
                top: 0;
                z-index: 1000;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .header-section .title {
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            .header-section h2 {
                font-size: 1.8rem;
                color: #0056b3;
                margin: 0;
            }

            .header-section .btn {
                padding: 0.8rem 1.5rem;
                font-size: 1rem;
                color: #ffffff;
                background-color: #0056b3;
                border: none;
                border-radius: 5px;
                text-decoration: none;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .header-section .btn:hover {
                background-color: #004494;
            }

            table {
                width: 90%;
                margin: 2rem auto;
                border-collapse: collapse;
                background: #ffffff;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                overflow: hidden;
            }

            table th, table td {
                padding: 1rem;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            table th {
                background-color: #0056b3;
                color: white;
                text-transform: uppercase;
                font-size: 0.9rem;
            }

            table tr:last-child td {
                border-bottom: none;
            }

            table tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            .btn-edit {
                padding: 0.5rem 1rem;
                font-size: 0.9rem;
                color: white;
                background-color: #28a745;
                border: none;
                border-radius: 5px;
                text-decoration: none;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .btn-edit:hover {
                background-color: #218838;
            }
        </style>
    </head>
    <body>
        <!-- Header Section -->
        <div class="header-section">
            <div class="title">
                <img src="/api/placeholder/40/40" alt="Logo" style="height: 40px;">
                <h2>Flight Management</h2>
            </div>
            <a href="create" class="btn">
                <i class="fas fa-plus"></i> Add New Airplane
            </a>
        </div>

        <!-- Airplane Table -->
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Type</th>
                    <th>Status</th>
                    <th>Maintenance Time</th>
                    <th>Used Time</th>
                    <th>ATC</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${requestScope.planes}" var="pl">
                    <tr>
                        <td>${pl.id}</td>
                        <td>${pl.name}</td>
                        <td>${pl.type.name}</td>
                        <td>${pl.status.name}</td>
                        <td>${pl.maintainanceTime}</td>
                        <td>${pl.usedTime}</td>
                        <td>${pl.atc.name}</td>
                        <td>
                            <a href="update?id=${pl.id}" class="btn-edit">
                                <i class="fas fa-edit"></i> Edit
                            </a>
                        </td>
                    </tr> 
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
