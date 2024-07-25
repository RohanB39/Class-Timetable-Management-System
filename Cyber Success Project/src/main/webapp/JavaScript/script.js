document.addEventListener('DOMContentLoaded', () => {
    const customSelectWrapper = document.querySelector('.custom-select-wrapper');
    const customSelect = customSelectWrapper.querySelector('.custom-select');
    const selectElement = document.getElementById('role');
    const trigger = customSelect.querySelector('.custom-select__trigger span');
    const options = customSelect.querySelectorAll('.custom-option');

    customSelectWrapper.addEventListener('click', (e) => {
        customSelect.classList.toggle('open');
        e.stopPropagation();
    });

    options.forEach(option => {
        option.addEventListener('click', (e) => {
            trigger.textContent = option.textContent;
            selectElement.value = option.getAttribute('data-value');
            options.forEach(opt => opt.classList.remove('selected'));
            option.classList.add('selected');
            customSelect.classList.remove('open');
            e.stopPropagation();
        });
    });

    window.addEventListener('click', () => {
        customSelect.classList.remove('open');
    });
});

function togglePassword() {
    var passwordField = document.getElementById('password');
    var toggleIcon = document.querySelector('.toggle-password');
    var passwordFieldType = passwordField.getAttribute('type');
    if (passwordFieldType === 'password') {
        passwordField.setAttribute('type', 'text');
        toggleIcon.classList.remove('eye-closed');
        toggleIcon.classList.add('eye-open');
    } else {
        passwordField.setAttribute('type', 'password');
        toggleIcon.classList.remove('eye-open');
        toggleIcon.classList.add('eye-closed');
    }
}
