<%-- 
    Document   : checkout
    Created on : 3 Mar 2025, 15:24:52
    Author     : A A
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Checkout | Flight Booking</title>
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
            .price-display {
                font-size: 1.5rem;
                font-weight: bold;
                color: #2563eb;
            }
            .cart-count {
                font-size: 0.65rem;
                transform: translate(-50%, -50%) !important;
            }
            .checkout-container {
                max-width: 900px;
                margin: 0 auto;
            }
            .checkout-summary {
                background-color: #f8f9fa;
                border-radius: 8px;
                padding: 1.5rem;
            }
            .checkout-item {
                border-bottom: 1px solid #dee2e6;
                padding-bottom: 1rem;
                margin-bottom: 1rem;
            }
            .checkout-item:last-child {
                border-bottom: none;
                margin-bottom: 0;
            }
            .total-row {
                font-weight: bold;
                border-top: 2px solid #dee2e6;
                padding-top: 1rem;
                margin-top: 1rem;
            }
            .passenger-form {
                background: white;
                border-radius: 8px;
                padding: 1.5rem;
                margin-bottom: 2rem;
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

        <div class="container checkout-container">
            <div class="checkout-header mb-4">
                <h3><i class="fas fa-check-circle me-2"></i> Checkout</h3>
                <p class="text-muted">Complete your booking by providing passenger details</p>
            </div>

            <div class="row">
                <div class="col-md-8">
                    <!-- Passenger Information Form -->
                    <div class="passenger-form mb-4">
                        <h4 class="mb-3">Passenger Information</h4>
                        
                        <form id="checkoutForm" action="process-booking" method="POST">
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
                            
                            <!-- Hidden inputs for cart items -->
                            <input type="hidden" id="cartItems" name="cartItems" value="">
                            <input type="hidden" id="totalAmount" name="totalAmount" value="">
                        </form>
                    </div>
                    
                    <!-- Payment Information -->
                    <div class="passenger-form">
                        <h4 class="mb-3">Payment Information</h4>
                        
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="cardName" class="form-label">Name on Card</label>
                                <input type="text" class="form-control" id="cardName" form="checkoutForm" name="cardName" required>
                            </div>
                            <div class="col-md-6">
                                <label for="cardNumber" class="form-label">Card Number</label>
                                <input type="text" class="form-control" id="cardNumber" form="checkoutForm" name="cardNumber" required>
                            </div>
                        </div>
                        
                        <div class="row mb-3">
                            <div class="col-md-4">
                                <label for="expiryMonth" class="form-label">Expiry Month</label>
                                <select class="form-select" id="expiryMonth" form="checkoutForm" name="expiryMonth" required>
                                    <option value="">Month</option>
                                    <option value="01">01</option>
                                    <option value="02">02</option>
                                    <option value="03">03</option>
                                    <option value="04">04</option>
                                    <option value="05">05</option>
                                    <option value="06">06</option>
                                    <option value="07">07</option>
                                    <option value="08">08</option>
                                    <option value="09">09</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="expiryYear" class="form-label">Expiry Year</label>
                                <select class="form-select" id="expiryYear" form="checkoutForm" name="expiryYear" required>
                                    <option value="">Year</option>
                                    <option value="2025">2025</option>
                                    <option value="2026">2026</option>
                                    <option value="2027">2027</option>
                                    <option value="2028">2028</option>
                                    <option value="2029">2029</option>
                                    <option value="2030">2030</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="cvv" class="form-label">CVV</label>
                                <input type="text" class="form-control" id="cvv" form="checkoutForm" name="cvv" required>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <!-- Order Summary -->
                    <div class="checkout-summary">
                        <h4 class="mb-3">Order Summary</h4>
                        <div id="checkoutItems">
                            <!-- Checkout items will be loaded here by JavaScript -->
                        </div>
                        
                        <div class="d-grid gap-2 mt-4">
                            <button type="submit" form="checkoutForm" class="btn btn-primary">
                                <i class="fas fa-lock me-2"></i> Complete Booking
                            </button>
                            <a href="order-cart.jsp" class="btn btn-outline-secondary">
                                <i class="fas fa-arrow-left me-2"></i> Back to Cart
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Update cart count on page load
            document.addEventListener('DOMContentLoaded', function() {
                updateCartCount();
                loadCheckoutItems();
                
                // Set cart items as JSON in hidden input
                const cart = JSON.parse(localStorage.getItem('flightCart')) || [];
                document.getElementById('cartItems').value = JSON.stringify(cart);
            });

            // Function to update cart count
            function updateCartCount() {
                const cart = JSON.parse(localStorage.getItem('flightCart')) || [];
                const countElement = document.querySelector('.cart-count');
                if (countElement) {
                    countElement.textContent = cart.length;
                }
            }

            // Function to load checkout items
            function loadCheckoutItems() {
                const checkoutContainer = document.getElementById('checkoutItems');
                if (!checkoutContainer) return;

                const cart = JSON.parse(localStorage.getItem('flightCart')) || [];

                if (cart.length === 0) {
                    checkoutContainer.innerHTML = `
                        <div class="text-center p-3">
                            <p>No items in your cart</p>
                            <a href="order" class="btn btn-sm btn-primary">Search Flights</a>
                        </div>
                    `;
                    return;
                }

                let html = '';
                let totalAmount = 0;
                
                cart.forEach((item, index) => {
                    // Convert price string to number (remove formatting)
                    const priceValue = parseFloat(item.price.replace(/[^0-9.-]+/g, ""));
                    totalAmount += priceValue;
                    
                    html += `
                        <div class="checkout-item">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <h6 class="mb-1">${item.name}</h6>
                                    <p class="text-muted mb-0">Ticket Type: ${item.ticketType}</p>
                                </div>
                                <div class="text-end">
                                    <div class="price-display">${item.price} VND</div>
                                </div>
                            </div>
                        </div>
                    `;
                });
                
                // Add total row
                html += `
                    <div class="total-row d-flex justify-content-between">
                        <div>
                            <h5 class="mb-0">Total</h5>
                        </div>
                        <div class="text-end">
                            <div class="price-display">${totalAmount} VND</div>
                        </div>
                    </div>
                `;
                
                checkoutContainer.innerHTML = html;
                
                // Set total amount in hidden input
                document.getElementById('totalAmount').value = totalAmount;
            }

            // Format currency
            function formatCurrency(value) {
                return new Intl.NumberFormat('vi-VN').format(value);
            }
        </script>
    </body>
</html>