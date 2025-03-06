<%-- 
    Document   : account-details
    Created on : 3 Mar 2025, 11:54:24
    Author     : A A
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Account Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link rel="icon" type="image/png" href="img/logo.jpg">
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
            .account-container {
                background: white;
                border-radius: 12px;
                box-shadow: 0 4px 16px rgba(0,0,0,0.08);
                padding: 2rem;
                margin-top: 2rem;
                margin-bottom: 2rem;
            }
            .btn-update {
                background-color: #0064d2;
                color: white;
                font-weight: 600;
                padding: 0.8rem 2rem;
                border-radius: 8px;
                border: none;
                transition: all 0.3s ease;
            }
            .btn-update:hover {
                background-color: #0051a8;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }
            .readonly-field {
                background-color: #f8f9fa;
            }
        </style>
    </head>
    <body>
        <!-- Display success message if available -->
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="alert alert-success text-center">
                ${sessionScope.successMessage}
            </div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>
        
        <!-- Header Section -->
        <div class="header-section">
            <div class="container">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="d-flex align-items-center">
                        <img src="img/art.jpg" alt="Logo" class="me-2" style="height: 40px;">
                        <h2 class="mb-0">Sky Airline</h2>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Account Details Container -->
        <div class="container">
            <div class="account-container">
                <h3 class="mb-4 text-primary">Account Details</h3>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        ${error}
                    </div>
                </c:if>
                
                <form action="view-account" method="post">
                    <div class="mb-3">
                        <label for="fullName" class="form-label">Full Name</label>
                        <input type="text" class="form-control readonly-field" id="fullName" value="${account.fullName}" readonly>
                        <small class="text-muted">Name cannot be changed</small>
                    </div>
                    
                    <div class="mb-3">
                        <label for="citizenId" class="form-label">Citizen ID</label>
                        <input type="text" class="form-control readonly-field" id="citizenId" value="${account.citizenId}" readonly>
                        <small class="text-muted">Citizen ID cannot be changed</small>
                    </div>
                    
                    <div class="mb-3">
                        <label for="email" class="form-label">Email Address</label>
                        <input type="email" class="form-control" id="email" name="email" value="${account.email}" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="phone" class="form-label">Phone Number</label>
                        <input type="tel" class="form-control" id="phone" name="phone" value="${account.phone}" required>
                        <small class="text-muted">Format: 0xxxxxxxxx or +84xxxxxxxxx</small>
                    </div>
                    
                    <div class="d-flex justify-content-between mt-4">
                        <a href="search-flights" class="btn btn-secondary">
                            <i class="fas fa-arrow-left me-2"></i> Back to Flights
                        </a>
                        <button type="submit" class="btn btn-update">
                            <i class="fas fa-check me-2"></i> Update Information
                        </button>
                    </div>
                </form>
            </div>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>