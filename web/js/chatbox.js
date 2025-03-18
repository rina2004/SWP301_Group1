/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

document.addEventListener("DOMContentLoaded", function () {
    let chatboxToggle = document.getElementById("chatbox-toggle");
    let chatboxPanel = document.getElementById("chatbox-panel");
    let chatboxClose = document.getElementById("chatbox-close");
    let messageInput = document.getElementById("message-input");
    let typingIndicator = document.getElementById("typing-indicator");
    let typingTimeout;
    let isTyping = false;

    chatboxPanel.style.display = "none";

    chatboxToggle.addEventListener("click", function () {
        chatboxPanel.style.display = (chatboxPanel.style.display === "none" || chatboxPanel.style.display === "") ? "block" : "none";
    });

    chatboxClose.addEventListener("click", function () {
        chatboxPanel.style.display = "none";
    });

    messageInput.addEventListener("input", function () {
        if (!isTyping) {
            isTyping = true;
            sendTypingStatus(true);
        }
        clearTimeout(typingTimeout);
        typingTimeout = setTimeout(() => {
            isTyping = false;
            sendTypingStatus(false);
        }, 2000);
    });

    function sendTypingStatus(isTyping) {
        fetch("TypingStatusServlet", {
            method: "POST",
            headers: {"Content-Type": "application/x-www-form-urlencoded"},
            body: `typing=${isTyping}`
        });
    }

    function receiveTypingStatus(isTyping) {
        typingIndicator.style.display = isTyping ? "block" : "none";
    }

    setInterval(() => {
        fetch("TypingStatusServlet")
                .then(res => res.json())
                .then(data => receiveTypingStatus(data.typing));
    }, 1000);
});