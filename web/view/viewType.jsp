<%-- 
    Document   : viewType
    Created on : 3 Mar 2025, 08:12:07
    Author     : Rinaaaa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Type List</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/viewType.css"/>
        <script src="${pageContext.request.contextPath}/js/type.js"></script>
    </head>
    <body>
        <div class="header">
            <h1>Type List</h1>
            <a href="${pageContext.request.contextPath}/type/create" class="create-button">Create New Type</a>
        </div>

        <c:if test="${not empty message}">
            <p class="message">${message}</p>
            <c:remove var="message" scope="session"/>
        </c:if>

        <div id="deletePanel" class="popup-panel" style="display: none;">
            <div class="popup-content">
                <p>Are you sure you want to delete this airplane type?</p>
                <form id="deleteForm" action="${pageContext.request.contextPath}/type/delete" method="post">
                    <input type="hidden" name="id" id="deleteTypeId">
                    <button type="submit" class="yes-button">Yes, delete</button>
                    <button type="button" class="cancel-button" onclick="closeDeletePanel()">Cancel</button>
                </form>
            </div>
        </div>

        <table border="1">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Manufacture</th>
                <th>Length</th>
                <th>Weight</th>
                <th>Height</th>
                <th></th>
                <th></th>
            </tr>
            <c:forEach var="type" items="${types}">
                <tr>
                    <td>${type.id}</td>
                    <td>${type.name}</td>
                    <td>${type.manufacture}</td>
                    <td>${type.length}</td>
                    <td>${type.weight}</td>
                    <td>${type.height}</td>
                    <td><a href="update?id=${type.id}" class="action-link edit">Edit</a></td>
                    <td>
                        <a href="javascript:void(0);" class="action-link delete" onclick="openDeletePanel('${type.id}')">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>