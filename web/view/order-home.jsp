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
        <style>
            body {
                background: linear-gradient(135deg, #f0f7ff 0%, #ffffff 100%);
                min-height: 100vh;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            .header-section {
                background: white;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                padding: 1rem 0;
                position: sticky;
                top: 0;
                z-index: 1000;
            }
            .search-container {
                background: white;
                border-radius: 12px;
                box-shadow: 0 4px 16px rgba(0,0,0,0.08);
                padding: 2rem;
                margin-top: 2rem;
                margin-bottom: 2rem;
            }
            .search-title {
                color: #0064d2;
                font-weight: 600;
                margin-bottom: 1.5rem;
            }
            .btn-search {
                background-color: #ff5e1f;
                color: white;
                font-weight: 600;
                padding: 0.8rem 2rem;
                border-radius: 8px;
                border: none;
                transition: all 0.3s ease;
            }
            .btn-search:hover {
                background-color: #e94e0f;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }
            .trip-type-toggle {
                margin-bottom: 1rem;
            }
            .trip-type-toggle .btn {
                border-radius: 20px;
                padding: 0.5rem 1.5rem;
                font-weight: 500;
            }
            .trip-type-toggle .btn.active {
                background-color: #0064d2;
                color: white;
            }
            .form-label {
                font-weight: 500;
                color: #444;
            }
            .form-control, .form-select {
                border-radius: 8px;
                padding: 0.7rem;
                border: 1px solid #ddd;
            }
            .location-input {
                position: relative;
            }

            .location-input i {
                position: absolute;
                left: 15px;
                top: 50%;
                transform: translateY(-50%);
                color: #666;
                z-index: 3;
                pointer-events: none;
            }

            .location-input select {
                padding-left: 40px;
                appearance: none;
                -webkit-appearance: none;
                -moz-appearance: none;
                background-image: url("data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' width='4' height='5'%3E%3Cpath fill='%23343a40' d='M2 0L0 2h4zm0 5L0 3h4z'/%3E%3C/svg%3E");
                background-repeat: no-repeat;
                background-position: right 15px center;
                background-size: 8px 10px;
            }

            .location-input select:focus {
                box-shadow: 0 0 0 0.2rem rgba(0,100,210,0.25);
                border-color: #0064d2;
            }
            .swap-button {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: #0064d2;
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 1.5rem auto;
                cursor: pointer;
                transition: all 0.3s ease;
            }
            .swap-button:hover {
                transform: rotate(180deg);
                background: #0051a8;
            }
            .card-footer {
                background-color: rgba(0,100,210,0.05);
                border-top: none;
                padding: 1rem;
            }
            .destination-suggestions {
                position: absolute;
                top: 100%;
                left: 0;
                right: 0;
                background: white;
                border-radius: 0 0 8px 8px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                z-index: 100;
                max-height: 200px;
                overflow-y: auto;
                display: none;
            }
            .destination-item {
                padding: 10px 15px;
                cursor: pointer;
                border-bottom: 1px solid #f0f0f0;
            }
            .destination-item:hover {
                background-color: #f6f9ff;
            }
            .promo-section {
                margin-top: 3rem;
            }
            .promo-card {
                border-radius: 12px;
                overflow: hidden;
                transition: transform 0.3s ease;
                box-shadow: 0 4px 8px rgba(0,0,0,0.05);
            }
            .promo-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 16px rgba(0,0,0,0.1);
            }
            .class-select .form-check {
                padding: 10px 15px;
                border: 1px solid #ddd;
                border-radius: 8px;
                margin-bottom: 10px;
                cursor: pointer;
                transition: all 0.3s ease;
            }
            .class-select .form-check:hover {
                background-color: #f6f9ff;
            }
            .class-select .form-check-input:checked ~ .form-check-label {
                font-weight: 600;
                color: #0064d2;
            }
            .class-description {
                font-size: 0.8rem;
                color: #666;
            }
            .banner-section {
                padding: 3rem 0;
                background: linear-gradient(135deg, #0064d2 0%, #1a8fe3 100%);
                color: white;
                margin-bottom: 3rem;
            }
            .banner-title {
                font-weight: 700;
                margin-bottom: 1rem;
            }
            .date-picker-container {
                position: relative;
            }
            .date-picker-container i {
                position: absolute;
                right: 15px;
                top: 50%;
                transform: translateY(-50%);
                color: #666;
            }
        </style>
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
        <script>
            // Toggle return date visibility based on trip type
            document.querySelectorAll('input[name="tripType"]').forEach(input => {
                input.addEventListener('change', function () {
                    const returnDateContainer = document.getElementById('returnDateContainer');
                    if (this.value === 'roundTrip') {
                        returnDateContainer.style.display = 'block';
                        document.getElementById('returnDate').setAttribute('required', 'required');
                    } else {
                        returnDateContainer.style.display = 'none';
                        document.getElementById('returnDate').removeAttribute('required');
                    }
                });
            });

            // Set minimum date for departure and return date inputs to today
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('departureDate').setAttribute('min', today);
            document.getElementById('returnDate').setAttribute('min', today);

            // Handle departure date change to update return date minimum
            document.getElementById('departureDate').addEventListener('change', function () {
                document.getElementById('returnDate').setAttribute('min', this.value);

                // If return date is earlier than departure date, update it
                const returnDate = document.getElementById('returnDate');
                if (returnDate.value && returnDate.value < this.value) {
                    returnDate.value = this.value;
                }
            });

            // Destination suggestions
            const setupDestinationSuggestions = (inputId, suggestionsId) => {
                const input = document.getElementById(inputId);
                const suggestions = document.getElementById(suggestionsId);

                input.addEventListener('focus', () => {
                    suggestions.style.display = 'block';
                });

                input.addEventListener('input', () => {
                    const value = input.value.toLowerCase();

                    Array.from(suggestions.children).forEach(item => {
                        const text = item.textContent.toLowerCase();
                        if (text.includes(value)) {
                            item.style.display = 'block';
                        } else {
                            item.style.display = 'none';
                        }
                    });

                    suggestions.style.display = 'block';
                });

                document.addEventListener('click', (e) => {
                    if (e.target !== input && !suggestions.contains(e.target)) {
                        suggestions.style.display = 'none';
                    }
                });

                suggestions.addEventListener('click', (e) => {
                    if (e.target.classList.contains('destination-item')) {
                        input.value = e.target.getAttribute('data-value');
                        suggestions.style.display = 'none';
                    }
                });
            };

            setupDestinationSuggestions('origin', 'originSuggestions');
            setupDestinationSuggestions('destination', 'destinationSuggestions');

            // Swap origin and destination
            document.getElementById('swapDestinations').addEventListener('click', () => {
                const origin = document.getElementById('origin');
                const destination = document.getElementById('destination');

                const temp = origin.value;
                origin.value = destination.value;
                destination.value = temp;
            });
        </script>
    </body>
</html>