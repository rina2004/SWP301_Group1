<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Airplane</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f9f9f9;
                margin: 0;
                padding: 0;
            }

            .header-section {
                background: #ffffff;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                padding: 1rem 2rem;
                position: sticky;
                top: 0;
                z-index: 1000;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .header-section .back-btn {
                font-size: 1.2rem;
                color: #0056b3;
                text-decoration: none;
                margin-right: 0.5rem;
                transition: color 0.3s;
            }

            .header-section .back-btn:hover {
                color: #004494;
            }

            .header-section h2 {
                font-size: 1.8rem;
                color: #0056b3;
                margin: 0;
            }

            .form-container {
                max-width: 600px;
                margin: 2rem auto;
                background: #ffffff;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                padding: 2rem;
                border-radius: 8px;
            }

            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-group label {
                display: block;
                font-weight: bold;
                margin-bottom: 0.5rem;
            }

            .form-group select,
            .form-group input {
                width: 100%;
                padding: 0.8rem;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 1rem;
                box-sizing: border-box;
            }

            .form-group select:focus,
            .form-group input:focus {
                border-color: #0056b3;
                outline: none;
            }

            .btn {
                display: inline-block;
                padding: 0.8rem 1.5rem;
                font-size: 1rem;
                color: #ffffff;
                background-color: #0056b3;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-align: center;
                text-decoration: none;
                transition: background-color 0.3s ease;
            }

            .btn:hover {
                background-color: #004494;
            }

            .error-message {
                color: red;
                margin-bottom: 1.5rem;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <!-- Header Section -->
        <div class="header-section">
            <a href="<%= request.getContextPath() %>/airplane/view" class="back-btn">←</a>
            <h2>Update Airplane</h2>
        </div>

        <!-- Form Container -->
        <div class="form-container">
            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>

            <form action="<%= request.getContextPath() %>/airplane/update" method="POST">
                <input type="hidden" name="id" value="${airplane.id}">

                <!-- Display ID -->
                <div class="form-group">
                    <label>ID:</label>
                    <div>${airplane.id}</div>
                </div>

                <!-- Display Name -->
                <div class="form-group">
                    <label>Name:</label>
                    <div>${airplane.name}</div>
                </div>

                <!-- Display Type -->
                <div class="form-group">
                    <label>Type:</label>
                    <div>${airplane.type.name}</div>
                </div>

                <!-- Status -->
                <div class="form-group">
                    <label for="status">Status:</label>
                    <select id="status" name="status" required>
                        <c:forEach items="${statuses}" var="s">
                            <option value="${s.id}" ${s.id == airplane.status.id ? 'selected' : ''}>
                                ${s.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Maintenance Time -->
                <div class="form-group">
                    <label for="maintainanceTime">Maintenance Time:</label>
                    <input type="datetime-local" id="maintainanceTime" name="maintainanceTime" 
                           value="${airplane.maintainanceTime}" required>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn">Update Airplane</button>
            </form>
        </div>
    </body>
</html>
