<%-- 
    Document   : chatbox
    Created on : 2 Mar 2025, 10:22:09
    Author     : Rinaaaa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" type="text/css" href="css/chatbox.css">
<script src="js/chatbox.js"></script>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <button id="chatbox-toggle">💬</button>

        <div id="chatbox-panel">
            <div id="chatbox-header">
                <div class="chatbox-header-left">
                    <img src="profile.jpg" alt="Avatar">
                    <span>Staff</span>
                </div>
                <button id="chatbox-close">✖</button>
            </div>

            <div id="chat-messages">
                <c:forEach var="message" items="${messages}">
                    <div class="chat-message ${message.senderAccountID == sessionScope.currentUserID ? 'sent' : 'received'}">
                        <p>${message.message}</p>
                        <small>${message.timestamp}</small>
                    </div>
                </c:forEach>
                <div id="typing-indicator" style="display: none;">Đang nhập...</div>
            </div>

            <form id="message-form">
                <input type="text" id="message-input" placeholder="Aa">
                <button type="submit">➤</button>
            </form>
        </div>
</html>
