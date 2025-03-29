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
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }

            h2 {
                margin-top: 20px;
                color: #333;
            }

            /* Layout chính */
            .plane-container {
                position: relative;
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            /* Layout ghế */
            .plane {
                display: grid;
                grid-template-columns: repeat(2, 60px) 40px repeat(2, 60px) 40px repeat(2, 60px); /* Lối đi rộng hơn */
                gap: 10px;
                justify-content: center;
                margin: 20px auto;
                background: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            /* Ghế ngồi */
            .seat {
                width: 60px;
                height: 60px;
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                transition: transform 0.2s ease, background-color 0.3s ease;
                font-size: 14px;
                font-weight: bold;
                border: 2px solid transparent;
            }

            /* Trạng thái ghế */
            .seat.Available {
                background-color: #4CAF50;
                color: white;
            }
            .seat.Booked {
                background-color: #FF4C4C;
                color: white;
                cursor: not-allowed;
            }
            .seat.Maintained {
                background-color: #808080;
                color: white;
                cursor: not-allowed;
            }
            .seat.selected {
                background-color: #FFD700 !important;
                border: 2px solid #000;
            }

            /* Hiệu ứng hover */
            .seat:not(.Booked, .Maintained):hover {
                transform: scale(1.1);
            }

            /* Lối đi */
            .aisle {
                width: 40px;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .aisle::before {
                content: "|||";
                color: #888;
                font-size: 20px;
            }

            /* Chú thích trạng thái ghế */
            .legend {
                position: fixed;
                right: 20px;
                top: 50px;
                background: white;
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

            /* Màu sắc ghế trong chú thích */
            .legend-item .seat.available {
                background-color: #4CAF50;
            }
            .legend-item .seat.booked {
                background-color: #FF4C4C;
            }
            .legend-item .seat.maintained {
                background-color: #808080;
            }

            /* Header & Footer máy bay */
            .plane-header, .plane-end {
                display: flex;
                justify-content: center;
                margin-bottom: -10px;
            }
            .plane-header img, .plane-end img {
                width: 850px;
                mix-blend-mode: multiply;
                opacity: 0.9;
            }

            /* Modal Popup */
            .modal {
                display: none; /* Đảm bảo modal ẩn khi trang load */
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.4);
                align-items: center;
                justify-content: center;
            }

            .modal-content {
                background-color: #fff;
                padding: 20px;
                border-radius: 10px;
                width: 300px;
                text-align: center;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);

                /* Căn giữa modal chính xác */
                position: absolute;
                left: 50%;
                top: 50%;
                transform: translate(-50%, -50%);
            }

            .close {
                color: #888;
                float: right;
                font-size: 24px;
                font-weight: bold;
                cursor: pointer;
            }
            .close:hover {
                color: black;
            }

            button {
                margin: 10px;
                padding: 10px;
                font-size: 16px;
                cursor: pointer;
                border: none;
                background-color: #4CAF50;
                color: white;
                border-radius: 5px;
            }
            button:hover {
                background-color: #45a049;
            }
        </style>
    </head>
    <body>

        <h2>Sơ Đồ Ghế Máy Bay ${id}</h2>

        <div class="plane-container">
            <div class="plane-header">
                <img src="img/ghe-ngoi-may-bay-vietjet-removebg-preview.png" alt="Đầu máy bay">
            </div>

            <div class="plane" id="plane">
                <c:forEach var="s" items="${seat}" varStatus="loop">
                    <c:if test="${loop.index % 6 == 2 || loop.index % 6 == 4}">
                        <div class="aisle"></div>
                    </c:if>
                    <div class="seat ${s.status}" data-seat-id="${s.id}" onclick="showSeatOptions('${s.id}')">
                        ${s.id}
                    </div>
                </c:forEach>
            </div>

            <div class="plane-end">
                <img src="img/so-do-cho-ngoi-may-bay-Vietjet-1-removebg-preview.png" alt="Đuôi máy bay">
            </div>
        </div>

        <div class="legend">
            <h3>Chú thích</h3>
            <div class="legend-item">
                <div class="seat available"></div><span>Available (Còn trống)</span>
            </div>
            <div class="legend-item">
                <div class="seat booked"></div><span>Booked (Đã đặt)</span>
            </div>
            <div class="legend-item">
                <div class="seat maintained"></div><span>Maintained (Bảo trì)</span>
            </div>
        </div>

        <!-- Modal Popup -->
        <div id="seatOptionsModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeModal()">&times;</span>
                <h2>Chọn một tùy chọn cho ghế</h2>
                <button onclick="redirectTo('updateSeats')">Cập nhật ghế</button>
                <button onclick="redirectTo('detailSeats')">Xem chi tiết</button>
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

            function redirectTo(action) {
                if (selectedSeatID) {
                    closeModal();
                    window.location.href = action + "?id=" + selectedSeatID;
                } else {
                    alert("Vui lòng chọn một ghế trước!");
                }
            }

            window.onclick = function (event) {
                if (event.target == document.getElementById("seatOptionsModal")) {
                    closeModal();
                }
            };
        </script>
    </body>
</html>


