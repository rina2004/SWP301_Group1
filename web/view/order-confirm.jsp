<%-- 
    Document   : order-confirm
    Created on : 3 Mar 2025, 16:15:30
    Author     : A A
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Booking Confirmation | Flight Booking</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            .booking-summary {
                position: sticky;
                top: 20px;
            }
        </style>
    </head>
    <body>
        <!-- Header Section -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container">
                <a class="navbar-brand" href="#">Flight Booking</a>
                <div class="ms-auto">
                    <c:if test="${empty acc}">
                        <a href="Login.jsp" class="btn btn-outline-primary me-2">Sign In</a>
                        <a href="register" class="btn btn-primary">Register</a>
                    </c:if>
                    <c:if test="${not empty acc}">
                        <div class="d-flex align-items-center">
                            <span class="me-3"><i class="fas fa-user me-2"></i>${sessionScope.user}</span>
                            <form action="${pageContext.request.contextPath}/logout" method="get" class="mb-0">
                                <button type="submit" class="btn btn-secondary">Logout</button>
                            </form>
                        </div>
                    </c:if>
                </div>
            </div>
        </nav>

        <div class="container my-5">
            <div class="row">
                <!-- Main Booking Details Column -->
                <div class="col-md-8">
                    <h2 class="mb-4"><i class="fas fa-plane me-2"></i>Booking Confirmation</h2>

                    <!-- Flight Details Card -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <h4>Flight Details</h4>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <p><strong>Flight:</strong> ${flight.name}</p>
                                    <p><strong>Route:</strong> ${flight.departure.name} → ${flight.destination.name}</p>
                                    <p><strong>Departure:</strong> ${flight.startingDate} ${flight.startingHour}</p>
                                    <p><strong>Arrival:</strong> ${flight.getLandingDate()} ${flight.getLandingHour()}</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Passenger Summary Card -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <h4>Passenger Information</h4>
                        </div>
                        <div class="card-body">
                            <div class="passenger-summary d-flex justify-content-start align-items-center">
                                <div class="badge bg-info p-2 me-2">
                                    <i class="fas fa-users me-1"></i> 
                                    Total Passengers: ${passengers}
                                </div>
                                <c:if test="${not empty adult and adult ne '0'}">
                                    <div class="badge bg-light text-dark p-2 me-2">
                                        <i class="fas fa-user me-1"></i> 
                                        Adults: ${adult}
                                    </div>
                                </c:if>
                                <c:if test="${not empty child and child ne '0'}">
                                    <div class="badge bg-light text-dark p-2 me-2">
                                        <i class="fas fa-child me-1"></i> 
                                        Children: ${child}
                                    </div>
                                </c:if>
                                <c:if test="${not empty baby and baby ne '0'}">
                                    <div class="badge bg-light text-dark p-2">
                                        <i class="fas fa-baby me-1"></i> 
                                        Babies: ${baby}
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <!-- User Contact Information -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <h4>Contact Details</h4>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Full Name</label>
                                    <input type="text" class="form-control" value="${userName}" readonly>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Citizen ID/Passport</label>
                                    <input type="text" class="form-control" value="${userCitizenID}" readonly>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Email</label>
                                    <input type="email" class="form-control" value="${userEmail}" readonly>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Phone</label>
                                    <input type="tel" class="form-control" value="${userPhone}" readonly>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Passenger Details Form -->
                    <form action="order-submit" method="post">
                        <input type="hidden" name="flightId" value="${flight.id}">

                        <c:forEach begin="1" end="${passengers}" varStatus="status">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h5>Passenger ${status.index} Details</h5>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="passengerType${status.index}" class="form-label">Passenger Type</label>
                                            <select class="form-select" name="passengerType${status.index}" required>
                                                <c:forEach items="${passengerTypes}" var="type">
                                                    <option value="${type.id}">${type.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="fullName${status.index}" class="form-label">Full Name</label>
                                            <input type="text" class="form-control" 
                                                   name="fullName${status.index}" 
                                                   id="fullName${status.index}" 
                                                   required>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="dob${status.index}" class="form-label">Date of Birth</label>
                                            <input type="date" class="form-control" 
                                                   name="dob${status.index}" 
                                                   id="dob${status.index}" 
                                                   required>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="nationality${status.index}" class="form-label">Nationality</label>
                                            <select class="form-select" name="nationality${status.index}" required>
                                                <c:forEach items="${nations}" var="nation">
                                                    <option value="${nation.id}">${nation.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </form>
                </div>

                <!-- Booking Summary and Options Column -->
                <div class="col-md-4">
                    <div class="booking-summary">
                        <!-- Ticket Type Selection -->
                        <div class="card mb-4">
                            <div class="card-header">
                                <h5>Ticket Type</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <c:forEach items="${ticketTypes}" var="ticketType">
                                        <div class="col-md-12 mb-3">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" 
                                                       name="ticketType" 
                                                       id="ticketType${ticketType.type}" 
                                                       value="${ticketType.type}" 
                                                       required>
                                                <label class="form-check-label" for="ticketType${ticketType.type}">
                                                    ${ticketType.type}
                                                    <small class="text-muted d-block">
                                                        CheckedWeight: ${ticketType.checkedweightneed} kg, HandedWeight: ${ticketType.handedweightneed} kg
                                                    </small>
                                                </label>

                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>

                        <!-- Seat Type Selection -->
                        <div class="card mb-4">
                            <div class="card-header">
                                <h5>Seat Type</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <c:forEach items="${compartmentTypes}" var="compartmentType">
                                        <div class="col-md-12 mb-3">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" 
                                                       name="compartmentType" 
                                                       id="compartmentType${compartmentType.id}" 
                                                       value="${compartmentType.id}" 
                                                       required>
                                                <label class="form-check-label" for="compartmentType${compartmentType.id}">
                                                    ${compartmentType.name}
                                                </label>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>

                        <!-- Price Summary -->
                        <div class="card mb-4">
                            <div class="card-header">
                                <h5>Price Summary</h5>
                            </div>
                            <div class="card-body">
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Base Fare:</span>
                                    <span id="baseFareDisplay">
                                        <fmt:formatNumber value="0" type="currency" currencySymbol="" maxFractionDigits="0"/> VND
                                    </span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Taxes and Fees:</span>
                                    <span id="taxesDisplay">
                                        <fmt:formatNumber value="0" type="currency" currencySymbol="" maxFractionDigits="0"/> VND
                                    </span>
                                </div>
                                <hr>
                                <div class="d-flex justify-content-between fw-bold">
                                    <span>Total Price (Not contain ticket) :</span>
                                    <span id="totalPriceDisplay">
                                        <fmt:formatNumber value="${flight.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> VND
                                    </span>
                                </div>
                            </div>
                        </div>

                        <!-- Booking Information -->
                        <div class="card mb-4">
                            <div class="card-header">
                                <h5>Trip Details</h5>
                            </div>
                            <div class="card-body">
                                <ul class="list-unstyled">
                                    <li><i class="fas fa-plane-departure me-2"></i> From: ${flight.departure.name}</li>
                                    <li><i class="fas fa-plane-arrival me-2"></i> To: ${flight.destination.name}</li>
                                    <li><i class="fas fa-calendar me-2"></i> Date: ${flight.getStartingDate()}</li>
                                    <li><i class="fas fa-user me-2"></i> Passengers: ${passengers}</li>
                                </ul>
                            </div>
                        </div>

                        <!-- Final Booking Button -->
                        <div class="card">
                            <div class="card-body">
                                <div class="alert alert-info">
                                    <small>
                                        <i class="fas fa-info-circle me-2"></i> 
                                        By proceeding, you agree to our terms and conditions. 
                                        Cancellation fees may apply.
                                    </small>
                                </div>
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="fas fa-check-circle me-2"></i> Complete Booking
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const compartmentRadios = document.querySelectorAll('input[name="compartmentType"]');
                const baseFareDisplay = document.getElementById('baseFareDisplay');
                const taxesDisplay = document.getElementById('taxesDisplay');
                const totalPriceDisplay = document.getElementById('totalPriceDisplay');

                // Get the base flight price from the existing display
                const baseFlightPrice = parseFloat('${flight.price}');

                // Pricing multipliers for different compartment types
                const compartmentMultipliers = {
                    'Economy': 1,
                    'Business': 1.5,
                    'First Class': 2
                };

                function calculatePricing(multiplier) {
                    const totalPrice = baseFlightPrice * multiplier;
                    const taxes = totalPrice * 0.05;
                    const baseFare = totalPrice - taxes;

                    baseFareDisplay.textContent = Math.round(baseFare).toLocaleString() + ' VND';
                    taxesDisplay.textContent = Math.round(taxes).toLocaleString() + ' VND';
                    totalPriceDisplay.textContent = Math.round(totalPrice).toLocaleString() + ' VND';
                }

                // Store the currently selected ticket type
                let selectedTicketType = null;

                // Add event listeners to ticket type radios to track selection
                const ticketTypeRadios = document.querySelectorAll('input[name="ticketType"]');
                ticketTypeRadios.forEach(radio => {
                    radio.addEventListener('change', function () {
                        selectedTicketType = this.value;
                        console.log('Selected Ticket Type:', selectedTicketType);
                    });
                });

                // Add event listeners to compartment type radios
                compartmentRadios.forEach(radio => {
                    radio.addEventListener('change', function () {
                        const compartmentType = this.id.replace('compartmentType', '');
                        const selectedCompartmentName = this.nextElementSibling.textContent.trim();

                        // Determine the multiplier based on the compartment type name
                        const multiplier = Object.keys(compartmentMultipliers).reduce((mult, key) => {
                            return selectedCompartmentName.includes(key) ? compartmentMultipliers[key] : mult;
                        }, 1);

                        calculatePricing(multiplier);

                        // Log the selected details for debugging
                        console.log('Selected Compartment Type:', {
                            id: compartmentType,
                            name: selectedCompartmentName,
                            multiplier: multiplier
                        });
                    });
                });

                // Optional: Provide a way to restore selections or handle form submission
                const bookingForm = document.querySelector('form[action="order-submit"]');
                if (bookingForm) {
                    bookingForm.addEventListener('submit', function (event) {
                        // Validate that both ticket type and compartment type are selected
                        const selectedTicketTypeRadio = document.querySelector('input[name="ticketType"]:checked');
                        const selectedCompartmentTypeRadio = document.querySelector('input[name="compartmentType"]:checked');

                        if (!selectedTicketTypeRadio || !selectedCompartmentTypeRadio) {
                            event.preventDefault();
                            alert('Please select both Ticket Type and Seat Type before proceeding.');
                        }
                    });
                }
            });
        </script>
    </body>
</html>