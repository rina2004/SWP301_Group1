<%-- 
    Document   : ListSeatUser
    Created on : Mar 16, 2025, 11:54:16 PM
    Author     : tungn
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sơ Đồ Ghế Máy Bay ${id}</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                text-align: center;
                background-color: #ddd;
                margin: 0;
                padding: 20px;
                display: flex;
                justify-content: center;
            }

            .container {
                display: flex;
                justify-content: center; /* Canh giữa theo chiều ngang */
                align-items: flex-start;
                margin-left: 200px; /* Dịch sang phải */
            }

            .plane-container {
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .plane {
                display: grid;
                grid-template-columns: repeat(2, 60px) 30px repeat(2, 60px) 30px repeat(2, 60px);
                gap: 12px;
                justify-content: center;
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
                width: fit-content;
                background-color: #ddd;
            }

            .seat {
                width: 60px;
                height: 50px;
                text-align: center;
                line-height: 50px;
                border-radius: 5px;
                font-weight: bold;
                cursor: pointer;
                transition: background 0.3s ease, transform 0.2s ease;
                user-select: none;
                font-size: 10px;
                color: black;
            }

            /* Trạng thái ghế */
            .available {
                background-color: #4CAF50;
                color: white;
            }

            .available:hover {
                background-color: #45a049;
            }

            .booked {
                background-color: #FF0000;
                color: white;
                cursor: not-allowed;
            }

            .maintained {
                background-color: #808080;
                color: white;
                cursor: not-allowed;
            }

            .selected {
                background-color: #FFD700;
                color: black !important; /* Giữ chữ luôn đen */
                transform: scale(1.1);
            }

            .aisle {
                width: 30px;
            }

            /* Khu vực bên phải */
            .right-panel {
                position: sticky;
                top: 20px;
                text-align: left;
                background: white;
                padding: 15px;
                border-radius: 10px;
                box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
                width: 250px;
                height: fit-content;
            }

            .legend-title {
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 10px;
                text-align: center;
            }

            .legend {
                display: flex;
                flex-direction: column;
                gap: 10px;
            }

            .legend-item {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .legend-box {
                width: 20px;
                height: 20px;
                border-radius: 3px;
            }

            /* Danh sách ghế đã chọn */
            .selected-info {
                margin-top: 20px;
            }

            .selected-info button {
                padding: 10px 15px;
                margin: 5px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-weight: bold;
            }

            .selected-info button:hover {
                opacity: 0.8;
            }

            .cancel-btn {
                background-color: #FF4C4C;
                color: white;
            }
            #selectedSeats {
                font-weight: bold;
                margin: 10px 0;
            }

            button {
                background-color: #008CBA;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                transition: background 0.3s;
                width: 100%;
            }

            button:hover {
                background-color: #0073a7;
            }

        </style>
    </head>
    <body>
        <div class="container">
            <div class="plane-container">
                <h2>Sơ Đồ Ghế Máy Bay ${id}</h2>
                <div class="plane-header">
                    <img src="img/ghe-ngoi-may-bay-vietjet-removebg-preview.png" alt="Đầu máy bay">
                </div>

                <div class="plane" id="plane">
                    <c:forEach var="s" items="${seat}" varStatus="loop">
                        <c:if test="${loop.index % 6 == 2 || loop.index % 6 == 4}">
                            <div class="aisle"></div>
                        </c:if>

                        <div class="seat ${s.status eq 'Booked' ? 'booked' : (s.status eq 'Maintained' ? 'maintained' : 'available')}" 
                             data-seat-id="${s.id}" onclick="selectSeat('${s.id}', this)">
                            ${s.id}
                        </div>
                    </c:forEach>
                </div>

                <div class="plane-end">
                    <img src="img/so-do-cho-ngoi-may-bay-Vietjet-1-removebg-preview.png" alt="Đuôi máy bay">
                </div>
            </div>

            <div class="right-panel">
                <div class="legend-title">Chú thích</div>
                <div class="legend">
                    <div class="legend-item">
                        <div class="legend-box available"></div> Ghế trống
                    </div>
                    <div class="legend-item">
                        <div class="legend-box booked"></div> Đã đặt
                    </div>
                    <div class="legend-item">
                        <div class="legend-box maintained"></div> Bảo trì
                    </div>
                    <div class="legend-item">
                        <div class="legend-box selected"></div> Đang chọn
                    </div>
                </div>

                <div class="selected-info">
                    <h3>Ghế đang chọn:</h3>
                    <p id="selectedSeats">Không có</p>
                    <button onclick="confirmSelection()">✅ Xác nhận ghế</button>
                    <button onclick="cancelSelection()" class="cancel-btn">❌ Hủy chọn</button>
                </div>
            </div>
        </div>

        <script>
            let selectedSeat = null;

            function selectSeat(seatId, seatElement) {
                if (seatElement.classList.contains('booked') || seatElement.classList.contains('maintained')) {
                    return;
                }

                if (selectedSeat === seatElement) {
                    seatElement.classList.remove('selected');
                    seatElement.classList.add('available');
                    selectedSeat = null;
                    selectedSeatId = null;  // Xóa seatId khi bỏ chọn ghế
                    document.getElementById("selectedSeats").innerText = "Chưa chọn ghế";
                    return;
                }

                if (selectedSeat) {
                    selectedSeat.classList.remove('selected');
                    selectedSeat.classList.add('available');
                }

                seatElement.classList.remove('available');
                seatElement.classList.add('selected');
                selectedSeat = seatElement;
                selectedSeatId = seatId; // Gán seatId khi chọn ghế

                document.getElementById("selectedSeats").innerText = seatId;
            }


            function updateSelectedSeat(seatId) {
                const display = document.getElementById("selectedSeats");
                display.innerText = seatId ? `Ghế: ${seatId}` : "Chưa chọn ghế";
            }

            function confirmSelection() {
                if (!selectedSeatId) {
                    alert("Bạn chưa chọn ghế nào!");
                    return;
                }

                // ✅ Lấy ticketId động từ URL
                const urlParams = new URLSearchParams(window.location.search);
                const ticketId = urlParams.get("ticketId");

                let requestData = {seatId: selectedSeatId, ticketId: ticketId};
                console.log("📤 Gửi request: ", requestData); // Debug

                fetch("<%= request.getContextPath() %>/listSeatsUser", {
                    method: "POST",
                    headers: {"Content-Type": "application/json"},
                    body: JSON.stringify(requestData)
                })
                        .then(response => response.json())
                        .then(data => {
                            console.log("📥 Nhận response: ", data); // Log response
                            if (data.success) {
                                alert("Đặt ghế thành công!");
                            } else {
                                alert("Lỗi: " + data.message);
                            }
                        })
                        .catch(error => console.error("❌ Lỗi khi gửi request:", error));
            }
            function cancelSelection() {
                if (selectedSeat) {
                    selectedSeat.classList.remove("selected");
                    selectedSeat.classList.add("available");
                    selectedSeat = null;
                }
                updateSelectedSeat(null);
            }
        </script>
    </body>
</html>
