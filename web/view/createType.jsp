<%-- 
    Document   : createType
    Created on : 3 Mar 2025, 00:55:20
    Author     : Rinaaaa
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Type</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/createType.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <script src="${pageContext.request.contextPath}/js/createType.js"></script>
    </head>
    <body>
        <a href="<%= request.getContextPath() %>/type/list" class="back-button">
            <i class="fas fa-arrow-left"></i>
        </a>
        
        <div class="container">
            <h1>Create New Type</h1>
            
            <div class="form-container">
                <form action="<%= request.getContextPath() %>/type/create" method="POST">
                    <div class="form-group">
                        <label for="id">ID</label>
                        <input type="text" id="id" name="id" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="name">Name</label>
                        <input type="text" id="name" name="name" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="manufacture">Manufacture</label>
                        <input type="text" id="manufacture" name="manufacture" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="length">Length</label>
                        <input type="number" step="0.01" id="length" name="length" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="weight">Weight</label>
                        <input type="number" step="0.01" id="weight" name="weight" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="height">Height</label>
                        <input type="number" step="0.01" id="height" name="height" required>
                    </div>
                    
                    <div class="button-container">
                        <button type="submit" class="create-button">
                            Create
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>