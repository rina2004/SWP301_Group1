/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

document.addEventListener('DOMContentLoaded', function() {
    updateCompartments();
});

function updateCompartments() {
    const numOfComs = parseInt(document.getElementById('numOfComs').value);
    const container = document.getElementById('compartmentsContainer');
    container.innerHTML = '';

    for (let i = 0; i < numOfComs; i++) {
        const compartmentDiv = document.createElement('div');
        compartmentDiv.classList.add('card', 'mb-3');
        compartmentDiv.innerHTML = `
            <div class="card-header">Compartment ${i + 1}</div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <label class="form-label">Type</label>
                        <select class="form-control" name="compartment${i}.type" required>
                            <option value="B">Business</option>
                            <option value="E">Economy</option>
                            <option value="F">First Class</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Number of Seats</label>
                        <input type="number" class="form-control" name="compartment${i}.capacity" 
                               min="1" max="100" required>
                    </div>
                </div>
            </div>
        `;
        container.appendChild(compartmentDiv);
    }
}