<%-- 
    Document   : cart
    Created on : 3 Mar 2025, 15:02:15
    Author     : A A
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Flight Cart | Flight Booking</title>
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
            .price-display {
                font-size: 1.5rem;
                font-weight: bold;
                color: #2563eb;
            }

            /* Toast notification */
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

            /* Cart button */
            .cart-count {
                font-size: 0.65rem;
                transform: translate(-50%, -50%) !important;
            }

            /* Empty cart styling */
            .empty-cart-icon {
                font-size: 4rem;
                color: #6c757d;
                margin-bottom: 1rem;
            }

            /* Cart page styling */
            .cart-container {
                max-width: 800px;
                margin: 0 auto;
            }

            .cart-header {
                margin-bottom: 2rem;
            }

            .cart-summary {
                background-color: #f8f9fa;
                border-radius: 8px;
                padding: 1.5rem;
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
                        <a href="order-cart.jsp" class="btn btn-primary position-relative">
                            <i class="fas fa-shopping-cart"></i> Cart
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger cart-count">
                                0
                            </span>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="container cart-container">
            <div class="cart-header">
                <h3><i class="fas fa-shopping-cart me-2"></i> Your Flight Cart</h3>
                <p class="text-muted">Review your selected flights before proceeding to booking</p>
            </div>

            <div id="cartItems">
                <!-- Cart items will be loaded here by JavaScript -->
            </div>

            <div class="d-flex justify-content-between mt-4">
                <a href="order" class="btn btn-outline-primary">
                    <i class="fas fa-arrow-left me-2"></i> Continue Shopping
                </a>
                <a href="order-checkout.jsp" class="btn btn-success" id="checkoutBtn">
                    <i class="fas fa-check-circle me-2"></i> Checkout All Items
                </a>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Update the loadCartItems function in order-cart.jsp to correctly handle the Proceed Booking button

function loadCartItems() {
    const cartContainer = document.getElementById('cartItems');
    if (!cartContainer) return;

    const cart = JSON.parse(localStorage.getItem('flightCart')) || [];

    if (cart.length === 0) {
        cartContainer.innerHTML = `
            <div class="text-center p-5">
                <i class="fas fa-shopping-cart fa-3x mb-3 text-muted"></i>
                <h4>Your cart is empty</h4>
                <p>Add flights to your cart to proceed with booking</p>
                <a href="order" class="btn btn-primary mt-3">
                    <i class="fas fa-search me-2"></i> Search Flights
                </a>
            </div>
        `;
        return;
    }

    let html = '';
    cart.forEach((item, index) => {
        html += `
            <div class="card mb-3">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="card-title">${item.name}</h5>
                            <p class="card-text mb-0">Ticket Type: ${item.ticketType}</p>
                        </div>
                        <div class="text-end">
                            <div class="price-display">${item.price} VND</div>
                            <div class="action-buttons mt-2">
                                <button onclick="proceedToBooking('${item.id}', '${item.ticketType}')" class="btn btn-primary btn-sm">
                                    <i class="fas fa-user me-1"></i> Proceed Booking
                                </button>
                                <button onclick="removeFromCart(${index})" class="btn btn-danger btn-sm ms-2">
                                    <i class="fas fa-trash me-1"></i> Remove
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        `;
    });

    cartContainer.innerHTML = html;
}

// Add this new function to handle the proceed to booking action
function proceedToBooking(flightId, ticketType) {
    // Redirect to booking confirmation page with parameters
    window.location.href = `order-confirm?flightId=${flightId}&ticketClass=${ticketType}&passengers=1`;
}
            // Initialize cart in localStorage if it doesn't exist
            if (!localStorage.getItem('flightCart')) {
                localStorage.setItem('flightCart', JSON.stringify([]));
            }

            // Update cart count on page load
            document.addEventListener('DOMContentLoaded', function () {
                updateCartCount();
                loadCartItems();

                // Update checkout button visibility
                const cart = JSON.parse(localStorage.getItem('flightCart')) || [];
                const checkoutBtn = document.getElementById('checkoutBtn');
                if (checkoutBtn) {
                    checkoutBtn.style.display = cart.length === 0 ? 'none' : 'block';
                }
            });

            // Function to update cart count
            function updateCartCount() {
                const cart = JSON.parse(localStorage.getItem('flightCart')) || [];
                const countElement = document.querySelector('.cart-count');
                if (countElement) {
                    countElement.textContent = cart.length;
                }
            }

            // Function to show notification
            function showNotification(message) {
                // Create notification element
                const notification = document.createElement('div');
                notification.classList.add('toast-notification');
                notification.innerHTML = `
                    <div class="toast-content">
                        <i class="fas fa-check-circle me-2"></i>
            ${message}
                    </div>
                `;

                // Add to document
                document.body.appendChild(notification);

                // Show notification
                setTimeout(() => {
                    notification.classList.add('show');
                }, 100);

                // Hide after 3 seconds
                setTimeout(() => {
                    notification.classList.remove('show');
                    setTimeout(() => {
                        document.body.removeChild(notification);
                    }, 300);
                }, 3000);
            }

            // Function to remove item from cart
            function removeFromCart(index) {
                let cart = JSON.parse(localStorage.getItem('flightCart')) || [];
                cart.splice(index, 1);
                localStorage.setItem('flightCart', JSON.stringify(cart));

                // Refresh the cart page
                loadCartItems();
                updateCartCount();

                // Update checkout button visibility
                const checkoutBtn = document.getElementById('checkoutBtn');
                if (checkoutBtn) {
                    checkoutBtn.style.display = cart.length === 0 ? 'none' : 'block';
                }

                showNotification('Flight removed from cart');
            }

            // Function to load cart items
            function loadCartItems() {
                const cartContainer = document.getElementById('cartItems');
                if (!cartContainer)
                    return;

                const cart = JSON.parse(localStorage.getItem('flightCart')) || [];

                if (cart.length === 0) {
                    cartContainer.innerHTML = `
                        <div class="text-center p-5">
                            <i class="fas fa-shopping-cart fa-3x mb-3 text-muted"></i>
                            <h4>Your cart is empty</h4>
                            <p>Add flights to your cart to proceed with booking</p>
                            <a href="order" class="btn btn-primary mt-3">
                                <i class="fas fa-search me-2"></i> Search Flights
                            </a>
                        </div>
                    `;
                    return;
                }

                let html = '';
                cart.forEach((item, index) => {
                    html += `
                        <div class="card mb-3">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h5 class="card-title">${item.name}</h5>
                                        <p class="card-text mb-0">Ticket Type: ${item.ticketType}</p>
                                    </div>
                                    <div class="text-end">
                                        <div class="price-display">${item.price} VND</div>
                                        <div class="action-buttons mt-2">
                                            <a href="order-confirm?flightId=${item.id}&ticketClass=${item.ticketType}&passengers=1" class="btn btn-primary btn-sm">
                                                <i class="fas fa-user me-1"></i> Proceed Booking
                                            </a>
                                            <button onclick="removeFromCart(${index})" class="btn btn-danger btn-sm ms-2">
                                                <i class="fas fa-trash me-1"></i> Remove
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    `;
                });

                cartContainer.innerHTML = html;
            }

            // Format currency
            function formatCurrency(value) {
                return new Intl.NumberFormat('vi-VN').format(value);
            }
            // Function to add flight to cart
            function addToCart(id, name, price, ticketType) {
// Get current cart from localStorage
                let cart = JSON.parse(localStorage.getItem('flightCart')) || [];

// Check if the flight is already in the cart
                const existingItem = cart.find(item => item.id === id && item.ticketType === ticketType);

                if (existingItem) {
                    // Show notification that item is already in cart
                    showNotification('This flight is already in your cart');
                } else {
                    // Add new item to cart
                    cart.push({
                        id: id,
                        name: name,
                        price: formatCurrency(price),
                        ticketType: ticketType
                    });

                    // Save updated cart to localStorage
                    localStorage.setItem('flightCart', JSON.stringify(cart));

                    // Update cart count
                    updateCartCount();

                    // Show success notification
                    showNotification('Flight added to cart successfully');
                }
            }

// Format currency (this function already exists, but included for reference)
            function formatCurrency(value) {
                return new Intl.NumberFormat('vi-VN').format(value);
            }
        </script>
    </body>
</html> 