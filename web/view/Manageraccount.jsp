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

                    <form action="acc" method="GET">
                        <label for="roleFilter">Filter by Role:</label>
                        <select name="role" id="roleFilter" onchange="this.form.submit()">
                            <option value="">All</option>
                            <option value="Customer" ${param.role == 'Customer' ? 'selected' : ''}>Customer</option>
                            <option value="Staff" ${param.role == 'Staff' ? 'selected' : ''}>Staff</option>
                            <option value="AirTrafficControl" ${param.role == 'AirTrafficControl' ? 'selected' : ''}>Air Traffic Control</option>
                        </select>
                    </form>


                    <!-- Form tìm kiếm -->                   
                    <div class="form-group">
                        <input  type="text" id="searchInput" class="form-control" placeholder="Enter username..." onkeyup="filterTable()">
                    </div>

                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Username</th>
                                <th>Password</th>
                                <th>
                                    <a href="?sortOrder=asc">▲</a>
                                    Role
                                    <a href="?sortOrder=desc">▼</a>
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

            <div id="addUserModal" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="addUser" method="post">
                            <div class="modal-header">
                                <h4 class="modal-title">Add User</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label>Username</label>
                                    <input name="username" type="text" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Password</label>
                                    <input name="password" type="password" class="form-control" required>
                                </div>   
                                <div class="form-group">
                                    <label>Entity ID</label>
                                    <input name="entityID" type="number" class="form-control" required>
                                </div>                         
                                <div class="form-group">
                                    <label>Role</label>
                                    <select name="roleID" class="form-control" required>
                                        <option value="2">Staff</option>
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
                    <a href="?page=1&sortOrder=${param.sortOrder}&role=${param.role}">&laquo; First</a>
                    <a href="?page=${currentPage - 1}&sortOrder=${param.sortOrder}&role=${param.role}">Previous</a>
                </c:if>

                <c:forEach var="i" begin="1" end="${totalPages}">
                    <a href="?page=${i}&sortOrder=${param.sortOrder}&role=${param.role}" 
                       class="${i == currentPage ? 'active' : ''}">${i}</a>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <a href="?page=${currentPage + 1}&sortOrder=${param.sortOrder}&role=${param.role}">Next</a>
                    <a href="?page=${totalPages}&sortOrder=${param.sortOrder}&role=${param.role}">Last &raquo;</a>
                </c:if>
            </div>






            <script src="js/manager.js" type="text/javascript"></script>
            <script>
                            function filterTable() {
                                var input, filter, table, tr, td, i, txtValue;
                                input = document.getElementById("searchInput");
                                filter = input.value;
                                table = document.querySelector(".table");
                                tr = table.getElementsByTagName("tr");

                                var noResult = true; // Biến kiểm tra có kết quả hay không

                                for (i = 1; i < tr.length; i++) {
                                    td = tr[i].getElementsByTagName("td")[1]; // Lấy cột username
                                    if (td) {
                                        txtValue = td.textContent || td.innerText;
                                        if (txtValue.indexOf(filter) > -1) {
                                            tr[i].style.display = "";
                                            noResult = false; // Tìm thấy ít nhất một kết quả
                                        } else {
                                            tr[i].style.display = "none";
                                        }
                                    }
                                }

                                // Hiển thị thông báo nếu không tìm thấy kết quả
                                var messageRow = document.getElementById("noResultRow");
                                if (noResult) {
                                    if (!messageRow) { // Nếu chưa có hàng thông báo thì thêm vào
                                        messageRow = document.createElement("tr");
                                        messageRow.id = "noResultRow";
                                        var td = document.createElement("td");
                                        td.colSpan = 6; // Merge cột
                                        td.style.textAlign = "center";
                                        td.style.fontWeight = "bold";
                                        td.innerText = "No matching accounts found!";
                                        messageRow.appendChild(td);
                                        table.appendChild(messageRow);
                                    }
                                } else {
                                    if (messageRow) { // Nếu có thông báo thì xoá đi
                                        messageRow.remove();
                                    }
                                }
                            }

            </script>


    </body>
</html>