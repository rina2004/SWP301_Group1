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
            .otp-box {
                display: flex;
                justify-content: center;
                gap: 5px;
            }

            .otp-box input {
                width: 40px;
                height: 40px;
                text-align: center;
                font-size: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
        </style>
    </head>
    <body>
        <form id="otpForm" action="confirmEmail" method="post" onsubmit="updateHiddenOtp()">
            <p>Email</p>
            <input type="text" name="email" value="<%=session.getAttribute("email") != null ? session.getAttribute("email") : "" %>" readonly>
            <div class="otp-box">
                <input type="text" id="otp1" maxlength="1" required oninput="moveNext(this, 'otp2')">
                <input type="text" id="otp2" maxlength="1" required oninput="moveNext(this, 'otp3')" onkeydown="movePrev(event, 'otp1')">
                <input type="text" id="otp3" maxlength="1" required oninput="moveNext(this, 'otp4')" onkeydown="movePrev(event, 'otp2')">
                <input type="text" id="otp4" maxlength="1" required oninput="moveNext(this, 'otp5')" onkeydown="movePrev(event, 'otp3')">
                <input type="text" id="otp5" maxlength="1" required oninput="moveNext(this, 'otp6')" onkeydown="movePrev(event, 'otp4')">
                <input type="text" id="otp6" maxlength="1" required onkeydown="movePrev(event, 'otp5')">
                <p>${otpInvalid}</p>
            </div>
            <br>
            <input type="hidden" id="otp" name="otp"> 
            <button type="submit">Xác nhận</button><br>
            <a href="Register.jsp">Quay lại</a>
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
