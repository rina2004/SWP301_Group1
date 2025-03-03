<%-- 
    Document   : booking-confirmation
    Created on : 3 Mar 2025, 09:46:14
    Author     : A A
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Booking Confirmation</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link rel="icon" type="image/png" href="img/logo.jpg">
        <style>
            body {
                background: linear-gradient(135deg, #f0f7ff 0%, #ffffff 100%);
                min-height: 100vh;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .confirmation-container {
                background: white;
                border-radius: 12px;
                box-shadow: 0 4px 16px rgba(0,0,0,0.08);
                padding: 3rem;
                margin: 2rem;
                text-align: center;
                max-width: 600px;
                width: 100%;
            }
            .success-icon {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 100px;
                height: 100px;
                background-color: #ecfdf5;
                border-radius: 50%;
                margin-bottom: 1.5rem;
            }
            .success-icon i {
                font-size: 50px;
                color: #10b981;
            }
            .confirmation-title {
                color: #10b981;
                font-weight: 700;
                margin-bottom: 1rem;
            }
            .booking-id {
                background-color: #f1f5f9;
                border-radius: 8px;
                padding: 0.8rem;
                margin: 1.5rem 0;
                font-size: 1.2rem;
                font-weight: 600;
            }
            .btn-home {
                background-color: #0064d2;
                color: white;
                font-weight: 600;
                padding: 0.8rem 2rem;
                border-radius: 8px;
                border: none;
                transition: all 0.3s ease;
                margin-top: 1.5rem;
            }
            .btn-home:hover {
                background-color: #0051a8;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }
            .confirmation-details {
                text-align: left;
                margin: 2rem 0;
                padding: 1.5rem;
                background-color: #f8fafd;
                border-radius: 8px;
            }
            .detail-item {
                margin-bottom: 1rem;
            }
            .detail-label {
                color: #64748b;
                font-size: 0.875rem;
            }
            .detail-value {
                font-weight: 600;
                color: #0f172a;
            }
        </style>
        <meta http-equiv="refresh" content="5;url=order-home.jsp">
    </head>
    <body>
        <div class="confirmation-container">
            <div class="success-icon">
                <i class="fas fa-check"></i>
            </div>
            <h2 class="confirmation-title">Booking Successful!</h2>
            <p>Your flight has been booked successfully. A confirmation email has been sent to your email address.</p>
            
            <div class="booking-id">
                Booking ID: ${orderId}
            </div>
            
            <div class="confirmation-details">
                <div class="row">
                    <div class="col-md-6">
                        <div class="detail-item">
                            <div class="detail-label">Flight</div>
                            <div class="detail-value">${flight.getName()} (${flight.getCode()})</div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="detail-item">
                            <div class="detail-label">Date</div>
                            <div class="detail-value">${flight.getStartingDate()}</div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="detail-item">
                            <div class="detail-label">From</div>
                            <div class="detail-value">${flight.getDeparture()}</div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="detail-item">
                            <div class="detail-label">To</div>
                            <div class="detail-value">${flight.getDestination()}</div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="detail-item">
                            <div class="detail-label">Class</div>
                            <div class="detail-value">${ticketClass}</div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="detail-item">
                            <div class="detail-label">Passengers</div>
                            <div class="detail-value">${passengers}</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <p class="mb-4">You will be redirected to the home page in 5 seconds.</p>
            
            <a href="order-home.jsp" class="btn btn-home">
                <i class="fas fa-home me-2"></i> Return to Home
            </a>
        </div>
    </body>
</html>