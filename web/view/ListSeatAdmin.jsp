<%-- 
    Document   : ListSeat
    Created on : Mar 12, 2025, 1:47:35 PM
    Author     : tungn
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sơ Đồ Ghế Máy Bay</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                text-align: center;
                background-color: #ddd;
            }
            .plane {
                display: grid;
                grid-template-columns: repeat(2, 60px) 20px repeat(2, 60px) 20px repeat(2, 60px); /* 2 nhóm ghế + 2 lối đi */
                gap: 12px;
                justify-content: center;
                margin-top: 20px;
            }

            .seat {
                width: 60px;
                height: 60px;
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                transition: 0.3s;
                font-size: 10px;
                font-weight: bold;
            }

            /* Chưa đặt - Xanh lá */
            .seat.Available {
                background-color: #4CAF50 !important;
            }

            /* Đã đặt - Đỏ */
            .seat.Booked {
                background-color: #FF4C4C !important;
                cursor: not-allowed;
            }

            /* Bảo trì - Xám */
            .seat.Maintained {
                background-color: #808080 !important;
                cursor: not-allowed;
            }

            /* Đang chọn - Vàng */
            .seat.selected {
                background-color: #FFD700 !important;
            }

            .seat:hover {
                transform: scale(1.1);
            }
            .seat:hover {
                transform: scale(1.1);
            }

            .container {
                display: flex;
                justify-content: center;
                align-items: flex-start;
                gap: 40px;
                position: relative;
            }

            .legend {
                position: fixed;
                right: 20px;
                top: 50px;
                background: #fff;
                padding: 15px;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                font-size: 14px;
                z-index: 1000;
            }

            .legend h3 {
                margin-bottom: 10px;
                font-size: 16px;
            }

            .legend-item {
                display: flex;
                align-items: center;
                gap: 8px;
                margin-bottom: 8px;
            }

            .legend-item .seat {
                width: 20px;
                height: 20px;
                border-radius: 4px;
            }

            .seat.available {
                background-color: #4CAF50; /* Xanh lá - Còn trống */
            }

            .seat.booked {
                background-color: #FF4C4C; /* Đỏ - Đã đặt */
            }

            .seat.maintained {
                background-color: #808080; /* Xám - Bảo trì */
            }

            .aisle-top, .aisle-bottom {
                display: flex;
                justify-content: center;
                align-items: center;
            }

            /* Style lối đi */
            .aisle {
                width: 30px;
                display: grid;
                grid-template-rows: 1fr 1fr;
                align-items: center;
                justify-content: center;
            }
            .aisle-top{
                display: flex;
                justify-content: center;
                align-items: center;
            }
            .plane-container {
                position: relative;
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            /* Mũi tên nằm ngay trên hàng ghế đầu */
            .arrow-row {
                display: grid;
                grid-column: 1 / -1; /* Trải rộng hàng */
                grid-template-columns: repeat(2, 1fr); /* 2 ô cho 2 mũi tên */
                justify-content: center;
                gap: 40px; /* Khoảng cách giữa 2 mũi tên */
                margin-bottom: 10px; /* Đẩy xuống gần hàng ghế đầu */
            }

            /* Ô chứa mũi tên */
            .arrow-box {
                display: flex;
                justify-content: center;
                align-items: center;
            }

            /* Mũi tên chung */
            .arrow {
                font-size: 24px;
                font-weight: bold;
                color: gray;
            }

            /* Mũi tên trái/phải có hiệu ứng */
            .left {
                animation: arrowMoveLeft 1s infinite alternate;
            }

            .right {
                animation: arrowMoveRight 1s infinite alternate;
            }

            /* Hiệu ứng mũi tên trái/phải */
            @keyframes arrowMoveLeft {
                0% {
                    transform: translateX(-5px);
                    opacity: 0.3;
                }
                100% {
                    transform: translateX(5px);
                    opacity: 1;
                }
            }

            @keyframes arrowMoveRight {
                0% {
                    transform: translateX(5px);
                    opacity: 0.3;
                }
                100% {
                    transform: translateX(-5px);
                    opacity: 1;
                }
            }
            .plane-header {
                display: flex;
                justify-content: center;
                margin-bottom: -20px; /* Điều chỉnh để nó sát sơ đồ ghế */
            }

            .plane-header img {
                width: 850px;
                mix-blend-mode: multiply;
            }
            .plane-end {
                display: flex;
                justify-content: center;
                margin-bottom: -20px;
                position: relative;

            }

            .plane-end img {
                width: 850px;
                mix-blend-mode: multiply;
                opacity: 0.9; /* Giảm nhẹ độ đậm của ảnh */
            }
            .modal {
                display: none;
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgb(0, 0, 0);
                background-color: rgba(0, 0, 0, 0.4); /* Black with opacity */
            }

            .modal-content {
                background-color: #fefefe;
                margin: 15% auto;
                padding: 20px;
                border: 1px solid #888;
                width: 80%;
                text-align: center;
            }

            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }

            button {
                margin: 10px;
                padding: 10px;
                font-size: 16px;
                cursor: pointer;
            }

            button:hover {
                background-color: #ddd;
            }
        </style>
    </head>
    <body>
        <h2>Sơ Đồ Ghế Máy Bay ${id}</h2>
        <div class="plane-container">
            <!-- Hình đầu máy bay -->
            <div class="plane-header">
                <img src="img/ghe-ngoi-may-bay-vietjet-removebg-preview.png" alt="Đầu máy bay">
            </div>

            <div class="plane" id="plane">
                <!-- Mũi tên di chuyển hàng ghế -->
                <div class="arrow-row">
                    <div class="arrow-box">
                        <div class="arrow left">←</div>
                    </div>
                    <div class="arrow-box">
                        <div class="arrow right">→</div>
                    </div>
                </div>

                <c:forEach var="s" items="${seat}" varStatus="loop">
                    <!-- Chèn lối đi giữa -->
                    <c:if test="${loop.index % 6 == 2 || loop.index % 6 == 4}">
                        <div class="aisle">
                            <div class="aisle-top">
                                <div class="arrow up">↑</div>
                            </div>                   
                        </div>
                    </c:if>

                    <!-- Ghế ngồi -->
                    <div class="seat ${s.status eq 'Booked' ? 'Booked' : (s.status eq 'Maintained' ? 'Maintained' : 'Available')}" 
                         data-seat-id="${s.id}" onclick="showSeatOptions('${s.id}')">
                        ${s.id}
                    </div>
                </c:forEach>
            </div>

            <!-- Hình cuối máy bay -->
            <div class="plane-end">
                <img src="img/so-do-cho-ngoi-may-bay-Vietjet-1-removebg-preview.png" alt="Đầu máy bay">
            </div>
        </div>

        <div class="legend">
            <h3>Chú thích</h3>
            <div class="legend-item">
                <div class="seat available"></div>
                <span>Available (Còn trống)</span>
            </div>
            <div class="legend-item">
                <div class="seat booked"></div>
                <span>Booked (Đã đặt)</span>
            </div>
            <div class="legend-item">
                <div class="seat maintained"></div>
                <span>Maintained (Bảo trì)</span>
            </div>
        </div>

        <!-- Popup Modal for Seat Options -->
        <div id="seatOptionsModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeModal()">&times;</span>
                <h2>Chọn một tùy chọn cho ghế</h2>
                <button id="updateSeatButton">Update Seat</button>
                <button id="viewDetailButton">View Detail</button>
            </div>
        </div>

        <script>
            let selectedSeatID = "";

            function showSeatOptions(seatID) {
                selectedSeatID = seatID; // Lưu lại ID ghế
                document.getElementById("seatOptionsModal").style.display = "block";
            }

            function closeModal() {
                document.getElementById("seatOptionsModal").style.display = "none";
            }

            document.getElementById("updateSeatButton").onclick = function () {
                window.location.href = "updateSeat?id=" + selectedSeatID;
                closeModal(); // Đóng modal
            };

            document.getElementById("viewDetailButton").onclick = function () {
                window.location.href = "detailSeat?id=" + selectedSeatID;
                closeModal(); // Đóng modal
            };

            // Đóng modal nếu click ra ngoài modal
            window.onclick = function (event) {
                if (event.target == document.getElementById("seatOptionsModal")) {
                    closeModal();
                }
            }
        </script>
    </body>
</html>


