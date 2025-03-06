<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Edit Profile</title>
        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <body>
        <div class="container-xl px-4 mt-4">
            <h2 class="mb-4">Edit Profile</h2>
            <c:if test="${not empty account}">
                <div class="row">
                    <div class="col-xl-8 mx-auto">
                        <div class="card mb-4">
                            <div class="card-header">Update Your Details</div>
                            <div class="card-body">
                                <form name="editProfileForm" action="updateProfile" method="post" onsubmit="return validateForm()">

                                <form action="updateProfile" method="post">
                                    <input type="hidden" name="username" value="${account.username}">

                                    <div class="mb-3">
                                        <label class="small mb-1">Password</label>
                                        <input class="form-control" type="text" name="password" 
                                               value="${not empty account.password ? account.password : ''}">
                                    </div>

                                    <div class="mb-3">
                                        <label class="small mb-1">Full Name</label>
                                        <input class="form-control" type="text" name="name" 
                                               value="${not empty account.name ? account.name : ''}">
                                    </div>

                                    <div class="mb-3">
                                        <label class="small mb-1">Citizen ID</label>
                                        <input class="form-control" type="text" name="citizenID" 
                                               value="${not empty account.citizenID ? account.citizenID : ''}">
                                    </div>

                                    <div class="mb-3">
                                        <label class="small mb-1">Date of Birth</label>
                                        <input class="form-control" type="date" name="dob" 
                                               value="<fmt:formatDate value='${account.dob}' pattern='yyyy-MM-dd'/>">
                                    </div>

                                    <div class="mb-3">
                                        <label class="small mb-1">Phone</label>
                                        <input class="form-control" type="text" name="phone" 
                                               value="${not empty account.phone ? account.phone : ''}">
                                    </div>

                                    <div class="mb-3">
                                        <label class="small mb-1">Address</label>
                                        <input class="form-control" type="text" name="address" 
                                               value="${not empty account.address ? account.address : ''}">
                                    </div>

                                    <div class="mb-3">
                                        <label class="small mb-1">Email</label>
                                        <input class="form-control" type="email" name="email" 
                                               value="${not empty account.email ? account.email : ''}">
                                    </div>

                                    <button class="btn btn-success" type="submit">Save Changes</button>
                                    <a href="profile" class="btn btn-secondary">Cancel</a>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <c:if test="${empty account}">
                <div class="alert alert-danger">No account information found.</div>
            </c:if>
        </div>
        <script>
            function validateForm() {
                let form = document.forms["editProfileForm"];
                let citizenID = form["citizenID"].value;
                let phone = form["phone"].value;
                let email = form["email"].value;
                let dob = form["dob"].value; // Lấy giá trị ngày sinh

                let citizenIDPattern = /^[0-9]{9,12}$/; // 9-12 số
                let phonePattern = /^(0[1-9][0-9]{8,9})$/; // Bắt đầu bằng số 0, tổng 10-11 số
                let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; // Email hợp lệ

                // Kiểm tra Citizen ID
                if (!citizenIDPattern.test(citizenID)) {
                    alert("Citizen ID must be 9 to 12 digits.");
                    return false;
                }

                // Kiểm tra số điện thoại
                if (!phonePattern.test(phone)) {
                    alert("Invalid phone number format.");
                    return false;
                }

                // Kiểm tra email
                if (!emailPattern.test(email)) {
                    alert("Invalid email format.");
                    return false;
                }

                // Kiểm tra dob không được là ngày tương lai
                let today = new Date();
                let inputDob = new Date(dob);
                if (dob && inputDob > today) {
                    alert("Date of Birth cannot be in the future.");
                    return false;
                }

                return true; // Nếu hợp lệ, gửi form
            }
        </script>


    </body>
</html>
