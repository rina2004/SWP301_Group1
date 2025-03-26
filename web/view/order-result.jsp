<%-- 
    Document   : order-result
    Created on : 3 Mar 2025, 09:45:09
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
    </head>
    <body>
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="alert alert-success text-center">
                ${sessionScope.successMessage}
            </div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>
        <div class="header-section">
            <div class="container">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="d-flex align-items-center">
                        <h2 class="mb-0">Flight Booking</h2>
                    </div>
                    <div>
                        <a href="order-cart.jsp" class="btn btn-outline-primary position-relative">
                            <i class="fas fa-shopping-cart"></i> Cart
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger cart-count">
                                0
                            </span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="search-section">
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="d-flex align-items-center">
                            <h5 class="mb-0 me-3">Search Results</h5>
                            <div class="badge bg-primary p-2">
                                <i class="fas fa-map-marker-alt me-1"></i> ${departure} → ${destination}
                            </div>
                            <div class="badge bg-secondary p-2 ms-2">
                                <i class="fas fa-calendar me-1"></i> ${departureDate}
                            </div>
                        </div>
                    </div>
                </div>
                <form action="order" method="GET">
                    <div class="row">
                        <div class="col-md-4 mb-2">
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-plane-departure"></i></span>
                                <input type="text" name="departure" class="form-control" 
                                       placeholder="From" value="${departure}" required>
                            </div>
                        </div>
                        <div class="col-md-4 mb-2">
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-plane-arrival"></i></span>
                                <input type="text" name="destination" class="form-control" 
                                       placeholder="To" value="${destination}" required>
                            </div>
                        </div>
                        <div class="col-md-2 mb-2">
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                                <input type="date" name="departureDate" class="form-control" 
                                       value="${departureDate}" required>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-search me-2"></i> Search
                            </button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="search-section">
                <div class="d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Filter by Type</h5>
                    <div class="btn-group">
                        <a href="order-filter?priceRange=cheapest&departure=${departure}&destination=${destination}&departureDate=${departureDate}" 
                           class="btn btn-outline-primary ${activeFilter eq 'cheapest' ? 'active' : ''}">Business
                        </a>
                        <a href="order-filter?priceRange=best&departure=${departure}&destination=${destination}&departureDate=${departureDate}" 
                           class="btn btn-outline-primary ${activeFilter eq 'best' ? 'active' : ''}">Economy
                        </a>
                        <a href="order-filter?priceRange=quickest&departure=${departure}&destination=${destination}&departureDate=${departureDate}" 
                           class="btn btn-outline-primary ${activeFilter eq 'quickest' ? 'active' : ''}">First Class
                        </a>
                    </div>
                </div>
            </div>
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
                                            <fmt:formatNumber value="${ticket.seat.compartment.type.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> VND
                                        </div>
                                        <small class="text-muted">${ticket.seat.compartment.type.type}</small>
                                    </div>
                                </div>
                                <div class="flight-info">
                                    <div>
                                        <div class="date-display">${flight.getStartingDate()}</div>
                                        <div class="time-display">${flight.getStartingHour()}</div>
                                        <div class="location-display">${flight.getDeparture().getName()}</div>
                                    </div>
                                    <div class="duration-line">
                                        <span class="duration-text">${flight.getDuration()}</span>
                                    </div>
                                    <div>
                                        <div class="date-display">${flight.getLandingDate()}</div>
                                        <div class="time-display">${flight.getLandingHour()}</div>
                                        <div class="location-display">${flight.getDestination().getName()}</div>
                                    </div>
                                    <div class="action-buttons ms-3">
                                        <a href="order-detail?id=${flight.getId()}&departure=${departure}&destination=${destination}&departureDate=${departureDate}" class="btn btn-light" title="View Details">
                                            <i class="fas fa-eye text-primary"></i>
                                        </a>
                                        <button onclick="addToCart('${flight.getId()}', '${flight.getName()}', '${ticket.price}', '${ticket.type}')" class="btn btn-light" title="Add to Cart">
                                            <i class="fas fa-plus text-success"></i>
                                        </button>
                                        <br><br>
                                        <a href="order-confirm?flightId=${flight.getId()}&ticketClass=${ticket.type}&passengers=1" 
                                           class="btn btn-primary rounded-3 px-4 py-2 w-100" title="Đặt vé ngay">
                                            Đặt vé ngay
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