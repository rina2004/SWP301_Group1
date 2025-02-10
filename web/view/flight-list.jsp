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
    <link rel="icon" type="image/png" href="assets/images/logo.png"> 
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
            font-size: 0.875rem;
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
    </style>
</head>
<body>
    <!-- Header Section -->
    <div class="header-section">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center">
                    <img src="/api/placeholder/40/40" alt="Logo" class="me-2" style="height: 40px;">
                    <h2 class="mb-0">Flight Management</h2>
                </div>
                <%--a href="create-flight" class="btn btn-primary">
                    <i class="fas fa-plus me-2"></i>Add New Flight
                </a--%>
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <a href="add-flight" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Add New Flight
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <!-- Search Section -->
        <div class="search-section">
            <div class="row">
                <div class="col">
                    <div class="search-box">
                        <i class="fas fa-search search-icon"></i>
                        <input type="text" class="form-control" placeholder="Search flights...">
                    </div>
                </div>
                <div class="col-auto">
                    <button class="btn btn-primary">Search Flight</button>
                </div>
            </div>
        </div> 
        <!-- Replace search section with filter -->
        <div class="search-section">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0">Filter</h5>
                <div class="btn-group">
                    <a href="filter-flights?priceRange=cheapest" class="btn btn-outline-primary">
                        Cheapest
                        <small class="d-block">Under ₹200</small>
                    </a>
                    <a href="filter-flights?priceRange=best" class="btn btn-outline-primary">
                        Best
                        <small class="d-block">₹200 - ₹1M</small>
                    </a>
                    <a href="filter-flights?priceRange=quickest" class="btn btn-outline-primary">
                        Quickest
                        <small class="d-block">Above ₹1M</small>
                    </a>
                </div>
            </div>
        </div>
        <!-- demo tu day  -->
        <div class="modal fade flight-details-modal" id="viewDetailsModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Flight Details</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="flight-info-details">
                            <!-- Flight info will be populated here -->
                        </div>
                        <div class="assigned-airplanes">
                            <h6>Assigned Airplanes</h6>
                            <div id="airplanesList">
                                <!-- Airplanes list will be populated here -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- toi day  -->
        <!-- Flights List -->
        <c:forEach items="${list}" var="flight">
            <div class="card flight-card">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <h5 class="card-title">${flight.getName()}</h5>
                        </div>
                        <div class="text-end">
                            <div class="price-display">₹12,000</div>
                            <small class="text-muted">Economy Class</small>
                        </div>
                    </div>

                    <div class="flight-info">
                        <div>
                            <div class="time-display">${flight.getStartingTime()}</div>
                            <div class="location-display">${flight.getDeparture()}</div>
                        </div>
                        <div class="duration-line">
                            <span class="duration-text">5h 40m</span>
                        </div>
                        <div>
                            <div class="time-display">${flight.getLandingTime()}</div>
                            <div class="location-display">${flight.getDestination()}</div>
                        </div>
                        <div class="action-buttons ms-3">
                            <a href="view-flight?id=${flight.getId()}" class="btn btn-light" title="View Details">
                                <i class="fas fa-eye text-primary"></i>
                            </a>
                             
                            <a href="update-flight?id=${flight.getId()}" class="btn btn-light" title="Edit">
                                <i class="fas fa-edit text-warning"></i>
                            </a>
                            <button class="btn btn-next ms-2">
                                Next <i class="fas fa-chevron-right ms-2"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

