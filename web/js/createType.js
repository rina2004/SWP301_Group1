/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

document.addEventListener('DOMContentLoaded', () => {
    const inputs = document.querySelectorAll('input[required]');
    
    inputs.forEach(input => {
        input.addEventListener('focus', () => {
            input.parentElement.classList.add('focused');
        });
        
        input.addEventListener('blur', () => {
            input.parentElement.classList.remove('focused');
            
            if (input.value.trim() !== '') {
                input.parentElement.classList.add('valid');
                input.parentElement.classList.remove('invalid');
            } else {
                input.parentElement.classList.add('invalid');
                input.parentElement.classList.remove('valid');
            }
        });
        
        input.addEventListener('input', () => {
            if (input.value.trim() !== '') {
                input.classList.add('has-content');
            } else {
                input.classList.remove('has-content');
            }
        });
    });
    
    const form = document.querySelector('form');
    const submitButton = document.querySelector('.create-button');
    
    form.addEventListener('submit', (e) => {
        submitButton.classList.add('loading');

        setTimeout(() => {
            submitButton.style.backgroundColor = '#28a745';
            submitButton.innerHTML = '<i class="fas fa-check"></i> Created!';

        }, 1500);
    });

    document.querySelectorAll('.form-group, .button-container, h1, .form-container').forEach(el => {
        el.style.opacity = '0';
        setTimeout(() => {
            el.style.opacity = '1';
        }, 100);
    });
});