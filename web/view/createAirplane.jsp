<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
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
            text-align: right;
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
        .btn-back {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background-color: #0056b3;
            color: white;
            border-radius: 50%;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .btn-back:hover {
            background-color: #004494;
        }

        .btn-back i {
            font-size: 16px;
        }
    </style>
</head>
<body>
    <div class="header-section">
        <div class="container">
            <h2>Create Airplane</h2>
            <a href="<%= request.getContextPath() %>/airplane/view" class="btn-back">
                <i class="fas fa-arrow-left"></i>
            </a>
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
