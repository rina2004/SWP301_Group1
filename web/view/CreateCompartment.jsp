<%-- 
    Document   : CreateCompartment
    Created on : Mar 9, 2025, 1:30:37 PM
    Author     : tungn
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Compartment</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 20px;
            }

            h2 {
                text-align: center;
                color: #333;
            }

            .form-group {
                margin-bottom: 10px;
            }

            input[type="number"],
            input[type="text"] {
                width: 60%;
                padding: 8px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            .compartment {
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 15px;
                margin: 15px 0;
                background-color: #fff;
                box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
            }

            ul {
                list-style-type: none;
                padding: 0;
                margin-top: 10px;
            }

            li {
                margin: 5px 0;
            }
        </style>
    </head>
    <body>

        <h2>Create Compartments & Seats: <%= request.getAttribute("airplaneID") %></h2>

        <div class="form-group">
            <label for="numCompartments"><strong>Input number of Compartments:</strong></label><br>
            <input type="number" id="numCompartments" min="1" max="5" placeholder="Nhập số khoang">
        </div>

        <div id="compartmentsContainer" data-airplane-id="<%= request.getAttribute("airplaneID") %>"></div>

        <script>
            function generateCompartments() {
                console.log("generateCompartments() called");

                let numCompartments = parseInt(document.getElementById("numCompartments").value) || 1;
                let container = document.getElementById("compartmentsContainer");

                let airplaneID = container.getAttribute("data-airplane-id");
                if (!airplaneID) {
                    console.error("⚠️ Airplane ID is null or undefined!");
                    airplaneID = "UNKNOWN";
                }
                console.log("Airplane ID:", airplaneID);

                container.innerHTML = ""; // Xóa nội dung cũ

                for (let i = 1; i <= numCompartments; i++) {
                    console.log(`Creating compartment ${i}`);

                    let div = document.createElement("div");
                    div.className = "compartment";

                    div.innerHTML = `
                        <h3>Compartment ${i}</h3>
                        <label>Compartment type:</label>
                        <select id="compartmentType${i}" onchange="updateCompartmentID(${i}, '${airplaneID}')">
                            <option value="">Select Type</option>
                            <option value="First Class">First Class</option>
                            <option value="Business Class">Business Class</option>
                            <option value="Premium Economy">Premium Economy</option>
                            <option value="Economy">Economy</option>
                            <option value="Basic Economy">Basic Economy</option>
                        </select><br>

                        <label>Compartment ID:</label>
                        <span id="compartmentID${i}">Waiting...</span><br>

                        <label>Number of seats:</label>
                        <input type="number" class="seatCount" name="seatCount${i}" min="1" max="50" placeholder="Enter number of seats" required><br>
                    `;

                    container.appendChild(div);
                }

                document.querySelectorAll(".seatCount").forEach(input => {
                    input.addEventListener("input", function () {
                        let value = parseInt(this.value);
                        if (isNaN(value) || value < 1)
                            this.value = 1;
                        if (value > 50)
                            this.value = 50;
                    });
                });
            }

            function updateCompartmentID(index, airplaneID) {
                let typeSelect = document.getElementById(`compartmentType${index}`);
                let type = typeSelect.value;
                let idSpan = document.getElementById(`compartmentID${index}`);

                if (!idSpan) {
                    console.error(`❌ Compartment ID span not found for index ${index}`);
                    return;
                }

                let typeCode = {
                    "First Class": "F",
                    "Business Class": "B",
                    "Premium Economy": "PE",
                    "Economy": "E",
                    "Basic Economy": "BE"
                }[type] || "X"; // Nếu chưa chọn thì gán "X"

                let newID = `${airplaneID}_${typeCode}`;
                        console.log(`🔄 Updating compartment ${index} ID to: ${newID}`);
                        idSpan.innerText = newID;
                    }

                    document.getElementById("numCompartments").addEventListener("input", function () {
                        let value = parseInt(this.value);
                        if (isNaN(value) || value < 1)
                            this.value = 1;
                        if (value > 5)
                            this.value = 5;
                        generateCompartments();
                    });
        </script>
    </body>
</html>

