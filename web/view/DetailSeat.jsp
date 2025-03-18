<%-- 
    Document   : DetailSeat
    Created on : Mar 16, 2025, 10:44:30 PM
    Author     : tungn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Detail Seat</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        .container {
            width: 60%;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
        }

        p {
            font-size: 16px;
            margin: 10px 0;
        }

        input {
            width: 95%;
            padding: 8px;
            margin-top: 5px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #f9f9f9;
        }

        input:disabled {
            background-color: #e9e9e9;
        }

        .button {
            display: inline-block;
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            margin-top: 20px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 16px;
        }

        .button:hover {
            background-color: #45a049;
        }

        a {
            text-decoration: none;
            color: #333;
            font-weight: bold;
            margin-top: 20px;
            display: inline-block;
        }

        a:hover {
            color: #4CAF50;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Detail Seat</h2>
        <p>Seat ID</p>
        <input name="id" value="${seat.id}" disabled>

        <p>Compartment ID</p>
        <input name="compartmentID" value="${seat.compartment.id}" disabled>

        <p>Compartment Name</p>
        <input name="compartmentName" value="${seat.compartment.name}" disabled>

        <p>Status</p>
        <input name="status" value="${seat.status}" disabled>

        <p>Type ID</p>
        <input name="typeID" value="${seat.compartment.type.id}" disabled>

        <a href="javascript:history.back()" class="button">Back</a>
    </div>
</body>
</html>
