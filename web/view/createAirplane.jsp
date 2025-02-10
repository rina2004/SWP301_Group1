<%-- 
    Document   : createAirplane
    Created on : 10 Feb 2025, 03:02:27
    Author     : Rinaaaa
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <title>Create Airplane</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f9ff;
            color: #333;
        }

        .header-section {
            background: #ffffff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 1rem 2rem;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .header-section h2 {
            font-size: 1.8rem;
            color: #0056b3;
            margin: 0;
        }

        .btn-secondary {
            background-color: #0056b3;
            color: #fff;
            padding: 0.5rem 1rem;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .btn-secondary:hover {
            background-color: #004494;
        }

        form {
            max-width: 600px;
            margin: 2rem auto;
            padding: 2rem;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
        }

        input, select, button {
            width: 100%;
            padding: 0.75rem;
            margin-bottom: 1rem;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1rem;
        }

        input:focus, select:focus {
            border-color: #0056b3;
            outline: none;
        }

        button {
            background-color: #0056b3;
            color: #fff;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #004494;
        }

        .error-message {
            color: red;
            margin-bottom: 1rem;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="header-section">
        <div class="container d-flex align-items-center justify-content-between">
            <div class="d-flex align-items-center">
                <a href="<%= request.getContextPath() %>/airplane/view" class="back-btn">
                    <i style="display:flex; align-items: center; justify-content: flex-end; color: #DBF8FE" class="fa-solid fa-arrow-right-to-bracket fa-rotate-180 fa-xl"></i>
                </a>
                <h2 style="display: flex; align-items: center; justify-content: center" class="title">Create Airplane</h2>
            </div>
        </div>
    </div>


    <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
    </c:if>

    <form action="<%= request.getContextPath() %>/airplane/create" method="POST">
        <label for="name">Airplane Name:</label>
        <input type="text" id="name" name="name" required>
        
        <label for="type">Type:</label>
        <select id="type" name="type" required>
            <c:forEach items="${types}" var="t">
                <option value="${t.id}">${t.name}</option>
            </c:forEach>
        </select>

        <label for="status">Status:</label>
        <select id="status" name="status" required>
            <c:forEach items="${statuses}" var="s">
                <option value="${s.id}">${s.name}</option>
            </c:forEach>
        </select>

        <label for="maintainanceTime">Maintenance Time:</label>
        <input type="datetime-local" id="maintainanceTime" name="maintainanceTime" required>

        <label for="usedTime">Used Time:</label>
        <input type="datetime-local" id="usedTime" name="usedTime" required>

        <label for="actID">Air Traffic Control:</label>
        <select id="actID" name="actID" required>
            <c:forEach items="${atcs}" var="a">
                <option value="${a.id}">${a.name}</option>
            </c:forEach>
        </select>

        <button type="submit">Add Airplane</button>
    </form>
</body>
</html>