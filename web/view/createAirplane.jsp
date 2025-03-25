<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tạo Máy Bay Mới</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../js/createAirplane.js"></script>
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4">Tạo Máy Bay Mới</h2>
        
        <form action="<%= request.getContextPath() %>/airplane/create" method="POST" id="airplaneForm">
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="airId" class="form-label">Mã Máy Bay</label>
                    <input type="text" class="form-control" id="airId" name="airId" required>
                </div>
                <div class="col-md-6">
                    <label for="airName" class="form-label">Tên Máy Bay</label>
                    <input type="text" class="form-control" id="airName" name="airName" required>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-4">
                    <label for="airStatusID" class="form-label">Trạng Thái Máy Bay</label>
                    <select class="form-select" id="airStatusID" name="airStatusID" required>
                        <c:forEach items="${requestScope.statuses}" var="status">
                            <option value="${status.id}">${status.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <label for="numOfComs" class="form-label">Số Khoang</label>
                    <input type="number" class="form-control" id="numOfComs" name="numOfComs" 
                           min="1" max="10" value="1" required onchange="updateCompartments()">
                </div>
                <div class="col-md-4">
                    <label for="maintainanceTime" class="form-label">Thời Gian Bảo Dưỡng</label>
                    <input type="datetime-local" class="form-control" id="maintainanceTime" name="maintainanceTime">
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="usedTime" class="form-label">Thời Gian Sử Dụng</label>
                    <input type="datetime-local" class="form-control" id="usedTime" name="usedTime" required>
                </div>
            </div>

            <div id="compartmentsContainer">
                <!-- Các khoang sẽ được động thêm vào đây -->
            </div>

            <button type="submit" class="btn btn-primary">Tạo Máy Bay</button>
        </form>
    </div>
</body>
</html>