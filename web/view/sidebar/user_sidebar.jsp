<%-- 
    Document   : user_sidebar
    Created on : 19 Mar 2025, 20:23:30
    Author     : Rinaaaa
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dynamic Sidebar</title>
    <link rel="stylesheet" href="../../css/sidebar/user.css">
    <script src="../../js/sidebar/"></script>
</head>
<body>

<div class="sidebar">
    <ul>
        <li>
            <a href="#" class="main-item">Home</a>
            <ul class="sub-menu">
                <li><a href="#" onclick="showContent('dashboard')">Dashboard</a></li>
                <li><a href="#" onclick="showContent('news')">News</a></li>
                <li><a href="#" onclick="showContent('updates')">Updates</a></li>
            </ul>
        </li>
        <li>
            <a href="#" class="main-item">Profile</a>
            <ul class="sub-menu">
                <li><a href="#" onclick="showContent('personal-info')">Personal Info</a></li>
                <li><a href="#" onclick="showContent('account')">Account</a></li>
                <li><a href="#" onclick="showContent('preferences')">Preferences</a></li>
            </ul>
        </li>
        <li>
            <a href="#" class="main-item">Settings</a>
            <ul class="sub-menu">
                <li><a href="#" onclick="showContent('general')">General</a></li>
                <li><a href="#" onclick="showContent('security')">Security</a></li>
                <li><a href="#" onclick="showContent('notifications')">Notifications</a></li>
                <li><a href="#" onclick="showContent('privacy')">Privacy</a></li>
            </ul>
        </li>
        <li>
            <a href="#" class="main-item">Help</a>
            <ul class="sub-menu">
                <li><a href="#" onclick="showContent('faq')">FAQ</a></li>
                <li><a href="#" onclick="showContent('contact')">Contact Support</a></li>
                <li><a href="#" onclick="showContent('docs')">Documentation</a></li>
            </ul>
        </li>
    </ul>
</div>

<div class="content-area">
    <c:set var="contentItems" value="${['dashboard', 'news', 'updates', 'personal-info', 'account', 'preferences', 'general', 'security', 'notifications', 'privacy', 'faq', 'contact', 'docs']}" />
    
    <c:forEach var="item" items="${contentItems}">
        <div id="${item}" class="content-panel">
            <h2><c:out value="${item}" /></h2>
            <p>Content for ${item} goes here.</p>
        </div>
    </c:forEach>
    
    <div id="welcome" class="content-panel active">
        <h2>Welcome</h2>
        <p>Welcome to our application. Please select an option from the sidebar menu.</p>
    </div>
</div>
</body>
</html>