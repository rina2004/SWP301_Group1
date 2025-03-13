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

            <%-- Hiển thị thông báo lỗi --%>
            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <strong>Error:</strong> ${sessionScope.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="error" scope="session"/> <%-- Xóa session ngay sau khi hiển thị --%>
            </c:if>

            <%-- Hiển thị thông báo thành công --%>
            <c:if test="${not empty sessionScope.success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <strong>Success:</strong> ${sessionScope.success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="success" scope="session"/> <%-- Xóa session ngay sau khi hiển thị --%>
            </c:if>


            <c:if test="${not empty account}">
                <div class="row">
                    <div class="col-xl-4">
                        <div class="card mb-4 mb-xl-0">
                            <div class="card-body text-center">
                                <img class="img-account-profile rounded-circle mb-2" 
                                     src="https://i.pinimg.com/736x/8f/1c/a2/8f1ca2029e2efceebd22fa05cca423d7.jpg" 
                                     alt="Profile Picture">

                                <h5 class="mt-3">${account.username}</h5> 
                            </div>
                        </div>
                    </div>


                    <div class="col-xl-8">
                        <div class="card mb-4">
                            <div class="card-header">Account Details</div>
                            <div class="card-body">
                                <form action="updateProfile" method="post">


                                    <div class="row gx-3 mb-3">
                                        <div class="col-md-6">
                                            <label class="small mb-1" for="inputName">Full Name</label>
                                            <input class="form-control" id="inputName" name="name" type="text" value="${account.name}">
                                        </div>
                                        <div class="col-md-6">
                                            <label class="small mb-1" for="inputCitizenID">Citizen ID</label>
                                            <input class="form-control" id="inputCitizenID" name="citizenID" type="text" value="${account.citizenID}">
                                        </div>
                                    </div>

                                    <div class="row gx-3 mb-3">
                                        <div class="col-md-6">
                                            <label class="small mb-1" for="inputDob">Date of Birth</label>
                                            <input class="form-control" id="inputDob" name="dob" type="date"
                                                   value="<fmt:formatDate value='${account.dob}' pattern='yyyy-MM-dd'/>" 
                                                   required max="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                                        </div>
                                        <div class="col-md-6">
                                            <label class="small mb-1" for="inputPhone">Phone</label>
                                            <input class="form-control" id="inputPhone" name="phone" type="text" value="${account.phone}">
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label class="small mb-1" for="inputAddress">Address</label>
                                        <input class="form-control" id="inputAddress" name="address" type="text" value="${account.address}">
                                    </div>

                                    <div class="mb-3">
                                        <label class="small mb-1" for="inputEmail">Email</label>
                                        <input class="form-control" id="inputEmail" name="email" type="email" value="${account.email}">
                                    </div>

                                    <!-- Chỉ có nút Save -->
                                    <button type="submit" class="btn btn-success">Save</button>
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
