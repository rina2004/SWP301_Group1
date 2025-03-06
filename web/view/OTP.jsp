<%-- 
    Document   : OTP
    Created on : Feb 28, 2025, 2:34:35 PM
    Author     : tungn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Xác nhận Email</title>
        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
                font-family: "Poppins", sans-serif;
            }

            body {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background: linear-gradient(135deg, #007bff, #00d4ff);
            }

            form {
                background: white;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.15);
                text-align: center;
                width: 400px;
                animation: fadeIn 0.5s ease-in-out;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            p {
                font-size: 16px;
                color: #333;
                font-weight: 600;
                padding-top: 10px;
            }

            .otp-box {
                display: flex;
                justify-content: center;
                gap: 12px;
                margin-top: 15px;
            }

            .otp-box input {
                width: 50px;
                height: 50px;
                text-align: center;
                font-size: 22px;
                font-weight: bold;
                border: none;
                border-radius: 10px;
                background: #f3f3f3;
                box-shadow: 0px 3px 6px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease-in-out;
                outline: none;
            }

            .otp-box input:focus {
                background: white;
                box-shadow: 0px 0px 10px rgba(0, 123, 255, 0.7);
                transform: scale(1.1);
            }

            #mail{
                width: 300px;
            }
            
            button {
                width: 100%;
                padding: 12px;
                background: linear-gradient(135deg, #007bff, #0056b3);
                color: white;
                font-size: 18px;
                font-weight: bold;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                transition: all 0.3s ease-in-out;
                margin-top: 20px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            }

            button:hover {
                background: linear-gradient(135deg, #0056b3, #004099);
                transform: scale(1.05);
            }

            button:active {
                transform: scale(0.95);
            }

            a {
                display: block;
                margin-top: 15px;
                text-decoration: none;
                color: #007bff;
                font-size: 14px;
                font-weight: 600;
            }

            a:hover {
                text-decoration: underline;
                color: #0056b3;
            }

            .error-msg {
                font-size: 14px;
                color: red;
                margin-top: 10px;
            }
        </style>
    </head>
    <body>
        <form id="otpForm" action="<%= request.getContextPath() %>/confirm" method="post" onsubmit="updateHiddenOtp()">
            <p>Email</p>
            <input id="mail" type="text" name="email" value="<%=session.getAttribute("email") != null ? session.getAttribute("email") : "" %>" readonly>
            <p>Nhập mã OTP</p>
            <div class="otp-box">
                <input type="text" id="otp1" maxlength="1" required oninput="moveNext(this, 'otp2')">
                <input type="text" id="otp2" maxlength="1" required oninput="moveNext(this, 'otp3')" onkeydown="movePrev(event, 'otp1')">
                <input type="text" id="otp3" maxlength="1" required oninput="moveNext(this, 'otp4')" onkeydown="movePrev(event, 'otp2')">
                <input type="text" id="otp4" maxlength="1" required oninput="moveNext(this, 'otp5')" onkeydown="movePrev(event, 'otp3')">
                <input type="text" id="otp5" maxlength="1" required oninput="moveNext(this, 'otp6')" onkeydown="movePrev(event, 'otp4')">
                <input type="text" id="otp6" maxlength="1" required onkeydown="movePrev(event, 'otp5')">
                
            </div>
            <br>
            <input type="hidden" id="otp" name="otp"> 
            <p>${otpInvalid}</p>
            <a href="<%= request.getContextPath() %>/resend?frompage=view/OTP.jsp">Gửi lại mã OTP</a>
            <button type="submit">Xác nhận</button><br>
            <a href="<%= request.getContextPath() %>/register">Quay lại</a>
        </form>

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
