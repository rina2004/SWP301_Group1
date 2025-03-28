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
            <c:if test="${not empty sessionScope.Message}">
                <div class="alert alert-info">${sessionScope.Message}</div>
                <c:remove var="Message" scope="session"/>
            </c:if>

            <div class="container">
                <div class="table-wrapper">
                    <div class="table-title">
                        <div class="row">
                            <div class="col-sm-6">
                                <h2><b>Manage Account</b></h2>
                            </div>
                            <div class="col-sm-6">
                                <a href="#addUserModal" class="btn btn-success" data-toggle="modal">
                                    <i class="material-icons">&#xE147;</i> <span>Add New User</span>
                                </a>
                            </div>
                        </div>
                    </div>

                    <form action="account-list" method="GET" style="display:flex; align-items:center; gap:10px; margin-bottom:20px;">
                        <label for="roleFilter">Filter by Role:</label>
                        <select name="role" id="roleFilter" onchange="this.form.submit()">
                            <option value="">All</option>
                            <option value="2" ${param.role == '2' ? 'selected' : ''}>Customer</option>
                            <option value="3" ${param.role == '3' ? 'selected' : ''}>Staff</option>
                            <option value="4" ${param.role == '4' ? 'selected' : ''}>Air Traffic Control</option>
                        </select>

                        <input type="text" name="search" value="${param.search}" placeholder="Enter username..." class="form-control">

                        <button type="submit" class="btn btn-primary">Search</button>

                        <button type="button" class="btn btn-secondary" onclick="window.location.href = 'account-list'">Reset Filters</button>
                    </form>




                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Username</th>
                                <th>Password</th>
                                <th>
                                    <a href="?sortOrder=asc&role=${param.role}&search=${param.search}">▲</a>
                                    Role
                                    <a href="?sortOrder=desc&role=${param.role}&search=${param.search}">▼</a>
                                </th>


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
                                    <td>${user.role.name}</td>



                                    <td>${user.status ? 'Active' : 'Inactive'}</td>
                                    <td>
                                        <a href="account-update?uid=${user.id}" class="edit" data-toggle="modal">
                                            <i class="material-icons" title="Edit">&#xE254;</i>
                                        </a>

                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

            </div>

            <div id="addUserModal" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="account-addUser" method="post">
                            <div class="modal-header">
                                <h4 class="modal-title">Add User</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label>Username</label>
                                    <input name="username" type="text" class="form-control" required 
                                           pattern="^[a-zA-Z0-9_]{1,50}$" 
                                           title="Username must be 1-50 characters, only letters, numbers, and underscores.">
                                </div>

                                <div class="form-group">
                                    <label>Password</label>
                                    <input name="password" type="password" class="form-control" required 
                                           pattern="^(?=.*[A-Za-z])(?=.*\d).{6,50}$" 
                                           title="Password must be 6-50 characters, including at least one letter and one number.">
                                </div>  

                                <div class="form-group">
                                    <label>Role</label>
                                    <select name="roleID" class="form-control" required>
                                        <option value="3">Staff</option>
                                        <option value="4">AirTrafficControl</option>      
                                    </select>


                                </div>
                                <div class="form-group">
                                    <label>Status</label>
                                    <select name="status" class="form-select" aria-label="Select Status" required>
                                        <option value="true">Active</option>
                                        <option value="false">Inactive</option>
                                    </select>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                                <input type="submit" class="btn btn-success" value="Add">
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="?page=1&sortOrder=${param.sortOrder}&role=${param.role}&search=${param.search}">&laquo; First</a>
                    <a href="?page=${currentPage - 1}&sortOrder=${param.sortOrder}&role=${param.role}&search=${param.search}">Previous</a>
                </c:if>

                <c:forEach var="i" begin="1" end="${totalPages}">
                    <a href="?page=${i}&sortOrder=${param.sortOrder}&role=${param.role}&search=${param.search}" 
                       class="${i == currentPage ? 'active' : ''}">${i}</a>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <a href="?page=${currentPage + 1}&sortOrder=${param.sortOrder}&role=${param.role}&search=${param.search}">Next</a>
                    <a href="?page=${totalPages}&sortOrder=${param.sortOrder}&role=${param.role}&search=${param.search}">Last &raquo;</a>
                </c:if>
            </div>







            <script src="js/manager.js" type="text/javascript"></script>

    </body>
</html>