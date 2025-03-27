<%-- 
    Document   : flight-list
    Created on : 8 Feb 2025, 18:24:09
    Author     : A A
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Flight Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link rel="icon" type="image/png" href="img/logo.jpg"> 
        <style>
            :root {
                --primary-color: #2563eb;
                --primary-hover: #1d4ed8;
                --light-bg: #f0f7ff;
                --text-muted: #6b7280;
                --border-color: #e5e7eb;
            }

            body {
                background: linear-gradient(to bottom, var(--light-bg) 0%, #ffffff 100%);
                min-height: 100vh;
            }

            /* Header styles */
            .header-section {
                background: white;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
                padding: 1rem 0;
                margin-bottom: 2rem;
                position: sticky;
                top: 0;
                z-index: 1000;
            }

            /* Card styles */
            .card {
                border: none;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
                transition: all 0.3s ease;
                margin-bottom: 1rem;
            }

            .card:hover {
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                transform: translateY(-2px);
            }

            .search-section, .filter-section {
                background: white;
                border-radius: 8px;
                padding: 1.5rem;
                margin-bottom: 1.5rem;
            }

            /* Flight card styling */
            .flight-card {
                padding: 1.5rem;
            }

            .flight-info {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-top: 1rem;
            }

            .date-display {
                font-size: 1.5rem;
                font-weight: bold;
                color: #333;
            }

            .time-display {
                font-size: 1.5rem;
                font-weight: 600;
                color: var(--primary-color);
            }

            .location-display {
                font-size: 0.875rem;
                color: var(--text-muted);
            }

            .duration-line {
                position: relative;
                height: 2px;
                background: var(--border-color);
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
                color: var(--text-muted);
                font-size: 0.875rem;
                font-weight: 500;
            }

            .price-display {
                font-size: 1.5rem;
                font-weight: bold;
                color: var(--primary-color);
            }

            /* Search box styling */
            .search-box {
                position: relative;
            }

            .search-box .form-control {
                padding-left: 2.5rem;
                height: 48px;
                border-radius: 8px;
            }

            .search-icon {
                position: absolute;
                left: 1rem;
                top: 50%;
                transform: translateY(-50%);
                color: var(--text-muted);
            }

            /* Button styling */
            .btn-primary {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
            }

            .btn-primary:hover {
                background-color: var(--primary-hover);
                border-color: var(--primary-hover);
            }

            .btn-outline-primary {
                color: var(--primary-color);
                border-color: var(--primary-color);
            }

            .btn-outline-primary:hover,
            .btn-outline-primary.active {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
                color: white;
            }

            .btn-filter {
                padding: 0.5rem 1rem;
                border-radius: 6px;
            }

            .action-buttons .btn {
                padding: 0.5rem;
                margin: 0 0.25rem;
                border-radius: 50%;
                width: 38px;
                height: 38px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                transition: all 0.2s ease;
            }

            .action-buttons .btn:hover {
                background-color: #f3f4f6;
            }

            /* Empty state styling */
            .no-flights {
                padding: 3rem;
                text-align: center;
                background: white;
                border-radius: 8px;
                margin-top: 2rem;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .flight-info {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .duration-line {
                    width: 100%;
                    margin: 1rem 0;
                }

                .action-buttons {
                    margin-top: 1rem;
                    align-self: flex-end;
                }

                .btn-group {
                    flex-direction: column;
                    width: 100%;
                }

                .btn-group .btn {
                    margin-bottom: 0.5rem;
                    border-radius: 0.375rem !important;
                }
            }
        </style>
    </head>
    <body>
        <!-- Header Section -->
        <div class="header-section">
            <div class="container">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="d-flex align-items-center">
                        <h2 class="mb-0">Flight Management</h2>
                    </div>
                    <a href="add-flight" class="btn btn-primary">
                        <i class="fas fa-plus me-2"></i> Add New Flight
                    </a>
                </div>
            </div>
        </div>

        <div class="container">
            <!-- Search Section -->
            <div class="search-section">
                <form action="search-flight" method="GET" class="mb-0">
                    <div class="row g-2 align-items-center">
                        <div class="col">
                            <div class="search-box">
                                <i class="fas fa-search search-icon"></i>
                                <input type="text" name="searchTerm" class="form-control" 
                                       placeholder="Search by flight name, departure, or destination..." 
                                       value="${searchTerm}">
                            </div>
                        </div>
                        <div class="col-auto">
                            <button type="submit" class="btn btn-primary">
                                Search Flight
                            </button>
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
            <div class="search-section filter-section">
                <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center">
                    <h5 class="mb-3 mb-md-0">Filter by Price</h5>
                    <div class="btn-group">
                        <a href="filter-flights?priceRange=cheapest" 
                           class="btn btn-outline-primary ${activeFilter eq 'cheapest' ? 'active' : ''}">
                            <span>Cheapest</span>
                            <small class="d-block mt-1">Under 200.000 VND</small>
                        </a>
                        <a href="filter-flights?priceRange=best" 
                           class="btn btn-outline-primary ${activeFilter eq 'best' ? 'active' : ''}">
                            <span>Best</span>
                            <small class="d-block mt-1">200.000 - 1.000.000 VND</small>
                        </a>
                        <a href="filter-flights?priceRange=quickest" 
                           class="btn btn-outline-primary ${activeFilter eq 'quickest' ? 'active' : ''}">
                            <span>Quickest</span>
                            <small class="d-block mt-1">Above 1.000.000 VND</small>
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
                        <p class="text-muted">Try adjusting your search criteria or filter selection.</p>
                        <a href="search-flight" class="btn btn-primary mt-3">View All Flights</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="flight-list">
                        <c:forEach items="${list}" var="flight">
                            <div class="card flight-card">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div>
                                            <h5 class="card-title mb-1">${flight.getName()}</h5>
                                            <span class="badge bg-light text-dark">
                                                <i class="fas fa-plane me-1"></i>
                                                Flight #${flight.getId()}
                                            </span>
                                        </div>
                                        <div class="text-end">
                                            <div class="h4 text-primary mb-0 fw-bold">${flight.getPrice()} VND</div>
                                            <small class="text-muted">${flight.getSeatType()}</small>
                                        </div>
                                        
                                    </div>

                                    <div class="flight-info mt-4">
                                        <div class="text-center">
                                            <div class="date-display">${flight.getStartingDate()}</div>
                                            <div class="time-display">${flight.getStartingHour()}</div>
                                            <div class="location-display">
                                                <i class="fas fa-plane-departure me-1"></i>
                                                <c:set var="departureLocation" value="${flight.getDeparture().getName()}" />
                                                <c:set var="departureCity" value="${fn:substringBefore(departureLocation, '-')}" />
                                                ${departureCity}
                                            </div>
                                        </div>

                                        <div class="duration-line">
                                            <span class="duration-text">
                                                <i class="fas fa-clock me-1"></i>
                                                ${flight.getDuration()}
                                            </span>
                                        </div>

                                        <div class="text-center">
                                            <div class="date-display">${flight.getLandingDate()}</div>
                                            <div class="time-display">${flight.getLandingHour()}</div>
                                            <div class="location-display">
                                                <i class="fas fa-plane-arrival me-1"></i>
                                                <c:set var="destinationLocation" value="${flight.getDestination().getName()}" />
                                                <c:set var="destinationCity" value="${fn:substringBefore(destinationLocation, '-')}" />
                                                ${destinationCity}
                                            </div>
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
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>