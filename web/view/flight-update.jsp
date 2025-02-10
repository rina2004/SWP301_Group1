<%-- 
    Document   : flight-update.jsp
    Created on : 9 Feb 2025, 02:45:19
    Author     : A A
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Flight</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="https://tomcat.apache.org/res/images/asf_logo.svg">
</head>
<body>
    <div class="container mt-4">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h3>Update Flight</h3>
                <a href="list-flight" class="btn btn-primary">
                    <i class="fas fa-arrow-left"></i> Back to List
                </a>
            </div>
            <div class="card-body">
                <form action="update-flight" method="POST">
                    <input type="hidden" name="id" value="${flight.getId()}">
                    
                    <div class="row">
                        <div class="col-md-6">
                            <h4>Basic Information</h4>
                            <div class="mb-3">
                                <label for="name" class="form-label">Flight Name</label>
                                <input readonly type="text" class="form-control" id="name" name="name" 
                                       value="${flight.getName()}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="code" class="form-label">Flight Code</label>
                                <input readonly type="text" class="form-control" id="code" name="code" 
                                       value="${flight.getCode()}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="airplaneId" class="form-label">Airplane ID</label>
                                <input readonly type="text" class="form-control" id="airplaneId" name="airplaneId" 
                                       value="${flight.getAirplaneId()}" required>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <h4>Route Information</h4>
                            <div class="mb-3">
                                <label for="departure" class="form-label">Departure</label>
                                <input type="text" class="form-control" id="departure" name="departure" 
                                       value="${flight.getDeparture()}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="destination" class="form-label">Destination</label>
                                <input type="text" class="form-control" id="destination" name="destination" 
                                       value="${flight.getDestination()}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="entryTime" class="form-label">Entry Date</label>
                                <input type="date" class="form-control" id="entryTime" name="entryTime" 
                                       value="${flight.getEntryTime()}" required>
                            </div>

                            <div class="mb-3">
                                <label for="startingTime" class="form-label">Starting Date</label>
                                <input type="date" class="form-control" id="startingTime" name="startingTime" 
                                       value="${flight.getStartingTime()}" required>
                            </div>

                            <div class="mb-3">
                                <label for="landingTime" class="form-label">Landing Date</label>
                                <input type="date" class="form-control" id="landingTime" name="landingTime" 
                                       value="${flight.getLandingTime()}" required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="text-center mt-4">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Update Flight
                        </button>
                        <a href="list-flight" class="btn btn-secondary ms-2">
                            <i class="fas fa-times"></i> Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
