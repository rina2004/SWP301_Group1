<%-- 
    Document   : flight-form
    Created on : 8 Feb 2025, 20:08:17
    Author     : A A
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Add New Flight</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link rel="icon" type="image/png" href="https://tomcat.apache.org/res/images/asf_logo.svg">
        <style>
            /* Style for select dropdowns with limited size */
            select.form-select-scrollable {
                max-height: 200px;
                overflow-y: auto;
            }
        </style>
    </head>
    <body>
        <div class="container mt-4">
            <div class="card">
                <div class="card-header">
                    <h3>${flight == null ? 'Add New Flight' : 'Edit Flight'}</h3>
                </div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">
                            ${error}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/view/add-flight" method="POST">
                        <c:if test="${flight != null}">
                            <input type="hidden" name="id" value="${flight.id}">
                        </c:if>
                            
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Flight Name</label>
                                <input type="text" class="form-control" name="name" 
                                       value="${flight.name}" required>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Airplane</label>
                                <select class="form-select" name="airplaneID" required>
                                    <option value="">Select Airplane</option>
                                    <c:forEach items="${airplanes}" var="airplane">
                                        <option value="${airplane.id}" 
                                                ${flight.airplaneID.id == airplane.id ? 'selected' : ''}>
                                            ${airplane.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Departure</label>
                                <select class="form-select form-select-scrollable" name="departure" required>
                                    <option value="">Select Departure Location</option>
                                    <c:forEach items="${locations}" var="location">
                                        <option value="${location.id}" 
                                                ${flight.departure.id == location.id ? 'selected' : ''}>
                                            ${location.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Destination</label>
                                <select class="form-select form-select-scrollable" name="destination" required>
                                    <option value="">Select Destination Location</option>
                                    <c:forEach items="${locations}" var="location">
                                        <option value="${location.id}" 
                                                ${flight.destination.id == location.id ? 'selected' : ''}>
                                            ${location.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-4">
                                <label class="form-label">Entry Time</label>
                                <input type="datetime-local" class="form-control" name="entryTime" 
                                       value="${flight.entryTime}" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Starting Time</label>
                                <input type="datetime-local" class="form-control" name="startingTime" 
                                       value="${flight.startingTime}" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Landing Time</label>
                                <input type="datetime-local" class="form-control" name="landingTime" 
                                       value="${flight.landingTime}" required>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between">
                            <a href="list-flight" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Back
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> ${flight == null ? 'Add Flight' : 'Update Flight'}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>