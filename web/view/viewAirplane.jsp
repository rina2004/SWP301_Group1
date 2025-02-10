<%-- 
    Document   : viewAirplane.jsp
    Created on : 10 Feb 2025, 03:09:35
    Author     : Rinaaaa
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            .header-section {
                background: white;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
                padding: 1rem 0;
                margin-bottom: 2rem;
                position: sticky;
                top: 0;
                z-index: 1000;
            }
        </style>
    </head>
    <body>
        <div class="header-section">
            <div class="container">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="d-flex align-items-center">
                        <img src="/api/placeholder/40/40" alt="Logo" class="me-2" style="height: 40px;">
                        <h2 class="mb-0">Flight Management</h2>
                    </div>
                    <a href="create" class="btn btn-primary">
                        <i class="fas fa-plus me-2"></i>Add New Airplane
                    </a>
                </div>
            </div>
        </div>
        <table border="1px">
            <tr>
                <td>ID</td>
                <td>Name</td>
                <td>Type</td>
                <td>Status</td>
                <td>Maintenance Time</td>
                <td>Used Time</td>
                <td>ATC</td>
                <td>Action</td>
            </tr>
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
                        <a href="update?id=${pl.id}" class="btn btn-primary">
                            <i class="fas fa-edit"></i> Edit
                        </a>
                    </td>
                </tr> 
            </c:forEach>
        </table>
    </body>
</html>