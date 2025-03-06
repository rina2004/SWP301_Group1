<%-- 
    Document   : booking-confirmation
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
            .flight-info {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-top: 1rem;
            }
            .passenger-form {
                background: white;
                border-radius: 8px;
                padding: 1.5rem;
                margin-bottom: 2rem;
            }
            .ticket-summary {
                background-color: #f8f9fa;
                border-radius: 8px;
                padding: 1.5rem;
            }
            .price-display {
                font-size: 1.5rem;
                font-weight: bold;
                color: #2563eb;
            }
            .booking-container {
                max-width: 900px;
                margin: 0 auto;
            }
            .date-display {
                font-size: 1.2rem;
                color: #333;
            }
        </style>
    </head>
    <body>
        <!-- Header Section -->
        <div class="header-section">
            <div class="container">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="d-flex align-items-center">
                        <img src="img/logo.jpg" alt="Logo" class="me-2" style="height: 40px;">
                        <h2 class="mb-0">Flight Booking</h2>
                    </div>
                    <div>
                        <a href="cart.jsp" class="btn btn-outline-primary position-relative">
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
                            </div>
                            <div class="mt-3">
                                <span class="badge bg-info me-2">${ticketClass}</span>
                                <span class="badge bg-secondary">Flight Number: ${flight.getName()}</span>
                            </div>
                        </div>
                    </div>

                    <!-- Passenger Information Form -->
                    <div class="passenger-form">
                        <h4 class="mb-3">Passenger Information</h4>
                        
                        <%--form id="bookingForm" action="process-single-booking" method="POST"--%>
                        <form id="bookingForm" action="order-success.jsp" method="POST">
                            <input type="hidden" name="flightId" value="${flight.getId()}">
                            <input type="hidden" name="ticketClass" value="${ticketClass}">
                            <input type="hidden" name="price" value="${ticket.price}">
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="firstName" class="form-label">First Name</label>
                                    <input type="text" class="form-control" id="firstName" name="firstName" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="lastName" class="form-label">Last Name</label>
                                    <input type="text" class="form-control" id="lastName" name="lastName" required>
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
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="passportNumber" class="form-label">Passport/ID Number</label>
                                    <input type="text" class="form-control" id="passportNumber" name="passportNumber" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="passportExpiry" class="form-label">Passport Expiry Date</label>
                                    <input type="date" class="form-control" id="passportExpiry" name="passportExpiry" required>
                                </div>
                            </div>
                            
                            <button type="submit" class="btn btn-primary w-100 mt-3">
                                <i class="fas fa-check-circle me-2"></i> Complete Booking
                            </button>
                        </form>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <!-- Ticket Summary -->
                    <div class="ticket-summary">
                        <h4 class="mb-3">Price Summary</h4>
                        
                        <div class="d-flex justify-content-between mb-2">
                            <span>Base fare:</span>
                            <span><fmt:formatNumber value="${ticket.price * 0.8}" type="currency" currencySymbol="" maxFractionDigits="0"/> VND</span>
                        </div>
                        
                        <div class="d-flex justify-content-between mb-2">
                            <span>Taxes & fees:</span>
                            <span><fmt:formatNumber value="${ticket.price * 0.2}" type="currency" currencySymbol="" maxFractionDigits="0"/> VND</span>
                        </div>
                        
                        <div class="d-flex justify-content-between mb-2 total-row pt-2">
                            <span class="fw-bold">Total price:</span>
                            <span class="price-display"><fmt:formatNumber value="${ticket.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> VND</span>
                        </div>
                        
                        <div class="mt-4">
                            <h5>Booking Information</h5>
                            <ul class="list-unstyled">
                                <li><i class="fas fa-plane-departure me-2"></i> From: ${flight.getDeparture()}</li>
                                <li><i class="fas fa-plane-arrival me-2"></i> To: ${flight.getDestination()}</li>
                                <li><i class="fas fa-calendar me-2"></i> Date: ${flight.getStartingDate()}</li>
                                <li><i class="fas fa-ticket-alt me-2"></i> Class: ${ticketClass}</li>
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
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>