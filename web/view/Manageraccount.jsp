<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage User Accounts</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link href="css/manager.css" rel="stylesheet" type="text/css"/>
        <style>
            img {
                width: 50px;
                height: 50px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-6">
                            <h2>Manage <b>Account</b></h2>
                        </div>
                    </div>
                </div>
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>UserID</th>
                            <th>UserName</th>
                            <th>Password</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach items="${listA}" var="user">
                            <tr>
                                <td>${user.id}</td>
                                <td>${user.username}</td>
                                <td>${user.password}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.roleID == 2}">Staff</c:when>
                                        <c:when test="${user.roleID == 3}">Customer</c:when>                                        
                                        <c:when test="${user.roleID == 4}">AirTrafficControl</c:when>
                                        <c:otherwise>Unknown</c:otherwise>
                                    </c:choose>
                                </td>

                                <td>${user.status ? 'Active' : 'Inactive'}</td>
                                <td>
                                    <a href="loadacc?uid=${user.id}" class="edit" data-toggle="modal">
                                        <i class="material-icons" title="Edit">&#xE254;</i>
                                    </a>

                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            
        </div>

        <script src="js/manager.js" type="text/javascript"></script>
    </body>
</html>
