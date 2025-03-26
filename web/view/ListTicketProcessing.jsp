<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Processing Orders</title>
    <link rel="stylesheet" href="styles.css"> <!-- Link CSS nếu có -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 20px;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: auto;
            background: white;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .btn {
            padding: 8px 12px;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
            border: none;
            cursor: pointer;
        }
        .btn-cancel {
            background-color: #dc3545;
        }
        .btn:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Processing Orders</h2>

    <c:choose>
        <c:when test="${not empty processingOrders}">
            <table>
                <tr>
                    <th>Order ID</th>
                    <th>Status</th>
                    <th>Final Price</th>
                    <th>Final Quantity</th>
                    <th>Actions</th>
                </tr>
                <c:forEach var="order" items="${processingOrders}">
                    <tr>
                        <td>${order.id}</td>
                        <td>${order.status}</td>
                        <td>$${order.finalPrice}</td>
                        <td>${order.finalNum}</td>
                        <td>
                            <form action="staffTicketProcessing" method="post">
                                <input type="hidden" name="orderID" value="${order.id}">
                                <button type="submit" class="btn btn-cancel">Accept</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:when>
        <c:otherwise>
            <p style="text-align: center; color: red;">No processing orders found.</p>
        </c:otherwise>
    </c:choose>
</div>
     <a class="btn" href="${pageContext.request.contextPath}/view/Home.jsp">Back to Home</a>
</body>
</html>
