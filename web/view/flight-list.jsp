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
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link rel="icon" type="image/png" href="img/logo.jpg"> 
        <style>
            body {
                background: linear-gradient(to bottom, #f0f7ff 0%, #ffffff 100%);
                min-height: 100vh;
            }
            .card {
                border: none;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
                transition: box-shadow 0.3s ease;
                margin-bottom: 1rem;
            }
            .card:hover {
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            }
            .header-section {
                background: white;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
                padding: 1rem 0;
                margin-bottom: 2rem;
                position: sticky;
                top: 0;
                z-index: 1000;
            }
            .flight-details-modal .modal-dialog {
                max-width: 800px;
            }
            .assigned-airplanes {
                margin-top: 20px;
                border-top: 1px solid #dee2e6;
                padding-top: 20px;
            }

            .airplane-card {
                border: 1px solid #e5e7eb;
                border-radius: 8px;
                padding: 15px;
                margin-bottom: 10px;
            }

            .search-section {
                background: white;
                border-radius: 8px;
                padding: 1.5rem;
                margin-bottom: 2rem;
            }
            .flight-card {
                padding: 1.5rem;
            }
            .flight-info {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-top: 1rem;
            }
            .time-display {
                font-size: 1.5rem;
                font-weight: 600;
                color: #2563eb;
            }
            .location-display {
                font-size: 0.875rem;
                color: #6b7280;
            }
            .duration-line {
                position: relative;
                height: 2px;
                background: #e5e7eb;
                flex: 1;
                margin: 0 1rem;
            }
            .duration-text {
                position: absolute;
                top: -10px;
                left: 50%;
                transform: translateX(-50%);
                background: white;
                padding: 0 0.5rem;
                color: #6b7280;
                font-size: 1rem;
            }
            .action-buttons .btn {
                padding: 0.5rem;
                margin: 0 0.25rem;
                border-radius: 50%;
                width: 38px;
                height: 38px;
            }
            .btn-next {
                background-color: #2563eb;
                color: white;
                padding: 0.5rem 1rem;
                border-radius: 6px;
            }
            .btn-next:hover {
                background-color: #1d4ed8;
                color: white;
            }
            .price-display {
                font-size: 1.5rem;
                font-weight: bold;
                color: #2563eb;
            }
            .search-box {
                position: relative;
            }
            .search-box .form-control {
                padding-left: 2.5rem;
            }
            .search-icon {
                position: absolute;
                left: 1rem;
                top: 50%;
                transform: translateY(-50%);
                color: #6b7280;
            }
            .date-display {
                font-size: 2rem;
                font-weight: bold;
                color: #333;
            }

            .time-display {
                font-size: 1.7rem;
                color: #2563eb;
                margin-top: 3px;
            }
            
            .btn-filter.active {
                background-color: #2563eb;
                color: white;
            }
            
            .no-flights {
                padding: 2rem;
                text-align: center;
                background: white;
                border-radius: 8px;
                margin-top: 2rem;
            }
        </style>
    </head>
    <body>
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="alert alert-success text-center">
                ${sessionScope.successMessage}
            </div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>
        
        <!-- Header Section -->
        <div class="header-section">
            <div class="container">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="d-flex align-items-center">
                        <img src="img/logo.jpg" alt="Logo" class="me-2" style="height: 40px;">
                        <h2 class="mb-0">Flight Management</h2>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <a href="add-flight" class="btn btn-primary">
                            <i class="fas fa-plus me-2"></i> Add New Flight
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="container">
            <!-- Search Section -->
            <div class="search-section">
                <form action="search-flight" method="GET">
                    <div class="row">
                        <div class="col">
                            <div class="search-box">
                                <i class="fas fa-search search-icon"></i>
                                <input type="text" name="searchTerm" class="form-control" 
                                       placeholder="Search by flight name, departure, or destination..." 
                                       value="${searchTerm}">
                            </div>
                        </div>
                        <div class="col-auto">
                            <button type="submit" class="btn btn-primary">Search Flight</button>
                            <c:if test="${not empty searchTerm}">
                                <a href="search-flight" class="btn btn-outline-secondary ms-2">
                                    <i class="fas fa-times"></i> Clear
                                </a>
                            </c:if>
                        </div>
                    </div>
                </form>
            </div> 
            
            <!-- Filter Section -->
            <div class="search-section">
                <div class="d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Filter by Price</h5>
                    <div class="btn-group">
                        <a href="filter-flights?priceRange=cheapest" 
                           class="btn btn-outline-primary ${activeFilter eq 'cheapest' ? 'active' : ''}">
                            Cheapest
                            <small class="d-block">Under 200.000 VND</small>
                        </a>
                        <a href="filter-flights?priceRange=best" 
                           class="btn btn-outline-primary ${activeFilter eq 'best' ? 'active' : ''}">
                            Best
                            <small class="d-block">200.000 - 1.000.000 VND</small>
                        </a>
                        <a href="filter-flights?priceRange=quickest" 
                           class="btn btn-outline-primary ${activeFilter eq 'quickest' ? 'active' : ''}">
                            Quickest
                            <small class="d-block">Above 1.000.000 VND</small>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Flights List -->
            <c:choose>
                <c:when test="${empty list}">
                    <div class="no-flights">
                        <i class="fas fa-plane-slash fa-3x mb-3 text-muted"></i>
                        <h3>No flights found</h3>
                        <p class="mb-0">Try adjusting your search criteria or filter selection.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${list}" var="flight">
                        <div class="card flight-card">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start">
                                    <div>
                                        <h5 class="card-title">${flight.getName()}</h5>
                                    </div>
                                    <div class="text-end">
                                        <div class="price-display">
                                            <c:set var="ticket" value="${ticketMap[flight.getId()]}" />
                                            <fmt:formatNumber value="${ticket.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> VND
                                        </div>
                                        <small class="text-muted">${ticket.type}</small>
                                    </div>
                                </div>

                                <div class="flight-info">
                                    <div>
                                        <div class="date-display">${flight.getStartingDate()}</div>
                                        <div class="time-display">${flight.getStartingHour()}</div>
                                        <div class="location-display">${flight.getDeparture()}</div>
                                    </div>
                                    <div class="duration-line">
                                        <span class="duration-text">${flight.getDuration()}</span>
                                    </div>
                                    <div>
                                        <div class="date-display">${flight.getLandingDate()}</div>
                                        <div class="time-display">${flight.getLandingHour()}</div>
                                        <div class="location-display">${flight.getDestination()}</div>
                                    </div>

                                    <div class="action-buttons ms-2">
                                        <a href="view-flight?id=${flight.getId()}" class="btn btn-light" title="View Details">
                                            <i class="fas fa-eye text-primary"></i>
                                        </a>

                                        <a href="update-flight?id=${flight.getId()}" class="btn btn-light" title="Edit">
                                            <i class="fas fa-edit text-warning"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>