/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

function openDeletePanel(typeId) {
    let panel = document.getElementById("deletePanel");
    document.getElementById("deleteTypeId").value = typeId;

    panel.style.display = "block";
    setTimeout(() => {
        panel.classList.add("show");
    }, 100);
}

function closeDeletePanel() {
    let panel = document.getElementById("deletePanel");
    panel.classList.remove("show");
    setTimeout(() => {
        panel.style.display = "none";
    }, 300);
}