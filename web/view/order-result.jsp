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
            .toast-notification {
                position: fixed;
                bottom: 20px;
                right: 20px;
                background-color: #28a745;
                color: white;
                padding: 15px 25px;
                border-radius: 4px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                transform: translateY(100px);
                opacity: 0;
                transition: all 0.3s ease;
                z-index: 9999;
            }
            .toast-notification.show {
                transform: translateY(0);
                opacity: 1;
            }
            .toast-content {
                display: flex;
                align-items: center;
            }
            .cart-count {
                font-size: 0.65rem;
                transform: translate(-50%, -50%) !important;
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
        <div class="header-section">
            <div class="container">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="d-flex align-items-center">
                        <h2 class="mb-0">Sky Airline</h2>
                    </div>
                    <div>
                        <c:if test="${empty user}">
                            <a href="Login.jsp" class="btn btn-outline-primary me-2">Sign In</a>
                            <a href="register" class="btn btn-primary">Register</a>
                        </c:if>
                        <c:if test="${not empty user}">
                            <div class="d-flex align-items-center">
                                <p class="me-3 mb-0">
                                    <i class="fas fa-user me-2"></i>${sessionScope.user}
                                </p>
                                <form action="${pageContext.request.contextPath}/logout" method="get" class="mb-0">
                                    <button type="submit" class="btn btn-secondary">Logout</button>
                                </form>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <c:if test="${not empty sessionScope.successMessage}">
            <div class="alert alert-success text-center">
                ${sessionScope.successMessage}
            </div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>
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
                    <div class="passenger-details mb-3">
                        <div class="d-flex justify-content-start align-items-center">
                            <div class="badge bg-info p-2 me-2">
                                <i class="fas fa-users me-1"></i> 
                                Total Passengers: ${passengers}
                            </div>
                            <c:if test="${not empty param.adult and param.adult ne '0'}">
                                <div class="badge bg-light text-dark p-2 me-2">
                                    <i class="fas fa-user me-1"></i> 
                                    Adults: ${param.adult}
                                </div>
                            </c:if>
                            <c:if test="${not empty param.child and param.child ne '0'}">
                                <div class="badge bg-light text-dark p-2 me-2">
                                    <i class="fas fa-child me-1"></i> 
                                    Children: ${param.child}
                                </div>
                            </c:if>
                            <c:if test="${not empty param.baby and param.baby ne '0'}">
                                <div class="badge bg-light text-dark p-2">
                                    <i class="fas fa-baby me-1"></i> 
                                    Babies: ${param.baby}
                                </div>
                            </c:if>
                        </div>
                    </div>
                    <div class="btn-group">
                        <div class="dropdown">
                            <button class="btn btn-outline-primary dropdown-toggle" type="button" id="sortPriceDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-sort me-2"></i> Sort by Price
                            </button>
                            <ul class="dropdown-menu sort-dropdown" aria-labelledby="sortPriceDropdown">
                                <li>
                                    <a class="dropdown-item" href="order-filter?departure=${departure}&destination=${destination}&departureDate=${departureDate}&order=asc">
                                        <i class="fas fa-arrow-up me-2"></i>Ascending (Price)
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="order-filter?departure=${departure}&destination=${destination}&departureDate=${departureDate}&order=desc">
                                        <i class="fas fa-arrow-down me-2"></i>Descending (Price)
                                    </a>
                                </li>
                            </ul>
                        </div>
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
                                        <%--p class="text-muted">
                                            <i class="fas fa-chair me-2"></i>${flight.getCompartmentTypeName()} Seat
                                        </p--%>
                                    </div>
                                    <div class="flight-price">
                                        <h4 class="text-primary">
                                            <fmt:formatNumber value="${flight.getPrice()}"/> VND
                                        </h4>
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
                                    <div class="action-buttons ms-2">
                                        <a href="order-detail?id=${flight.getId()}&departure=${departure}&destination=${destination}&departureDate=${departureDate}" class="btn btn-light" title="View Details">
                                            <i class="fas fa-eye text-primary align-items-center"></i>
                                        </a>
                                        <br><br>
                                        <!-- Change the link to a form with POST method -->
                                    <form action="order-confirm" method="post" style="display:inline;">
                                        <input type="hidden" name="flightId" value="${flight.getId()}">
                                        <input type="hidden" name="ticketClass" value="${ticket.type}">
                                        <input type="hidden" name="passengers" value="${passengers}">
                                        <input type="hidden" name="adult" value="${param.adult}">
                                        <input type="hidden" name="child" value="${param.child}">
                                        <input type="hidden" name="baby" value="${param.baby}">
                                        <button type="submit" class="btn btn-primary rounded-3 px-4 py-2 w-100" title="Đặt vé ngay">
                                            Book
                                        </button>
                                    </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function addToCart(id, name, price, ticketType) {
                let cart = JSON.parse(localStorage.getItem('flightCart')) || [];
                const existingItem = cart.find(item => item.id === id && item.ticketType === ticketType);
                if (existingItem) {
                    showNotification('This flight is already in your cart');
                } else {
                    cart.push({
                        id: id,
                        name: name,
                        price: formatCurrency(price),
                        ticketType: ticketType
                    });
                    localStorage.setItem('flightCart', JSON.stringify(cart));
                    updateCartCount();
                    showNotification('Flight added to cart successfully');
                }
            }
            function formatCurrency(value) {
                return new Intl.NumberFormat('vi-VN').format(value);
            }
        </script>
        <script>
            if (!localStorage.getItem('flightCart')) {
                localStorage.setItem('flightCart', JSON.stringify([]));
            }
            document.addEventListener('DOMContentLoaded', function () {
                updateCartCount();
            });
            function updateCartCount() {
                const cart = JSON.parse(localStorage.getItem('flightCart')) || [];
                const countElement = document.querySelector('.cart-count');
                if (countElement) {
                    countElement.textContent = cart.length;
                }
            }
            function addToCart(id, name, price, ticketType) {
                let cart = JSON.parse(localStorage.getItem('flightCart')) || [];
                const existingItem = cart.find(item => item.id === id && item.ticketType === ticketType);
                if (existingItem) {
                    showNotification('This flight is already in your cart');
                } else {
                    cart.push({
                        id: id,
                        name: name,
                        price: formatCurrency(price),
                        ticketType: ticketType
                    });
                    localStorage.setItem('flightCart', JSON.stringify(cart));
                    updateCartCount();
                    showNotification('Flight added to cart successfully');
                }
            }
            function showNotification(message) {
                const notification = document.createElement('div');
                notification.classList.add('toast-notification');
                notification.innerHTML = `
                    <div class="toast-content"><i class="fas fa-check-circle me-2"></i>${message}</div>
                `;
                document.body.appendChild(notification);
                setTimeout(() => {
                    notification.classList.add('show');
                }, 100);
                setTimeout(() => {
                    notification.classList.remove('show');
                    setTimeout(() => {
                        document.body.removeChild(notification);
                    }, 300);
                }, 3000);
            }
            function formatCurrency(value) {
                return new Intl.NumberFormat('vi-VN').format(value);
            }
        </script>
    </body>
</html>