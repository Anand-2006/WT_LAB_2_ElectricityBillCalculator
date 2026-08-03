document.addEventListener('DOMContentLoaded', function () {
    const form = document.getElementById('billForm');
    const unitsInput = document.getElementById('units');
    const validationMessage = document.getElementById('validationMessage');
    const resetBtn = document.getElementById('resetBtn');

    function validateUnits(value) {
        if (value === '') {
            return 'Please enter the number of electricity units.';
        }

        const parsed = Number(value);
        if (Number.isNaN(parsed) || parsed < 0) {
            return 'Units must be a positive number or zero.';
        }

        return '';
    }

    if (form) {
        form.addEventListener('submit', function (event) {
            const message = validateUnits(unitsInput.value);
            if (message) {
                event.preventDefault();
                validationMessage.textContent = message;
                unitsInput.focus();
            }
        });
    }

    if (resetBtn) {
        resetBtn.addEventListener('click', function () {
            form.reset();
            validationMessage.textContent = '';
            unitsInput.focus();
        });
    }
});
