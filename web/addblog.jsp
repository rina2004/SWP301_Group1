<%-- 
    Document   : addblog
    Created on : Mar 26, 2025, 2:44:48 AM
    Author     : DUCDA
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add New Blog</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Arial, sans-serif;
            }

            body {
                background-color: #E3F2FD;
            }

            .container {
                width: 50%;
                margin: 50px auto;
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            }

            h2 {
                text-align: center;
                color: #333;
                margin-bottom: 20px;
            }

            form {
                display: flex;
                flex-direction: column;
                gap: 15px;
            }

            label {
                font-weight: bold;
                color: #333;
            }

            input, textarea {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            .buttons {
                display: flex;
                justify-content: space-between;
            }

            button {
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                font-weight: bold;
                cursor: pointer;
                text-align: center;
            }

            .submit-btn {
                background-color: #007BFF;
                color: white;
            }

            .cancel-btn {
                background-color: #dc3545;
                color: white;
                text-decoration: none;
                display: inline-block;
                text-align: center;
                line-height: 40px;
                border-radius: 8px; /* Bo tròn góc */
                padding: 0 15px; /* Thêm padding để dễ nhìn hơn */
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Add New Blog</h2>
            <form action="addblog" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="add">

                <label for="title">Title:</label>
                <input type="text" id="title" name="title" required>

                <label for="description">Description:</label>
                <textarea id="description" name="description" rows="5" required></textarea>

                <label for="description">Content:</label>
                <textarea id="content" name="content" rows="5" required></textarea>

                <label for="image">Image:</label>
                <input type="file" id="image" name="image" accept="image/*" required>

                <div class="buttons">
                    <button type="submit" class="submit-btn">Submit</button>
                    <a href="blog-manage" class="cancel-btn">Cancel</a>
                </div>
            </form>
        </div>
    </body>
</html>


