// Global variables
let deleteAvailabilityId = null;
let currentDate = new Date();
let availabilities = [];

// Initialize availabilities data
function initAvailabilities(data) {
    availabilities = data;
}

// DOM Content Loaded
document.addEventListener('DOMContentLoaded', function() {
    const isRecurringCheckbox = document.getElementById('isRecurring');
    const dateRangeFields = document.getElementById('dateRangeFields');
    const startDateInput = document.getElementById('startDate');
    const endDateInput = document.getElementById('endDate');
    const form = document.getElementById('availabilityForm');
    const modalError = document.getElementById('modalError');
    const modalErrorText = document.getElementById('modalErrorText');
    const modalErrorTitle = document.getElementById('modalErrorTitle');

    const today = new Date().toISOString().split('T')[0];
    startDateInput.min = today;
    endDateInput.min = today;

    function showError(message, fieldType = 'general') {
        modalErrorTitle.textContent = getErrorTitle(fieldType);
        modalErrorText.textContent = message;
        modalError.classList.remove('hidden');
        highlightErrorField(fieldType);
        setTimeout(() => {
            modalError.classList.add('hidden');
            clearErrorHighlights();
        }, 8000);
    }

    function getErrorTitle(fieldType) {
        const titles = {
            'time': 'Erreur de plage horaire :',
            'date': 'Erreur de dates :',
            'general': 'Erreur :'
        };
        return titles[fieldType] || titles.general;
    }

    function highlightErrorField(fieldType) {
        const fieldSelectors = {
            'time': ['.startTime-field', '.endTime-field'],
            'date': ['.startDate-field', '.endDate-field'],
            'day': ['.dayOfWeek-field']
        };
        const selectors = fieldSelectors[fieldType];
        if (selectors) {
            selectors.forEach(selector => {
                document.querySelectorAll(selector).forEach(field => {
                    field.classList.add('validation-error');
                });
            });
        }
    }

    function clearErrorHighlights() {
        document.querySelectorAll('.validation-error').forEach(field => {
            field.classList.remove('validation-error');
        });
    }

    function hideAllErrors() {
        modalError.classList.add('hidden');
        document.querySelectorAll('[id$="Error"]').forEach(el => el.classList.add('hidden'));
        clearErrorHighlights();
    }

    function toggleDateFields() {
        const isRecurring = isRecurringCheckbox.checked;
        if (isRecurring) {
            dateRangeFields.classList.add('hidden');
            startDateInput.removeAttribute('required');
            endDateInput.removeAttribute('required');
            startDateInput.value = '';
            endDateInput.value = '';
        } else {
            dateRangeFields.classList.remove('hidden');
            startDateInput.setAttribute('required', 'required');
            endDateInput.setAttribute('required', 'required');
        }
    }

    isRecurringCheckbox.addEventListener('change', toggleDateFields);

    function validateTimeOrder() {
        const startTime = document.getElementById('startTime').value;
        const endTime = document.getElementById('endTime').value;
        if (startTime && endTime && startTime >= endTime) {
            document.getElementById('timeOrderError').classList.remove('hidden');
            return false;
        } else {
            document.getElementById('timeOrderError').classList.add('hidden');
            return true;
        }
    }

    function validateDateOrder() {
        const startDate = startDateInput.value;
        const endDate = endDateInput.value;
        if (startDate && endDate && new Date(endDate) < new Date(startDate)) {
            document.getElementById('dateOrderError').classList.remove('hidden');
            return false;
        } else {
            document.getElementById('dateOrderError').classList.add('hidden');
            return true;
        }
    }

    document.getElementById('startTime').addEventListener('change', validateTimeOrder);
    document.getElementById('endTime').addEventListener('change', validateTimeOrder);
    startDateInput.addEventListener('change', validateDateOrder);
    endDateInput.addEventListener('change', validateDateOrder);

    form.addEventListener('submit', function(e) {
        e.preventDefault();
        hideAllErrors();

        const dayOfWeek = document.getElementById('dayOfWeek').value;
        const startTime = document.getElementById('startTime').value;
        const endTime = document.getElementById('endTime').value;
        const isRecurring = isRecurringCheckbox.checked;
        const startDate = startDateInput.value;
        const endDate = endDateInput.value;

        let hasError = false;

        if (!dayOfWeek) {
            document.getElementById('dayOfWeekError').classList.remove('hidden');
            showError('Veuillez sélectionner un jour de la semaine', 'day');
            hasError = true;
        }

        if (!startTime) {
            document.getElementById('startTimeError').classList.remove('hidden');
            showError('Veuillez saisir une heure de début', 'time');
            hasError = true;
        }

        if (!endTime) {
            document.getElementById('endTimeError').classList.remove('hidden');
            showError('Veuillez saisir une heure de fin', 'time');
            hasError = true;
        }

        if (startTime && endTime && startTime >= endTime) {
            document.getElementById('timeOrderError').classList.remove('hidden');
            showError('L\'heure de fin doit être après l\'heure de début', 'time');
            hasError = true;
        }

        if (!isRecurring) {
            if (!startDate) {
                document.getElementById('startDateError').classList.remove('hidden');
                showError('Veuillez sélectionner une date de début', 'date');
                hasError = true;
            }

            if (!endDate) {
                document.getElementById('endDateError').classList.remove('hidden');
                showError('Veuillez sélectionner une date de fin', 'date');
                hasError = true;
            }

            if (startDate && endDate && new Date(endDate) < new Date(startDate)) {
                document.getElementById('dateOrderError').classList.remove('hidden');
                showError('La date de fin doit être après la date de début', 'date');
                hasError = true;
            }
        }

        if (!hasError) {
            form.submit();
        }
    });

    renderCalendar();
    toggleDateFields();

    // Expose functions globally
    window.hideAllErrors = hideAllErrors;
    window.showError = showError;
});

// Calendar rendering
function renderCalendar() {
    const year = currentDate.getFullYear();
    const month = currentDate.getMonth();

    // Update month title
    const monthNames = ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
        'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'];
    document.getElementById('currentMonth').textContent = `${monthNames[month]} ${year}`;

    // Get first day of month and number of days
    const firstDay = new Date(year, month, 1);
    const lastDay = new Date(year, month + 1, 0);
    const daysInMonth = lastDay.getDate();
    const startingDayOfWeek = firstDay.getDay() === 0 ? 6 : firstDay.getDay() - 1;

    // Get previous month days
    const prevMonthLastDay = new Date(year, month, 0).getDate();

    const grid = document.getElementById('calendarGrid');
    // Clear existing days (keep headers)
    while (grid.children.length > 7) {
        grid.removeChild(grid.lastChild);
    }

    const today = new Date();
    today.setHours(0, 0, 0, 0);

    // Add previous month days
    for (let i = startingDayOfWeek - 1; i >= 0; i--) {
        const day = prevMonthLastDay - i;
        const dayEl = createDayElement(day, true, new Date(year, month - 1, day));
        grid.appendChild(dayEl);
    }

    // Add current month days
    for (let day = 1; day <= daysInMonth; day++) {
        const date = new Date(year, month, day);
        date.setHours(0, 0, 0, 0);
        const isToday = date.getTime() === today.getTime();
        const dayEl = createDayElement(day, false, date, isToday);
        grid.appendChild(dayEl);
    }

    // Add next month days
    const totalCells = grid.children.length - 7;
    const remainingCells = Math.ceil(totalCells / 7) * 7 - totalCells;
    for (let day = 1; day <= remainingCells; day++) {
        const dayEl = createDayElement(day, true, new Date(year, month + 1, day));
        grid.appendChild(dayEl);
    }
}

function createDayElement(dayNumber, isOtherMonth, date, isToday = false) {
    const dayEl = document.createElement('div');
    dayEl.className = 'calendar-day';
    if (isOtherMonth) dayEl.classList.add('other-month');
    if (isToday) dayEl.classList.add('today');

    const dayNumberEl = document.createElement('div');
    dayNumberEl.className = 'day-number';
    dayNumberEl.textContent = dayNumber;
    dayEl.appendChild(dayNumberEl);

    // Add availabilities
    const dayOfWeek = date.getDay() === 0 ? 7 : date.getDay();
    const dateStr = date.toISOString().split('T')[0];

    availabilities.forEach(avail => {
        if (!avail.available) return;

        let shouldShow = false;

        if (avail.recurring) {
            shouldShow = avail.dayOfWeek === dayOfWeek;
        } else {
            if (avail.startDate && avail.endDate) {
                shouldShow = dateStr >= avail.startDate && dateStr <= avail.endDate && avail.dayOfWeek === dayOfWeek;
            }
        }

        if (shouldShow) {
            const slotEl = document.createElement('div');
            slotEl.className = 'availability-slot';
            if (avail.recurring) slotEl.classList.add('recurring');

            const icon = avail.recurring ?
                '<i class="fas fa-repeat"></i>' :
                '<i class="fas fa-calendar"></i>';

            slotEl.innerHTML = `${icon} ${avail.startTime}-${avail.endTime}`;
            slotEl.onclick = (e) => {
                e.stopPropagation();
                showDeleteModal(avail);
            };
            dayEl.appendChild(slotEl);
        }
    });

    return dayEl;
}

function showDeleteModal(availability) {
    deleteAvailabilityId = availability.id;
    const messageEl = document.getElementById('deleteMessage');

    if (availability.recurring) {
        messageEl.innerHTML = `
            <span class="block mb-2">Cette disponibilité est <strong>récurrente</strong>.</span>
            <span class="block text-sm">Elle sera supprimée pour toutes les semaines.</span>
        `;
    } else {
        messageEl.innerHTML = `
            <span class="block mb-2">Cette disponibilité sera supprimée.</span>
            <span class="block text-sm text-gray-500">Du ${formatDate(availability.startDate)} au ${formatDate(availability.endDate)}</span>
        `;
    }

    openDeleteModal();
}

function formatDate(dateStr) {
    if (!dateStr) return '';
    const date = new Date(dateStr);
    return date.toLocaleDateString('fr-FR');
}

// Navigation functions
function previousMonth() {
    currentDate.setMonth(currentDate.getMonth() - 1);
    renderCalendar();
}

function nextMonth() {
    currentDate.setMonth(currentDate.getMonth() + 1);
    renderCalendar();
}

function goToToday() {
    currentDate = new Date();
    renderCalendar();
}

// Modal functions
function openAddAvailabilityModal() {
    const modal = document.getElementById('addAvailabilityModal');
    modal.classList.remove('hidden');
    modal.classList.add('flex');

    const modalError = document.getElementById('modalError');
    if (modalError) modalError.classList.add('hidden');

    document.querySelectorAll('[id$="Error"]').forEach(el => el.classList.add('hidden'));
    document.querySelectorAll('.validation-error').forEach(field => {
        field.classList.remove('validation-error');
    });
}

function closeAddAvailabilityModal() {
    const modal = document.getElementById('addAvailabilityModal');
    modal.classList.add('hidden');
    modal.classList.remove('flex');
    document.getElementById('availabilityForm').reset();
    document.getElementById('isRecurring').checked = true;

    const modalError = document.getElementById('modalError');
    if (modalError) modalError.classList.add('hidden');

    document.querySelectorAll('[id$="Error"]').forEach(el => el.classList.add('hidden'));
    document.querySelectorAll('.validation-error').forEach(field => {
        field.classList.remove('validation-error');
    });

    const event = new Event('change');
    document.getElementById('isRecurring').dispatchEvent(event);
}

function openDeleteModal() {
    const modal = document.getElementById('deleteModal');
    modal.classList.remove('hidden');
    modal.classList.add('flex');
}

function closeDeleteModal() {
    const modal = document.getElementById('deleteModal');
    modal.classList.add('hidden');
    modal.classList.remove('flex');
    deleteAvailabilityId = null;
}

function confirmDelete() {
    if (deleteAvailabilityId) {
        console.log('🗑️ Suppression de la disponibilité:', deleteAvailabilityId);
        const contextPath = document.querySelector('nav a').getAttribute('href').split('/doctor')[0];

        // Afficher un loader pendant la suppression
        const deleteBtn = event.target;
        const originalText = deleteBtn.innerHTML;
        deleteBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>Suppression...';
        deleteBtn.disabled = true;

        window.location.href = contextPath + '/doctor/availabilities/delete?id=' + deleteAvailabilityId;
    }
}

function refreshCalendar() {
    console.log('🔄 Rafraîchissement du calendrier...');
    renderCalendar();
}

// Event listeners for modals
document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('addAvailabilityModal')?.addEventListener('click', function(e) {
        if (e.target === this) {
            closeAddAvailabilityModal();
        }
    });

    document.getElementById('deleteModal')?.addEventListener('click', function(e) {
        if (e.target === this) {
            closeDeleteModal();
        }
    });

    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            closeAddAvailabilityModal();
            closeDeleteModal();
        }
    });
});