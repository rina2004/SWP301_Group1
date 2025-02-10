<%-- 
    Document   : updateAirplane
    Created on : 10 Feb 2025, 06:46:03
    Author     : Rinaaaa
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Airplane</title>
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
                    <h2 class="mb-0">Update Airplane</h2>
                    <a href="<%= request.getContextPath() %>/airplane/view" class="btn btn-secondary">
                        Back to List
                    </a>
                </div>
            </div>
        </div>
        
        <c:if test="${not empty error}">
            <div style="color: red">${error}</div>
        </c:if>
        
        <form action="<%= request.getContextPath() %>/airplane/update" method="POST">
            <input type="hidden" name="id" value="${airplane.id}">
            
            <div class="form-group">
                <label>ID: ${airplane.id}</label>
            </div>
            
            <div class="form-group">
                <label>Name: ${airplane.name}</label>
            </div>
            
            <div class="form-group">
                <label>Type: ${airplane.type.name}</label>
            </div>
            
            <div class="form-group">
                <label for="status">Status:</label>
                <select id="status" name="status" required>
                    <c:forEach items="${statuses}" var="s">
                        <option value="${s.id}" ${s.id == airplane.status.id ? 'selected' : ''}>
                            ${s.name}
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="form-group">
                <label for="maintainanceTime">Maintenance Time:</label>
                <input type="datetime-local" id="maintainanceTime" 
                       name="maintainanceTime" 
                       value="${airplane.maintainanceTime}" required>
            </div>
            
            <button type="submit" class="btn btn-primary">Update Airplane</button>
        </form>
    </body>
</html>