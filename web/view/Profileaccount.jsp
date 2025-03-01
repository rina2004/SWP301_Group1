<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Profile</title>

        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <body>
        <div class="container-xl px-4 mt-4">
            <nav class="nav nav-borders">
                <a class="nav-link active ms-0" href="#">Profile</a>
                <a class="nav-link" href="#">Billing</a>
                <a class="nav-link" href="#">Security</a>
                <a class="nav-link" href="#">Notifications</a>
            </nav>
            <hr class="mt-0 mb-4">
            <c:if test="${not empty account}">
                <div class="row">
                    <div class="col-xl-4">
                        <div class="card mb-4 mb-xl-0">
                            <div class="card-header">Profile Picture</div>
                            <div class="card-body text-center">
                                <img class="img-account-profile rounded-circle mb-2" src="http://bootdey.com/img/Content/avatar/avatar1.png" alt="">
                                <div class="small font-italic text-muted mb-4">JPG or PNG no larger than 5 MB</div>
                                <button class="btn btn-primary" type="button">Upload new image</button>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-8">
                        <div class="card mb-4">
                            <div class="card-header">Account Details</div>
                            <div class="card-body">
                                <form action="updateProfile" method="POST">
                                    <div class="row gx-3 mb-3">
                                        <div class="col-md-6">
                                            <label class="small mb-1" for="inputUsername">Username</label>
                                            <input class="form-control" id="inputUsername" type="text" value="${account.username}" readonly>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="small mb-1" for="inputPassword">Password</label>
                                            <input class="form-control" id="inputPassword" type="text" value="${account.password}">
                                        </div>
                                    </div>
                                    <div class="row gx-3 mb-3">
                                        <div class="col-md-6">
                                            <label class="small mb-1" for="inputName">Full Name</label>
                                            <input class="form-control" id="inputName" type="text" value="${account.name}">
                                        </div>
                                        <div class="col-md-6">
                                            <label class="small mb-1" for="inputCitizenID">Citizen ID</label>
                                            <input class="form-control" id="inputCitizenID" type="text" value="${account.citizenID}">
                                        </div>
                                    </div>
                                    <div class="row gx-3 mb-3">
                                        <div class="col-md-6">
                                            <label class="small mb-1" for="inputDob">Date of Birth</label>
                                            <input class="form-control" id="inputDob" name="dob" type="date"
                                                   value="<fmt:formatDate value='${account.dob}' pattern='yyyy-MM-dd'/>">
                                        </div>

                                        <div class="col-md-6">
                                            <label class="small mb-1" for="inputPhone">Phone</label>
                                            <input class="form-control" id="inputPhone" type="text" value="${account.phone}">
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label class="small mb-1" for="inputAddress">Address</label>
                                        <input class="form-control" id="inputAddress" type="text" value="${account.address}">
                                    </div>
                                    <div class="mb-3">
                                        <label class="small mb-1" for="inputEmail">Email</label>
                                        <input class="form-control" id="inputEmail" type="email" value="${account.email}">
                                    </div>
                                    <button class="btn btn-primary" type="button">Save changes</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
            <c:if test="${empty account}">
                <div class="alert alert-danger" role="alert">
                    No account information found.
                </div>
            </c:if>
        </div>
    </body>
</html>
