<%-- 
    Document   : flight-list
    Created on : 8 Feb 2025, 18:24:09
    Author     : A A
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Flight Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="https://tomcat.apache.org/res/images/asf_logo.svg">
</head>
<body>
    <div class="container mt-4">
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${sessionScope.successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% session.removeAttribute("successMessage"); %>
        </c:if>

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Flight Management</h2>
            <a href="add-flight" class="btn btn-primary">
                <i class="fas fa-plus"></i> Add New Flight
            </a>
        </div>
        
        <table class="table table-striped table-hover">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Flight Name</th>
                    <th>Code</th>
                    <th>Departure</th>
                    <th>Destination</th>
                    <th>Starting Time</th>
                    <th>Landing Time</th>
                    <th>Status</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${list}" var="flight">
                    <tr>
                        <td>${flight.getId()}</td>
                        <td>${flight.getName()}</td>
                        <td>${flight.getCode()}</td>
                        <td>${flight.getDeparture()}</td>
                        <td>${flight.getDestination()}</td>
                        <td>${flight.getStartingTime()}</td>
                        <td>${flight.getLandingTime()}</td>
                        <td>
                            <span class="badge bg-success">Active</span>
                        </td>
                        <td>
                            <div class="btn-group" role="group">
                                <a href="view-flight?id=${flight.getId()}" class="btn btn-info btn-sm" title="View Details">
                                    <i class="fas fa-eye"></i>
                                </a>
                                <a href="update-flight?id=${flight.getId()}" class="btn btn-warning btn-sm" title="Edit">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <a href="#" onclick="confirmDelete('${flight.getId()}')" class="btn btn-danger btn-sm" title="Delete">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Confirm Delete</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    Are you sure you want to delete this flight?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <a href="#" id="deleteLink" class="btn btn-danger">Delete</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(id) {
            const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
            const deleteLink = document.getElementById('deleteLink');
            deleteLink.addEventListener('click', function(e) {
                e.preventDefault();
                window.location.href = 'delete-flight?id=' + id;
            });
            deleteModal.show();
        }
    </script>
</body>
</html>

