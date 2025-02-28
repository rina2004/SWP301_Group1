
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Account</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link href="css/manager.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div class="container">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-6">
                            <h2><b>Edit Account</b></h2>
                        </div>
                    </div>
                </div>
            </div>



            <div id="editAccountModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="editAccount" method="post">
                            <div class="modal-header">						
                                <h4 class="modal-title">Edit Account</h4>
                            </div>
                            <div class="modal-body">

                                <div class="form-group">
                                    <label>User ID</label>
                                    <input value="${account.id}" name="id" type="text" class="form-control" readonly required>
                                </div>

                                <div class="form-group">
                                    <label>Username</label>
                                    <input value="${account.username}" name="username" type="text" class="form-control" readonly required>
                                </div>

                                <div class="form-group">
                                    <label>Password</label>
                                    <input value="${account.password}" name="password" type="text" class="form-control" required>
                                </div>




                                <div class="form-group">
                                    <label>Status</label>
                                    <select name="status" class="form-select" aria-label="Select Status" required>
                                        <option value="true" <c:if test="${account.status}">selected</c:if>>Active</option>
                                        <option value="false" <c:if test="${!account.status}">selected</c:if>>Inactive</option>
                                    </select>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <a href="acc" class="btn btn-primary">Back</a>
                                <input type="submit" class="btn btn-success" value="Edit">
                            </div>


                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script src="js/manager.js" type="text/javascript"></script>
    </body>
</html>
