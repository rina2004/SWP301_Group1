<%-- 
    Document   : order-confirm
    Created on : 3 Mar 2025, 16:15:30
    Author     : A A
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Booking Confirmation | Flight Booking</title>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    </head>
    <body>
        <!-- Header Section -->
        <div class="header-section">
            <div class="container">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="d-flex align-items-center">
                        <h2 class="mb-0">Flight Booking</h2>
                    </div>
                    <div>
                        <a href="order-cart.jsp" class="btn btn-outline-primary position-relative">
                            <i class="fas fa-shopping-cart"></i> Cart
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="container booking-container">
            <div class="booking-header mb-4">
                <h3><i class="fas fa-plane me-2"></i> Booking Confirmation</h3>
                <p class="text-muted">Review your flight information and complete passenger details</p>
            </div>
            <div class="row">
                <div class="col-md-8">
                    <!-- Flight Details -->
                    <div class="card mb-4">
                        <div class="card-body">
                            <h4 class="card-title">Flight Details</h4>
                            <div class="flight-info mt-4">
                                <div>
                                    <div class="date-display">${flight.getStartingDate()}</div>
                                    <div class="time-display">${flight.getStartingHour()}</div>
                                    <div class="location-display">${flight.departure.name}</div>
                                </div>
                                <div class="duration-line">
                                    <span class="duration-text">${flight.getDuration()}</span>
                                </div>
                                <div>
                                    <div class="date-display">${flight.getLandingDate()}</div>
                                    <div class="time-display">${flight.getLandingHour()}</div>
                                    <div class="location-display">${flight.destination.name}</div>
                                </div>
                            </div>
                            <div class="mt-3">
                                <span class="badge bg-info me-2">${ticketClass}</span>
                                <span class="badge bg-secondary">Flight Number: ${flight.getName()}</span>
                            </div>
                        </div>
                    </div>
                    <h4 class="mb-3">User Information</h4>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="firstName" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="name" name="firstName" required>
                        </div>
                        <div class="col-md-6">
                            <label for="passportNumber" class="form-label">Passport/ID Number</label>
                            <input type="text" class="form-control" id="passportNumber" name="passportNumber" required>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="col-md-6">
                            <label for="phone" class="form-label">Phone</label>
                            <input type="tel" class="form-control" id="phone" name="phone" required>
                        </div>
                    </div>
                    <!-- Passenger Information Form -->
                    <div class="passenger-form">
                        <h4 class="mb-3">Passenger Information</h4>
                        <form id="bookingForm" action="order-success.jsp" method="POST">
                            <input type="hidden" name="flightId" value="${flight.getId()}">
                            <input type="hidden" name="ticketClass" value="${ticketClass}">
                            <input type="hidden" name="price" value="${ticket.price}">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="firstName" class="form-label">Full Name</label>
                                    <input type="text" class="form-control" id="name" name="firstName" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="passportNumber" class="form-label">Passport/ID Number</label>
                                    <input type="text" class="form-control" id="passportNumber" name="passportNumber" required>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="phone" class="form-label">Phone</label>
                                    <input type="tel" class="form-control" id="phone" name="phone" required>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="dob" class="form-label">Date of Birth</label>
                                    <input type="date" class="form-control" id="dob" name="dob" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="nationality" class="form-label">Nationality</label>
                                    <input type="text" class="form-control" id="nationality" name="nationality" required>
                                </div>
                            </div>
                        </form>
                    </div>
                </div><br><br>
                <!-- Compartment Selection -->
                <div class="card mb-4">
                    <div class="card-body">
                        <h4 class="card-title">Select Ticket Class</h4>
                        <form id="compartmentForm">
                            <div class="compartment-selection">
                                <c:forEach items="${compartments}" var="c" varStatus="status">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" 
                                               name="compartmentType" 
                                               id="compartment${status.index}" 
                                               value="${c.type.price}"
                                               data-type="${c.type.type}"
                                               ${status.first ? 'checked' : ''}>
                                        <label class="form-check-label" for="compartment${status.index}">
                                            ${c.type.type} - 
                                            <fmt:formatNumber value="${c.type.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> VND
                                        </label>
                                    </div>
                                </c:forEach>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="col-md-4">
                    <!-- Ticket Summary -->
                    <div class="ticket-summary">
                        <h4 class="mb-3">Price Summary</h4>

                        <div class="d-flex justify-content-between mb-2">
                            <span>Selected Class:</span>
                            <span id="selectedClassDisplay">${compartments[0].type.type}</span>
                        </div>

                        <div class="d-flex justify-content-between mb-2">
                            <span>Base fare:</span>
                            <span id="baseFareDisplay">
                                <fmt:formatNumber value="${compartments[0].type.price * 0.8}" type="currency" currencySymbol="" maxFractionDigits="0"/> VND
                            </span>
                        </div>

                        <div class="d-flex justify-content-between mb-2">
                            <span>Taxes & fees:</span>
                            <span id="taxesDisplay">
                                <fmt:formatNumber value="${compartments[0].type.price * 0.2}" type="currency" currencySymbol="" maxFractionDigits="0"/> VND
                            </span>
                        </div>

                        <div class="d-flex justify-content-between mb-2 total-row pt-2">
                            <span class="fw-bold">Total price:</span>
                            <span class="price-display" id="totalPriceDisplay">
                                <fmt:formatNumber value="${compartments[0].type.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> VND
                            </span>
                        </div>

                        <div class="mt-4">
                            <h5>Booking Information</h5>
                            <ul class="list-unstyled">
                                <li><i class="fas fa-plane-departure me-2"></i> From: ${flight.departure.name}</li>
                                <li><i class="fas fa-plane-arrival me-2"></i> To: ${flight.destination.name}</li>
                                <li><i class="fas fa-calendar me-2"></i> Date: ${flight.getStartingDate()}</li>
                                <li><i class="fas fa-user me-2"></i> Passengers: 1</li>
                            </ul>
                        </div>
                        <div class="alert alert-info mt-4">
                            <small>
                                <i class="fas fa-info-circle me-2"></i> 
                                By proceeding with this booking, you agree to our terms and conditions. 
                                Cancellation fees may apply.
                            </small>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 mt-3">
                            <i class="fas fa-check-circle me-2"></i> Complete Booking
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const compartmentRadios = document.querySelectorAll('input[name="compartmentType"]');
                const selectedClassDisplay = document.getElementById('selectedClassDisplay');
                const baseFareDisplay = document.getElementById('baseFareDisplay');
                const taxesDisplay = document.getElementById('taxesDisplay');
                const totalPriceDisplay = document.getElementById('totalPriceDisplay');

                compartmentRadios.forEach(radio => {
                    radio.addEventListener('change', function () {
                        const price = parseFloat(this.value);
                        const className = this.getAttribute('data-type');

                        // Update displays
                        selectedClassDisplay.textContent = className;

                        const baseFare = price * 0.8;
                        const taxes = price * 0.2;
                        const totalPrice = price;

                        // Format numbers with comma as thousand separator
                        baseFareDisplay.textContent = Math.round(baseFare).toLocaleString() + ' VND';
                        taxesDisplay.textContent = Math.round(taxes).toLocaleString() + ' VND';
                        totalPriceDisplay.textContent = Math.round(totalPrice).toLocaleString() + ' VND';
                    });
                });
            });
        </script>
    </body>
</html>