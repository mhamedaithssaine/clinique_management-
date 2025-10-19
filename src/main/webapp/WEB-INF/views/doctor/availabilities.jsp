<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Mes Disponibilités</title>
    <meta charset="UTF-8">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css' rel='stylesheet' />
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        * {
            font-family: 'Inter', sans-serif;
        }
        .glass-effect {
            background: rgba(255, 255, 255, 0.7);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
        .nav-link {
            position: relative;
            overflow: hidden;
        }
        .nav-link::before {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background: linear-gradient(90deg, #667eea, #764ba2);
            transition: width 0.3s ease;
        }
        .nav-link:hover::before {
            width: 100%;
        }
        #calendar {
            max-width: 100%;
            margin: 0;
        }
        .error-message {
            animation: shake 0.3s;
        }
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-10px); }
            75% { transform: translateX(10px); }
        }
        .fc-event {
            cursor: pointer;
            border: none !important;
            border-radius: 8px !important;
        }
        .validation-error {
            border-color: #ef4444 !important;
            box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.1) !important;
        }
        .fc-time-grid-event .fc-content {
            padding: 4px 8px;
        }
        .fc .fc-button-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
            border: none !important;
            border-radius: 8px !important;
            padding: 8px 16px !important;
            font-weight: 600 !important;
        }
        .fc .fc-button-primary:hover {
            background: linear-gradient(135deg, #5568d3 0%, #653a8e 100%) !important;
            transform: translateY(-1px);
        }
        .fc .fc-toolbar-title {
            font-size: 1.5rem !important;
            font-weight: 700 !important;
            color: #1f2937 !important;
        }
        .fc .fc-col-header-cell {
            background: #f9fafb !important;
            padding: 12px 0 !important;
            font-weight: 600 !important;
            color: #6b7280 !important;
        }
        .fc .fc-scrollgrid {
            border: none !important;
            border-radius: 12px !important;
            overflow: hidden;
        }
        .fc-theme-standard td, .fc-theme-standard th {
            border-color: #e5e7eb !important;
        }
        .modal-backdrop {
            backdrop-filter: blur(4px);
            animation: fadeIn 0.2s ease-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        .modal-content {
            animation: slideUp 0.3s ease-out;
        }
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .delete-modal {
            animation: zoomIn 0.2s ease-out;
        }
        @keyframes zoomIn {
            from {
                opacity: 0;
                transform: scale(0.95);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }
    </style>
</head>

<body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen">
<!-- Navbar -->
<nav class="glass-effect sticky top-0 z-50 shadow-sm">
    <div class="container mx-auto px-6">
        <div class="flex justify-between items-center py-4">
            <div class="flex items-center space-x-8">
                <a href="${pageContext.request.contextPath}/doctor/dashboard" class="flex items-center space-x-3 group">
                    <div class="w-11 h-11 bg-gradient-to-br from-purple-600 to-blue-500 rounded-2xl flex items-center justify-center transform group-hover:rotate-6 transition-transform duration-300 shadow-lg">
                        <i class="fas fa-hospital-user text-white text-xl"></i>
                    </div>
                    <span class="text-2xl font-bold bg-gradient-to-r from-purple-600 to-blue-600 bg-clip-text text-transparent">
                        MediCare
                    </span>
                </a>
                <div class="hidden md:flex space-x-1">
                    <a href="${pageContext.request.contextPath}/doctor/dashboard"
                       class="nav-link px-4 py-2 rounded-xl text-gray-700 hover:text-purple-600 font-medium transition-all">
                        <i class="fas fa-chart-pie mr-2"></i>Tableau de bord
                    </a>
                    <a href="${pageContext.request.contextPath}/doctor/availabilities"
                       class="nav-link px-4 py-2 rounded-xl bg-gradient-to-r from-purple-600 to-blue-600 text-white font-medium shadow-lg">
                        <i class="fas fa-calendar-check mr-2"></i>Disponibilités
                    </a>
                </div>
            </div>
            <div class="flex items-center space-x-4">
                <button class="relative p-2.5 text-gray-600 hover:bg-white/50 rounded-xl transition-all">
                    <i class="fas fa-bell text-xl"></i>
                    <span class="absolute top-1.5 right-1.5 w-2 h-2 bg-red-500 rounded-full animate-pulse"></span>
                </button>
                <div class="flex items-center space-x-3 pl-4 border-l border-gray-300">
                    <div class="w-10 h-10 bg-gradient-to-br from-purple-500 to-pink-500 rounded-full flex items-center justify-center shadow-md">
                        <span class="text-white font-semibold">D</span>
                    </div>
                    <a href="${pageContext.request.contextPath}/logout"
                       class="text-gray-700 hover:text-red-500 font-medium transition-all flex items-center space-x-2">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Déconnexion</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container mx-auto px-6 py-8">
    <!-- Breadcrumb -->
    <div class="flex items-center space-x-2 text-sm text-gray-600 mb-6">
        <a href="${pageContext.request.contextPath}/doctor/dashboard" class="hover:text-purple-600 transition-colors">
            <i class="fas fa-home mr-1"></i>
        </a>
        <i class="fas fa-chevron-right text-xs"></i>
        <span class="text-gray-800 font-medium">Disponibilités</span>
    </div>

    <!-- Header Section -->
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
        <div>
            <h1 class="text-4xl font-bold text-gray-800 mb-2">Mes Disponibilités</h1>
            <p class="text-gray-600">Gérez vos créneaux horaires et votre emploi du temps</p>
        </div>
        <button onclick="openAddAvailabilityModal()"
                class="inline-flex items-center px-6 py-3 bg-gradient-to-r from-purple-600 to-blue-600 text-white font-semibold rounded-xl shadow-lg hover:shadow-xl transition-all transform hover:-translate-y-1">
            <i class="fas fa-plus mr-2"></i>
            Ajouter une disponibilité
        </button>
    </div>

    <!-- Success Message -->
    <c:if test="${param.success != null}">
        <div class="bg-green-50 border-l-4 border-green-500 text-green-700 px-6 py-4 rounded-xl mb-6 flex items-center shadow-sm">
            <div class="w-10 h-10 bg-green-100 rounded-full flex items-center justify-center mr-4">
                <i class="fas fa-check text-green-600 text-lg"></i>
            </div>
            <div>
                <p class="font-semibold">Succès !</p>
                <p class="text-sm">Disponibilité ajoutée avec succès</p>
            </div>
        </div>
    </c:if>

    <!-- Error Message -->
    <c:if test="${not empty error}">
        <div class="bg-red-50 border-l-4 border-red-500 text-red-700 px-6 py-4 rounded-xl mb-6 flex items-center shadow-sm error-message">
            <div class="w-10 h-10 bg-red-100 rounded-full flex items-center justify-center mr-4">
                <i class="fas fa-exclamation-circle text-red-600 text-lg"></i>
            </div>
            <div>
                <p class="font-semibold">Erreur</p>
                <p class="text-sm">${error}</p>
            </div>
        </div>
    </c:if>

    <!-- Calendar Card -->
    <div class="bg-white rounded-2xl shadow-xl p-6 border border-gray-100">
        <div id="calendar"></div>
    </div>
</div>

<!-- Add Availability Modal -->
<div id="addAvailabilityModal" class="fixed inset-0 bg-black bg-opacity-50 hidden items-center justify-center z-50 modal-backdrop">
    <div class="bg-white rounded-2xl shadow-2xl p-8 max-w-lg w-full mx-4 max-h-[90vh] overflow-y-auto modal-content">
        <div class="flex items-center justify-between mb-6">
            <h2 class="text-2xl font-bold text-gray-800 flex items-center">
                <div class="w-10 h-10 bg-gradient-to-br from-purple-100 to-blue-100 rounded-xl flex items-center justify-center mr-3">
                    <i class="fas fa-calendar-plus text-purple-600"></i>
                </div>
                Ajouter une disponibilité
            </h2>
            <button onclick="closeAddAvailabilityModal()" class="text-gray-400 hover:text-gray-600 transition-colors">
                <i class="fas fa-times text-xl"></i>
            </button>
        </div>

        <!-- Modal Error -->
        <div id="modalError" class="hidden bg-red-50 border-l-4 border-red-500 text-red-700 px-4 py-3 rounded-xl mb-4 error-message">
            <div class="flex items-center">
                <i class="fas fa-exclamation-circle mr-2"></i>
                <div>
                    <p class="font-semibold text-sm" id="modalErrorTitle">Erreur :</p>
                    <p class="text-sm" id="modalErrorText"></p>
                </div>
            </div>
        </div>

        <form action="${pageContext.request.contextPath}/doctor/availabilities" method="post" id="availabilityForm" novalidate>
            <div class="space-y-5">
                <!-- Day of Week -->
                <div>
                    <label for="dayOfWeek" class="block text-sm font-semibold text-gray-700 mb-2">
                        Jour de la semaine <span class="text-red-500">*</span>
                    </label>
                    <div class="relative">
                        <i class="fas fa-calendar-day absolute left-4 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
                        <select id="dayOfWeek" name="dayOfWeek" required
                                class="dayOfWeek-field block w-full pl-12 pr-4 py-3 border border-gray-300 rounded-xl shadow-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none transition-all">
                            <option value="">Sélectionner un jour</option>
                            <option value="1">Lundi</option>
                            <option value="2">Mardi</option>
                            <option value="3">Mercredi</option>
                            <option value="4">Jeudi</option>
                            <option value="5">Vendredi</option>
                            <option value="6">Samedi</option>
                            <option value="7">Dimanche</option>
                        </select>
                    </div>
                    <p class="text-xs text-red-500 mt-1 hidden" id="dayOfWeekError">Veuillez sélectionner un jour</p>
                </div>

                <!-- Time Range -->
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label for="startTime" class="block text-sm font-semibold text-gray-700 mb-2">
                            Heure de début <span class="text-red-500">*</span>
                        </label>
                        <div class="relative">
                            <i class="fas fa-clock absolute left-4 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
                            <input type="time" id="startTime" name="startTime" required
                                   class="startTime-field block w-full pl-12 pr-4 py-3 border border-gray-300 rounded-xl shadow-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none transition-all">
                        </div>
                        <p class="text-xs text-red-500 mt-1 hidden" id="startTimeError">Heure requise</p>
                    </div>
                    <div>
                        <label for="endTime" class="block text-sm font-semibold text-gray-700 mb-2">
                            Heure de fin <span class="text-red-500">*</span>
                        </label>
                        <div class="relative">
                            <i class="fas fa-clock absolute left-4 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
                            <input type="time" id="endTime" name="endTime" required
                                   class="endTime-field block w-full pl-12 pr-4 py-3 border border-gray-300 rounded-xl shadow-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none transition-all">
                        </div>
                        <p class="text-xs text-red-500 mt-1 hidden" id="endTimeError">Heure requise</p>
                    </div>
                </div>
                <p class="text-xs text-red-500 mt-1 hidden" id="timeOrderError">L'heure de fin doit être après l'heure de début</p>

                <!-- Recurring Option -->
                <div class="bg-gradient-to-br from-purple-50 to-blue-50 p-4 rounded-xl border border-purple-200">
                    <div class="flex items-start">
                        <input type="checkbox" id="isRecurring" name="isRecurring" value="true" checked
                               class="isRecurring-field h-5 w-5 text-purple-600 focus:ring-purple-500 border-gray-300 rounded cursor-pointer mt-0.5">
                        <div class="ml-3">
                            <label for="isRecurring" class="block text-sm font-semibold text-gray-700 cursor-pointer">
                                Répéter chaque semaine
                            </label>
                            <p class="text-xs text-gray-600 mt-1">
                                Cette disponibilité sera active toutes les semaines pour ce jour
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Date Range (Non-recurring) -->
                <div id="dateRangeFields" class="hidden space-y-4 bg-blue-50 p-4 rounded-xl border border-blue-200">
                    <p class="text-sm text-blue-700 font-semibold mb-3 flex items-center">
                        <i class="fas fa-info-circle mr-2"></i>
                        Période de disponibilité
                    </p>
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label for="startDate" class="block text-sm font-semibold text-gray-700 mb-2">
                                Date de début <span class="text-red-500">*</span>
                            </label>
                            <input type="date" id="startDate" name="startDate"
                                   class="startDate-field block w-full px-4 py-3 border border-gray-300 rounded-xl shadow-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none transition-all">
                            <p class="text-xs text-red-500 mt-1 hidden" id="startDateError">Date requise</p>
                        </div>
                        <div>
                            <label for="endDate" class="block text-sm font-semibold text-gray-700 mb-2">
                                Date de fin <span class="text-red-500">*</span>
                            </label>
                            <input type="date" id="endDate" name="endDate"
                                   class="endDate-field block w-full px-4 py-3 border border-gray-300 rounded-xl shadow-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none transition-all">
                            <p class="text-xs text-red-500 mt-1 hidden" id="endDateError">Date requise</p>
                        </div>
                    </div>
                    <p class="text-xs text-red-500 mt-1 hidden" id="dateOrderError">La date de fin doit être après la date de début</p>
                </div>
            </div>

            <!-- Actions -->
            <div class="flex justify-end space-x-3 mt-8 pt-6 border-t border-gray-200">
                <button type="button" onclick="closeAddAvailabilityModal()"
                        class="px-6 py-3 border-2 border-gray-300 rounded-xl text-gray-700 font-semibold hover:bg-gray-50 transition-all">
                    Annuler
                </button>
                <button type="submit"
                        class="px-6 py-3 bg-gradient-to-r from-purple-600 to-blue-600 text-white font-semibold rounded-xl shadow-lg hover:shadow-xl transition-all transform hover:-translate-y-1">
                    <i class="fas fa-save mr-2"></i>
                    Enregistrer
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="fixed inset-0 bg-black bg-opacity-50 hidden items-center justify-center z-50 modal-backdrop">
    <div class="bg-white rounded-2xl shadow-2xl p-8 max-w-md w-full mx-4 delete-modal">
        <div class="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <i class="fas fa-trash-alt text-red-600 text-2xl"></i>
        </div>
        <h3 class="text-2xl font-bold text-gray-800 text-center mb-2">Supprimer la disponibilité ?</h3>
        <p class="text-gray-600 text-center mb-6" id="deleteMessage">
            Êtes-vous sûr de vouloir supprimer cette disponibilité ?
        </p>
        <div class="flex space-x-3">
            <button onclick="closeDeleteModal()"
                    class="flex-1 px-6 py-3 border-2 border-gray-300 rounded-xl text-gray-700 font-semibold hover:bg-gray-50 transition-all">
                Annuler
            </button>
            <button onclick="confirmDelete()"
                    class="flex-1 px-6 py-3 bg-gradient-to-r from-red-600 to-red-500 text-white font-semibold rounded-xl shadow-lg hover:shadow-xl transition-all">
                Supprimer
            </button>
        </div>
    </div>
</div>

<!-- FullCalendar -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/locales/fr.js'></script>
<script>
    let deleteAvailabilityId = null;

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
                'recurring': 'Erreur de récurrence :',
                'overlap': 'Conflit de disponibilité :',
                'general': 'Erreur :'
            };
            return titles[fieldType] || titles.general;
        }

        function highlightErrorField(fieldType) {
            const fieldSelectors = {
                'time': ['.startTime-field', '.endTime-field'],
                'date': ['.startDate-field', '.endDate-field'],
                'recurring': ['.isRecurring-field'],
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

        const calendarEl = document.getElementById('calendar');
        const calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'timeGridWeek',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'timeGridWeek,timeGridDay'
            },
            locale: 'fr',
            allDaySlot: false,
            slotMinTime: "06:00:00",
            slotMaxTime: "22:00:00",
            slotDuration: '00:30:00',
            height: 'auto',
            events: [
                <c:forEach var="availability" items="${availabilities}" varStatus="status">
                <c:if test="${availability.available}">
                {
                    id: '${availability.id}',
                    title: 'Disponible',
                    <c:choose>
                    <c:when test="${availability.recurring}">
                    daysOfWeek: [${availability.dayOfWeek}],
                    startTime: '${availability.startTime}',
                    endTime: '${availability.endTime}',
                    startRecur: '2024-01-01',
                    </c:when>
                    <c:otherwise>
                    start: '${availability.startDate}T${availability.startTime}',
                    end: '${availability.endDate}T${availability.endTime}',
                    </c:otherwise>
                    </c:choose>
                    backgroundColor: '#8b5cf6',
                    borderColor: '#8b5cf6',
                    textColor: 'white',
                    extendedProps: {
                        availabilityId: '${availability.id}',
                        isRecurring: ${availability.recurring},
                        startTime: '${availability.startTime}',
                        endTime: '${availability.endTime}'
                    }
                }<c:if test="${!status.last}">,</c:if>
                </c:if>
                </c:forEach>
            ],
            eventClick: function(info) {
                deleteAvailabilityId = info.event.extendedProps.availabilityId;
                const isRecurring = info.event.extendedProps.isRecurring;

                const messageEl = document.getElementById('deleteMessage');
                if (isRecurring) {
                    messageEl.innerHTML = `
                        <span class="block mb-2">Cette disponibilité est <strong>récurrente</strong>.</span>
                        <span class="block text-sm">Elle sera supprimée pour toutes les semaines.</span>
                    `;
                } else {
                    const startDate = info.event.start ?
                        info.event.start.toLocaleDateString('fr-FR') : '';
                    const endDate = info.event.end ?
                        info.event.end.toLocaleDateString('fr-FR') : '';
                    messageEl.innerHTML = `
                        <span class="block mb-2">Cette disponibilité sera supprimée.</span>
                        <span class="block text-sm text-gray-500">Du ${startDate} au ${endDate}</span>
                    `;
                }

                openDeleteModal();
            },
            eventContent: function(arg) {
                const isRecurring = arg.event.extendedProps.isRecurring;
                const startTime = arg.event.extendedProps.startTime;
                const endTime = arg.event.extendedProps.endTime;

                let iconHtml = isRecurring ?
                    '<i class="fas fa-repeat text-xs"></i>' :
                    '<i class="fas fa-calendar text-xs"></i>';

                return {
                    html: `
                        <div class="px-2 py-1">
                            <div class="flex items-center justify-between mb-1">
                                <span class="font-semibold text-sm flex items-center gap-1">
                                    <i class="fas fa-user-md"></i>
                                    Disponible
                                </span>
                                ${iconHtml}
                            </div>
                            <div class="text-xs opacity-90">
                                ${startTime} - ${endTime}
                            </div>
                        </div>
                    `
                };
            },
            eventDidMount: function(info) {
                info.el.style.cursor = 'pointer';
                info.el.style.transition = 'all 0.2s ease';

                info.el.addEventListener('mouseenter', function() {
                    this.style.transform = 'scale(1.02)';
                    this.style.boxShadow = '0 4px 12px rgba(139, 92, 246, 0.4)';
                });

                info.el.addEventListener('mouseleave', function() {
                    this.style.transform = 'scale(1)';
                    this.style.boxShadow = 'none';
                });
            }
        });

        calendar.render();
        toggleDateFields();
    });

    function openAddAvailabilityModal() {
        const modal = document.getElementById('addAvailabilityModal');
        modal.classList.remove('hidden');
        modal.classList.add('flex');
        document.getElementById('modalError').classList.add('hidden');
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
        document.getElementById('modalError').classList.add('hidden');
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
            window.location.href = '${pageContext.request.contextPath}/doctor/availabilities/delete?id=' + deleteAvailabilityId;
        }
    }

    document.getElementById('addAvailabilityModal').addEventListener('click', function(e) {
        if (e.target === this) {
            closeAddAvailabilityModal();
        }
    });

    document.getElementById('deleteModal').addEventListener('click', function(e) {
        if (e.target === this) {
            closeDeleteModal();
        }
    });

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            closeAddAvailabilityModal();
            closeDeleteModal();
        }
    });
</script>

</body>
</html>