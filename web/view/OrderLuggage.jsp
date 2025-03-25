<%-- 
    Document   : Order Luggage
    Created on : Mar 24, 2025, 9:08:10 AM
    Author     : tungn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Extra Luggage</title>
       <style>
        /* Reset mặc định */
        * {
            box-sizing: border-box;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        /* Căn giữa toàn bộ nội dung */
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #eef2f3;
        }

        /* Hộp chứa nội dung */
        .container {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 360px;
            text-align: center;
        }

        h2 {
            margin-bottom: 15px;
            color: #333;
            font-size: 22px;
        }

        /* Ô nhập liệu */
        input[type="text"], select {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background: #f9f9f9;
            text-align: center;
            font-size: 14px;
            font-weight: bold;
            color: #333;
        }

        /* Dropdown chọn loại hành lý */
        select {
            cursor: pointer;
        }

        /* Radio buttons */
        .radio-group {
            text-align: left;
            margin-top: 10px;
        }

        label {
            display: flex;
            align-items: center;
            background: #f8f9fa;
            padding: 10px;
            margin-bottom: 8px;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        label:hover {
            background: #e2e6ea;
        }

        input[type="radio"] {
            margin-right: 10px;
            transform: scale(1.2);
            accent-color: #28a745; /* Đổi màu radio button */
        }

        /* Nút submit */
        input[type="submit"] {
            background: #28a745;
            color: white;
            border: none;
            padding: 12px;
            width: 100%;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: background 0.3s ease;
        }

        input[type="submit"]:hover {
            background: #218838;
        }

        /* Hiệu ứng khi nhấn */
        input[type="submit"]:active {
            transform: scale(0.98);
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Order Extra Luggage</h2>
        <form action="orderLuggage" method="post">
            <input type="hidden" name="customerID" value="${sessionScope.Accid}" readonly>

            <input type="text" name="ticketID" value="${id}" readonly>

            <select name="type">
                <option>Carry-on</option>
                <option>Checked</option>
            </select>

            <div class="radio-group">
                <label>
                    <input type="radio" name="luggagePackage" value="10,200000"> 10kg - 200,000 VNĐ
                </label>
                <label>
                    <input type="radio" name="luggagePackage" value="20,350000"> 20kg - 350,000 VNĐ
                </label>
                <label>
                    <input type="radio" name="luggagePackage" value="30,500000"> 30kg - 500,000 VNĐ
                </label>
                <label>
                    <input type="radio" name="luggagePackage" value="40,600000"> 40kg - 600,000 VNĐ
                </label>
                <label>
                    <input type="radio" name="luggagePackage" value="50,700000"> 50kg - 700,000 VNĐ
                </label>
            </div>

            <input type="submit" value="Pay Now">
        </form>
    </div>

</body>
</html>