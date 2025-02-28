<%-- 
    Document   : Otp
    Created on : Feb 22, 2025, 8:47:36 PM
    Author     : tungn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Xác nhận Email</title>
       <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f4f4f4;
            font-family: Arial, sans-serif;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 320px;
        }
        .otp-box {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin: 15px 0;
        }
        .otp-box input {
            width: 40px;
            height: 40px;
            text-align: center;
            font-size: 18px;
            border: 2px solid #ccc;
            border-radius: 5px;
            outline: none;
            transition: 0.3s;
        }
        .otp-box input:focus {
            border-color: #007bff;
        }
        .error-message {
            color: red;
            font-size: 14px;
            height: 20px;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }
        button:hover {
            background-color: #0056b3;
        }
        a {
            display: block;
            margin-top: 10px;
            color: #007bff;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Xác nhận Email</h2>
        <form id="otpForm" action="confirmEmail" method="post" onsubmit="updateHiddenOtp()">
            <p>Email</p>
            <input type="text" name="email" value="<%= session.getAttribute("email") != null ? session.getAttribute("email") : "" %>" readonly>
            <div class="otp-box">
                <input type="text" id="otp1" maxlength="1" required oninput="moveNext(this, 'otp2')">
                <input type="text" id="otp2" maxlength="1" required oninput="moveNext(this, 'otp3')" onkeydown="movePrev(event, 'otp1')">
                <input type="text" id="otp3" maxlength="1" required oninput="moveNext(this, 'otp4')" onkeydown="movePrev(event, 'otp2')">
                <input type="text" id="otp4" maxlength="1" required oninput="moveNext(this, 'otp5')" onkeydown="movePrev(event, 'otp3')">
                <input type="text" id="otp5" maxlength="1" required oninput="moveNext(this, 'otp6')" onkeydown="movePrev(event, 'otp4')">
                <input type="text" id="otp6" maxlength="1" required onkeydown="movePrev(event, 'otp5')">
            </div>
            <p class="error-message">${otpInvalid}</p>
            <input type="hidden" id="otp" name="otp"> 
            <button type="submit">Xác nhận</button>
            <a href="register.jsp">Quay lại</a>
        </form>
    </div>
    <script>
        function moveNext(current, nextId) {
            let value = current.value.replace(/\D/g, "");
            current.value = value;
            if (value && nextId) {
                document.getElementById(nextId).focus();
            }
            updateHiddenOtp();
        }

        function movePrev(event, prevId) {
            if (event.key === "Backspace" && !event.target.value) {
                document.getElementById(prevId).focus();
            }
        }

        function updateHiddenOtp() {
            let otp = "";
            for (let i = 1; i <= 6; i++) {
                otp += document.getElementById("otp" + i).value;
            }
            document.getElementById("otp").value = otp;
        }
    </script>
</body>
</html>

