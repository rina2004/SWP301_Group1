<%-- 
    Document   : UpdateSeat
    Created on : Mar 16, 2025, 9:13:23 PM
    Author     : tungn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Seat</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f9;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                flex-direction: column; /* Thêm dòng này để các phần tử không bị nằm ngang */
            }

            h2 {
                color: #333;
                text-align: center;
                font-size: 24px;
                margin-bottom: 20px; /* Thêm khoảng cách giữa h2 và form */
            }

            form {
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                width: 300px;
                box-sizing: border-box;
            }

            label {
                font-size: 14px;
                color: #333;
                margin-bottom: 8px;
                display: block;
            }

            input[type="text"], select {
                width: 100%;
                padding: 8px;
                margin-bottom: 15px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 14px;
                box-sizing: border-box;
            }

            select {
                cursor: pointer;
            }

            button {
                width: 100%;
                padding: 10px;
                background-color: #4CAF50;
                color: white;
                font-size: 16px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            button:hover {
                background-color: #45a049;
            }

            input[disabled] {
                background-color: #f9f9f9;
            }
        </style>
    </head>
    <body>
        <h2>Update Seat ${seat.id}</h2>
        <form action="updateSeat" method="post">
            <input type="hidden" name="seatID" value="${seat.id}">

            <label>ID Seat:</label>
            <input type="text" value="${seat.id}" disabled><br>

            <label>Compartment:</label>
            <input type="text" value="${seat.compartment.name}" disabled><br>

            <label>TypeID:</label>
            <input type="text" name="typeID" value="${seat.compartment.type.id}" readonly><br>

            <label>Status:</label>
            <select name="status">
                <option value="Available" ${seat.status eq 'Available' ? 'selected' : ''}>Available</option>
                <option value="Booked" ${seat.status eq 'Booked' ? 'selected' : ''}>Booked</option>
                <option value="Maintained" ${seat.status eq 'Maintained' ? 'selected' : ''}>Maintained</option>
            </select><br>

            <button type="submit">Update</button>
            <a href = "listSeatByTypeID?id=${seat.compartment.type.id}">Back</a>
        </form>
    </body>
</html>
