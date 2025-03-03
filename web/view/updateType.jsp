<%-- 
    Document   : updateType
    Created on : 3 Mar 2025, 07:48:58
    Author     : Rinaaaa
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/updateType.css"/>
        <title>Update Type</title>
    </head>
    <body>
        <h1>Update Type Information</h1>
        <form action="<%= request.getContextPath() %>/type/update" method="POST">
            <input type="hidden" name="id" value="${type.id}">
            <div class="form-group">
                <label>Name:</label>
                <input type="text" name="name" value="${type.name}" required>
            </div>
            
            <div class="form-group">
                <label>Manufacture:</label>
                <input type="text" name="manufacture" value="${type.manufacture}" required>
            </div>
            
            <div class="form-group">
                <label>Length:</label>
                <input type="text" name="length" value="${type.length}" required>
            </div>
            
            <div class="form-group">
                <label>Weight:</label>
                <input type="text" name="weight" value="${type.weight}" required>
            </div>
            
            <div class="form-group">
                <label>Height:</label>
                <input type="text" name="height" value="${type.height}" required>
            </div>
            
            <div class="form-actions">
                <a href="<%= request.getContextPath() %>/type/list" class="cancel-button">Cancel</a>
                <input type="submit" value="Update">
            </div>
        </form>
    </body>
</html>