<%-- 
    Document   : order-home
    Created on : 3 Mar 2025, 09:15:33
    Author     : A A
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Book Your Flight</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    </head>
    <body>
        <!-- Header Section -->
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
        <!-- Banner Section -->
        <div class="banner-section">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <h1 class="banner-title">Find Your Perfect Flight</h1>
                        <p>Discover the best deals and book your next adventure with confidence.</p>
                    </div>
                </div>
            </div>
        </div>
        <!-- Search Form Container -->
        <div class="container">
            <div class="search-container">
                <h3 class="search-title">Search Flights</h3>
                <!-- Trip Type Toggle -->
                <div class="trip-type-toggle btn-group mb-4">
                    <input type="radio" class="btn-check" name="tripType" id="oneWay" value="oneWay" checked>
                    <label class="btn btn-outline-primary" for="oneWay">One Way</label>

                    <input type="radio" class="btn-check" name="tripType" id="roundTrip" value="roundTrip">
                    <label class="btn btn-outline-primary" for="roundTrip">Round Trip</label>
                </div>
                <form action="order" method="GET" id="flightSearchForm">
                    <div class="row">
                        <!-- Origin Dropdown -->
                        <div class="col-md-6 mb-3">
                            <label for="origin" class="form-label">From</label>
                            <div class="location-input">
                                <i class="fas fa-plane-departure"></i>
                                <select class="form-select" id="origin" name="departure" required>
                                    <option value="">Select Departure</option>
                                    <c:forEach var="location" items="${locations}">
                                        <option value="${location.name}">${location.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <!-- Destination Dropdown -->
                        <div class="col-md-6 mb-3">
                            <label for="destination" class="form-label">To</label>
                            <div class="location-input">
                                <i class="fas fa-plane-arrival"></i>
                                <select class="form-select" id="destination" name="destination" required>
                                    <option value="">Select Destination</option>
                                    <c:forEach var="location" items="${locations}">
                                        <option value="${location.name}">${location.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <!-- Swap Button (for mobile screens) -->
                        <div class="col-12 d-md-none">
                            <div class="swap-button" id="swapDestinations">
                                <i class="fas fa-exchange-alt"></i>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <!-- Departure Date -->
                        <div class="col-md-3 mb-3">
                            <label for="departureDate" class="form-label">Departure Date</label>
                            <div class="date-picker-container">
                                <input type="date" class="form-control" id="departureDate" name="departureDate" required>
                                <i class="far fa-calendar"></i>
                            </div>
                        </div>
                        <!-- Return Date (shown only for round trip) -->
                        <div class="col-md-3 mb-3" id="returnDateContainer" style="display:none;">
                            <label for="returnDate" class="form-label">Return Date</label>
                            <div class="date-picker-container">
                                <input type="date" class="form-control" id="returnDate" name="returnDate">
                                <i class="far fa-calendar"></i>
                            </div>
                        </div>
                        <%--div class="col-md-3 mb-3">
                            <label for="compartmentType" class="form-label">Seat Type</label>
                            <select class="form-select" name="compartmentType">
                                <c:forEach var="ct" items="${cts}">
                                    <option value="${ct.id}">${ct.name}</option>
                                </c:forEach>
                            </select>
                        </div--%>
                        <!-- Passengers -->
                        <div class="col-md-3 mb-3 position-relative">
                            <label class="form-label">Passengers</label>
                            <div class="passenger-selection">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span>Adult</span>
                                    <div class="input-group input-group-sm" style="width: 120px;">
                                        <button class="btn btn-outline-secondary" type="button" id="adultMinus">-</button>
                                        <input type="text" class="form-control text-center" id="adultCount" name="adult" value="1" readonly>
                                        <button class="btn btn-outline-secondary" type="button" id="adultPlus">+</button>
                                    </div>
                                </div>
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span>Child</span>
                                    <div class="input-group input-group-sm" style="width: 120px;">
                                        <button class="btn btn-outline-secondary" type="button" id="childMinus">-</button>
                                        <input type="text" class="form-control text-center" id="childCount" name="child" value="0" readonly>
                                        <button class="btn btn-outline-secondary" type="button" id="childPlus">+</button>
                                    </div>
                                </div>
                                <div class="d-flex justify-content-between align-items-center">
                                    <span>Baby</span>
                                    <div class="input-group input-group-sm" style="width: 120px;">
                                        <button class="btn btn-outline-secondary" type="button" id="babyMinus">-</button>
                                        <input type="text" class="form-control text-center" id="babyCount" name="baby" value="0" readonly>
                                        <button class="btn btn-outline-secondary" type="button" id="babyPlus">+</button>
                                    </div>
                                </div>
                                <input type="hidden" id="totalPassengers" name="passengers" value="1">
                            </div>
                        </div>
                    </div>
                    <div class="card-footer text-center mt-4">
                        <button type="submit" class="btn btn-search">
                            <i class="fas fa-search me-2"></i> Search Flights
                        </button>
                    </div>
                </form>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const oneWayRadio = document.getElementById('oneWay');
                const roundTripRadio = document.getElementById('roundTrip');
                const returnDateContainer = document.getElementById('returnDateContainer');
                const returnDateInput = document.getElementById('returnDate');
                roundTripRadio.addEventListener('change', function () {
                    if (this.checked) {
                        returnDateContainer.style.display = 'block';
                        returnDateInput.required = true;
                    }
                });
                oneWayRadio.addEventListener('change', function () {
                    if (this.checked) {
                        returnDateContainer.style.display = 'none';
                        returnDateInput.required = false;
                        returnDateInput.value = '';
                    }
                });
            });
        </script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const adultCount = document.getElementById('adultCount');
                const childCount = document.getElementById('childCount');
                const babyCount = document.getElementById('babyCount');
                const totalPassengersInput = document.getElementById('totalPassengers');
                const adultPlus = document.getElementById('adultPlus');
                const adultMinus = document.getElementById('adultMinus');
                const childPlus = document.getElementById('childPlus');
                const childMinus = document.getElementById('childMinus');
                const babyPlus = document.getElementById('babyPlus');
                const babyMinus = document.getElementById('babyMinus');
                function updateTotalPassengers() {
                    const total = parseInt(adultCount.value) +
                            parseInt(childCount.value) +
                            parseInt(babyCount.value);
                    totalPassengersInput.value = total;

                    // Disable/enable plus buttons based on total passengers
                    adultPlus.disabled = total >= 7;
                    childPlus.disabled = total >= 7;
                    babyPlus.disabled = total >= 7;
                }
                adultPlus.addEventListener('click', function () {
                    const total = parseInt(adultCount.value) +
                            parseInt(childCount.value) +
                            parseInt(babyCount.value);

                    if (total < 7) {
                        adultCount.value = parseInt(adultCount.value) + 1;
                        updateTotalPassengers();
                    }
                });

                adultMinus.addEventListener('click', function () {
                    if (parseInt(adultCount.value) > 1) {
                        adultCount.value = parseInt(adultCount.value) - 1;
                        updateTotalPassengers();
                    }
                });
                childPlus.addEventListener('click', function () {
                    const total = parseInt(adultCount.value) +
                            parseInt(childCount.value) +
                            parseInt(babyCount.value);

                    if (total < 7) {
                        childCount.value = parseInt(childCount.value) + 1;
                        updateTotalPassengers();
                    }
                });

                childMinus.addEventListener('click', function () {
                    if (parseInt(childCount.value) > 0) {
                        childCount.value = parseInt(childCount.value) - 1;
                        updateTotalPassengers();
                    }
                });
                babyPlus.addEventListener('click', function () {
                    const total = parseInt(adultCount.value) +
                            parseInt(childCount.value) +
                            parseInt(babyCount.value);

                    if (total < 7) {
                        babyCount.value = parseInt(babyCount.value) + 1;
                        updateTotalPassengers();
                    }
                });
                babyMinus.addEventListener('click', function () {
                    if (parseInt(babyCount.value) > 0) {
                        babyCount.value = parseInt(babyCount.value) - 1;
                        updateTotalPassengers();
                    }
                });
                updateTotalPassengers();
            });
        </script>
    </body>
</html>