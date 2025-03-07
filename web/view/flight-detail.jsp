<%-- 
    Document   : flight-detail
    Created on : 8 Feb 2025, 20:05:41
    Author     : A A
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Flight Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link rel="icon" type="image/png" href="https://tomcat.apache.org/res/images/asf_logo.svg">
    </head>
    <body>
        <div class="container mt-4">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h3>Flight Details</h3>
                    <a href="list-flight" class="btn btn-primary">
                        <i class="fas fa-arrow-left"></i> Back to List
                    </a>
                </div>
                <div class="card-body">
                    <!-- Debug info -->
                    <c:if test="${flight == null}">
                        <div class="alert alert-danger">Flight object is null</div>
                    </c:if>
                    <c:if test="${flight != null}">
                        <div class="alert alert-info">Flight ID: ${flight.getId()}</div>
                    </c:if>
                    <div class="row">
                        <div class="col-md-6">
                            <h4>Basic Information</h4>
                            <table class="table table-borderless">
                                <tr>
                                    <th>Flight Name:</th>
                                    <td>${flight.getName()}</td>
                                </tr>
                                <tr>
                                    <th>Flight Code:</th>
                                    <td>${flight.getCode()}</td>
                                </tr>
                                <tr>
                                    <th>Airplane ID:</th>
                                    <td>${flight.getAirplaneId()}</td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-md-6">
                            <h4>Route Information</h4>
                            <table class="table table-borderless">
                                <tr>
                                    <th>Departure:</th>
                                    <td>${flight.getDeparture()}</td>
                                </tr>
                                <tr>
                                    <th>Destination:</th>
                                    <td>${flight.getDestination()}</td>
                                </tr>
                                
                                <tr>
                                    <th>Entry DateTime:</th>
                                    <td>
                                        <div class="date-display">${flight.getEntryDate()}</div>
                                        <div class="time-display">${flight.getEntryHour()}</div>
                                    </td>
                                </tr>
                               
                                <tr>
                                    <th>Starting DateTime:</th>
                                    <td>
                                        <div class="date-display">${flight.getStartingDate()}</div>
                                        <div class="time-display">${flight.getStartingHour()}</div>
                                    </td>
                                <tr>
                                    <th>Landing DateTime:</th>
                                    <td>
                                        <div class="date-display">${flight.getLandingDate()}</div>
                                        <div class="time-display">${flight.getLandingHour()}</div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
