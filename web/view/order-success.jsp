<%-- 
    Document   : order-success
    Created on : 3 Mar 2025, 09:46:14
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
            .header-section {
                background: white;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
                padding: 1rem 0;
                margin-bottom: 2rem;
                position: sticky;
                top: 0;
                z-index: 1000;
            }
            .confirmation-container {
                max-width: 700px;
                margin: 0 auto;
                padding: 2rem;
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.05);
            }
            .success-icon {
                font-size: 4rem;
                color: #34c759;
                margin-bottom: 1rem;
            }
            .booking-reference {
                background-color: #f8f9fa;
                padding: 1rem;
                border-radius: 5px;
                margin: 1rem 0;
                font-size: 1.2rem;
                text-align: center;
            }
            .next-steps {
                background-color: #f0f7ff;
                padding: 1.5rem;
                border-radius: 8px;
                margin-top: 2rem;
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
                        <a href="order" class="btn btn-outline-primary">
                            <i class="fas fa-search me-1"></i> Search Flights
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="container confirmation-container text-center">
            <div class="success-icon">
                <i class="fas fa-check-circle"></i>
            </div>

            <h2>Booking Confirmed!</h2>
            <p class="lead">Thank you, ${sessionScope.passengerName}, for your booking.</p>

            <div class="booking-reference">
                <p class="mb-1">Your Booking Reference</p>
                <h3>${sessionScope.bookingReference}</h3>
            </div>

            <p>A confirmation email has been sent to your registered email address with all the details.</p>

            <div class="d-flex justify-content-center mt-4">
                <div class="text-start">
                    <p><strong>Total Amount:</strong> ${sessionScope.totalAmount} VND</p>
                    <p><strong>Status:</strong> <span class="badge bg-success">Confirmed</span></p>
                </div>
            </div>

            <div class="next-steps">
                <h4><i class="fas fa-info-circle me-2"></i> What's Next?</h4>
                <ul class="list-unstyled text-start">
                    <li><i class="fas fa-check me-2 text-success"></i> Check your email for booking details</li>
                    <li><i class="fas fa-check me-2 text-success"></i> Save your booking reference for future reference</li>
                    <li><i class="fas fa-plane-departure me-2 text-primary"></i> Arrive at the airport at least 2 hours before your flight</li>
                    <li><i class="fas fa-id-card me-2 text-primary"></i> Don't forget to bring your passport/ID</li>
                </ul>
            </div>

            <div class="mt-4">
                <a href="order" class="btn btn-primary">
                    <i class="fas fa-search me-2"></i> Book Another Flight
                </a>
                <a href="view-bookings" class="btn btn-outline-secondary ms-2">
                    <i class="fas fa-list me-2"></i> View My Bookings
                </a>
            </div>

            <p class="mt-4 text-muted">Have questions? Contact our support at <a href="mailto:support@flightbooking.com">support@flightbooking.com</a></p>
        </div>

        <script>
            // Clear the cart after successful booking
            localStorage.removeItem('flightCart');

            // Optional: Add this if you want to prevent going back to the checkout page after booking
            window.history.pushState(null, '', window.location.href);
            window.addEventListener('popstate', function () {
                window.history.pushState(null, '', window.location.href);
            });
        </script>
    </body>
</html>