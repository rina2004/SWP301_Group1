<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Airplane</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../js/createAirplane.js"></script>
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4">Create Airplane</h2>
        
        <form action="<%= request.getContextPath() %>/airplane/create" method="POST" id="airplaneForm">
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="id" class="form-label">Airplane No.</label>
                    <input type="text" class="form-control" id="id" name="id" required>
                </div>
                <div class="col-md-6">
                    <label for="name" class="form-label">Name</label>
                    <input type="text" class="form-control" id="name" name="name" required>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-4">
                    <label for="statusId" class="form-label">Status</label>
                    <select class="form-select" id="statusId" name="statusId" required>
                        <c:forEach items="${requestScope.statuses}" var="status">
                            <option value="${status.id}">${status.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <label for="numOfComs" class="form-label">Number of Compartments</label>
                    <input type="number" class="form-control" id="numOfComs" name="numOfComs" 
                           min="1" max="10" value="1" required onchange="updateCompartments()">
                </div>
                <div class="col-md-4">
                    <label for="maintainanceTime" class="form-label">Maintenance Time</label>
                    <input type="datetime-local" class="form-control" id="maintainanceTime" name="maintainanceTime">
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="usedTime" class="form-label">Created Time</label>
                    <input type="datetime-local" class="form-control" id="usedTime" name="usedTime" required>
                </div>
            </div>

            <div id="compartmentsContainer">
                
            </div>

            <button type="submit" class="btn btn-primary">Tạo Máy Bay</button>
        </form>
    </div>
</body>
</html>