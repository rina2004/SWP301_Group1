<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Order"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
    <head>
        <title>Order History</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f9f9f9;
                margin: 20px;
            }
            h2 {
                color: #333;
            }
            table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                background: #fff;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                border-radius: 8px;
                overflow: hidden;
            }
            th, td {
                padding: 12px 15px;
                text-align: center;
            }
            th {
                background-color: #4CAF50;
                color: white;
                text-transform: uppercase;
                letter-spacing: 0.05em;
            }
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            tr:hover {
                background-color: #e0f7fa;
            }
            .btn {
                padding: 6px 14px;
                background-color: #2196F3;
                color: #fff;
                text-decoration: none;
                border-radius: 4px;
                border: none;
                transition: background-color 0.3s;
                display: inline-block;
            }
            .btn:hover {
                background-color: #1976D2;
            }
            .btn-secondary {
                background-color: #9e9e9e;
            }
            .btn-secondary:hover {
                background-color: #757575;
            }
            .btn-disabled {
                background-color: #d3d3d3;
                cursor: not-allowed;
                pointer-events: none;
            }
            .table-container {
                margin-top: 20px;
            }
            .action-group {
                display: flex;
                justify-content: center;
                gap: 8px;
            }
        </style>
    </head>
    <body>
        <h2>My Orders</h2>

        <div class="table-container">
            <c:if test="${empty orders}">
                <p>You have no orders yet.</p>
            </c:if>

            <c:if test="${not empty orders}">
                <table>
                    <tr>
                        <th>Order ID</th>
                        <th>Status</th>
                        <th>Time</th>
                        <th>Total Passengers</th>
                        <th>Actions</th>
                    </tr>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td>${order.id}</td> 
                            <td>${order.status}</td>
                            <td>${order.time}</td>
                            <td>${order.ticketCount}</td> 
                            <td>
                                <div class="action-group">
                                    <a class="btn" href="${pageContext.request.contextPath}/orderDetail?orderId=${order.id}">View</a>
                                    
                                    <c:choose>
                                        <c:when test="${order.status eq 'Canceled' or order.status eq 'Pending'}">
                                            <a class="btn btn-secondary btn-disabled">Cancel</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a class="btn btn-secondary" href="#" onclick="confirmCancel(${order.id})">Cancel</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>
        </div>

        <br>
        <a class="btn" href="${pageContext.request.contextPath}/view/Home.jsp">Back to Home</a>

        <!-- Form ẩn để gửi yêu cầu hủy bằng POST -->
        <form id="cancelForm" method="POST" action="${pageContext.request.contextPath}/cancelOrder">
            <input type="hidden" name="orderId" id="orderIdInput">
        </form>

        <script>
            function confirmCancel(orderId) {
                if (!orderId) return; // Bảo vệ tránh lỗi nếu orderId không hợp lệ

                let confirmAction = confirm("Are you sure you want to cancel this order?");
                if (confirmAction) {
                    document.getElementById('orderIdInput').value = orderId;
                    document.getElementById('cancelForm').submit();
                }
            }
        </script>
    </body>
</html>
