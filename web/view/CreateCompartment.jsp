<%-- 
    Document   : CreateCompartment
    Created on : Mar 9, 2025, 1:30:37 PM
    Author     : tungn
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Compartments</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            body {
                background: linear-gradient(135deg, #1a2a6c, #b21f1f, #fdbb2d);
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                color: white;
            }

            .container {
                background: rgba(0, 0, 0, 0.85);
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 0 15px rgba(255, 255, 255, 0.2);
                max-width: 450px;
            }

            h2 {
                text-align: center;
                font-weight: bold;
                color: #fdbb2d;
                margin-bottom: 20px;
            }

            label {
                font-weight: bold;
                font-size: 14px;
                color: #ddd;
                display: block;
                margin-bottom: 5px;
            }

            .form-control {
                background: rgba(255, 255, 255, 0.1);
                border: 1px solid rgba(255, 255, 255, 0.3);
                color: white;
                padding: 12px;
                border-radius: 10px;
                transition: 0.3s ease-in-out;
                font-size: 14px;
            }

            .form-control:focus {
                background: rgba(255, 255, 255, 0.2);
                border-color: #fdbb2d;
                outline: none;
            }

            .form-group {
                margin-bottom: 15px;
            }

            button {
                width: 100%;
                padding: 12px;
                font-size: 16px;
                font-weight: bold;
                border: none;
                border-radius: 8px;
                background: #fdbb2d;
                color: black;
                transition: 0.3s ease-in-out;
                margin-top: 10px;
            }

            button:hover {
                background: #ffcc00;
                transform: scale(1.05);
                box-shadow: 0 0 10px rgba(255, 204, 0, 0.5);
            }

            .input-wrapper {
                display: flex;
                flex-direction: column;
                gap: 8px;
            }

            .form-header {
                text-align: center;
                padding: 15px;
                background: rgba(255, 255, 255, 0.1);
                border-radius: 10px;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <div class="form-header">
                <h2>Tạo Khoang & Ghế ${airplaneID}</h2>
            </div>

            <form action="CreateCompartment" method="post">
                <div class="form-group">
                    <label for="airplaneID">✈️ Mã máy bay:</label>
                    <input type="text" id="airplaneID" name="airplaneID" class="form-control" value="${airplaneID}" required>
                </div>

                <div class="form-group">
                    <label for="business">💼 Số ghế khoang Business (B):</label>
                    <input type="number" id="business" name="business" class="form-control" min="1" max="50" required>
                </div>

                <div class="form-group">
                    <label for="first">👑 Số ghế khoang First Class (F):</label>
                    <input type="number" id="first" name="first" class="form-control" min="1" max="50" required>
                </div>

                <div class="form-group">
                    <label for="economy">🛫 Số ghế khoang Economy (E):</label>
                    <input type="number" id="economy" name="economy" class="form-control" min="1" max="50" required>
                </div>

                <button type="submit">🚀 Tạo khoang và ghế</button>
            </form>
        </div>
    </body>
</html>
