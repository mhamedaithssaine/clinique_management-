<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Mes Disponibilités</title>
    <meta charset="UTF-8">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
        .error-message {
            animation: shake 0.3s;
        }
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-10px); }
            75% { transform: translateX(10px); }
        }
        .validation-error {
            border-color: #ef4444 !important;
            box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.1) !important;
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
        .delete-modal, .action-modal {
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

        /* Calendar Styles */
        .calendar-grid {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 8px;
        }
        .calendar-header {
            font-weight: 600;
            text-align: center;
            padding: 12px;
            color: #6b7280;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        .calendar-day {
            min-height: 100px;
            padding: 8px;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            background: white;
            transition: all 0.2s ease;
            cursor: pointer;
        }
        .calendar-day:hover {
            border-color: #8b5cf6;
            box-shadow: 0 2px 8px rgba(139, 92, 246, 0.15);
        }
        .calendar-day.other-month {
            background: #f9fafb;
            opacity: 0.5;
        }
        .calendar-day.today {
            border: 2px solid #8b5cf6;
            background: #faf5ff;
        }
        .day-number {
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 4px;
            font-size: 0.875rem;
        }
        .availability-slot {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
            padding: 4px 8px;
            border-radius: 6px;
            font-size: 0.75rem;
            margin-top: 4px;
            display: flex;
            align-items: center;
            gap: 4px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .availability-slot:hover {
            transform: scale(1.05);
            box-shadow: 0 2px 8px rgba(16, 185, 129, 0.3);
        }
        .availability-slot.recurring {
            background: linear-gradient(135deg, #8b5cf6 0%, #7c3aed 100%);
        }
        .availability-slot.recurring:hover {
            box-shadow: 0 2px 8px rgba(139, 92, 246, 0.3);
        }
        .view-toggle button {
            transition: all 0.2s ease;
        }
        .view-toggle button.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
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

    <!-- Messages -->
    <c:if test="${param.success == 'deleted'}">
        <div class="bg-green-50 border-l-4 border-green-500 text-green-700 px-6 py-4 rounded-xl mb-6 flex items-center shadow-sm">
            <div class="w-10 h-10 bg-green-100 rounded-full flex items-center justify-center mr-4">
                <i class="fas fa-check text-green-600 text-lg"></i>
            </div>
            <div>
                <p class="font-semibold">Succès !</p>
                <p class="text-sm">Disponibilité supprimée avec succès</p>
            </div>
        </div>
    </c:if>

    <c:if test="${param.success == 'updated'}">
        <div class="bg-green-50 border-l-4 border-green-500 text-green-700 px-6 py-4 rounded-xl mb-6 flex items-center shadow-sm">
            <div class="w-10 h-10 bg-green-100 rounded-full flex items-center justify-center mr-4">
                <i class="fas fa-check text-green-600 text-lg"></i>
            </div>
            <div>
                <p class="font-semibold">Succès !</p>
                <p class="text-sm">Disponibilité modifiée avec succès</p>
            </div>
        </div>
    </c:if>

    <c:if test="${param.success == 'true'}">
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

    <c:if test="${param.error != null}">
        <div class="bg-red-50 border-l-4 border-red-500 text-red-700 px-6 py-4 rounded-xl mb-6 flex items-center shadow-sm error-message">
            <div class="w-10 h-10 bg-red-100 rounded-full flex items-center justify-center mr-4">
                <i class="fas fa-exclamation-circle text-red-600 text-lg"></i>
            </div>
            <div>
                <p class="font-semibold">Erreur</p>
                <p class="text-sm">Une erreur est survenue</p>
            </div>
        </div>
    </c:if>

    <!-- Calendar Card -->
    <div class="bg-white rounded-2xl shadow-xl p-6 border border-gray-100">
        <!-- Calendar Header -->
        <div class="flex justify-between items-center mb-6">
            <div class="flex items-center space-x-4">
                <button onclick="previousMonth()" class="p-2 hover:bg-gray-100 rounded-lg transition-colors">
                    <i class="fas fa-chevron-left text-gray-600"></i>
                </button>
                <h2 class="text-2xl font-bold text-gray-800" id="currentMonth"></h2>
                <button onclick="nextMonth()" class="p-2 hover:bg-gray-100 rounded-lg transition-colors">
                    <i class="fas fa-chevron-right text-gray-600"></i>
                </button>
            </div>
            <button onclick="goToToday()" class="px-4 py-2 bg-gradient-to-r from-purple-600 to-blue-600 text-white rounded-lg font-medium hover:shadow-lg transition-all">
                Aujourd'hui
            </button>
        </div>

        <!-- Legend -->
        <div class="flex items-center gap-6 mb-6 p-4 bg-gray-50 rounded-xl">
            <div class="flex items-center gap-2">
                <div class="w-4 h-4 rounded" style="background: linear-gradient(135deg, #10b981 0%, #059669 100%);"></div>
                <span class="text-sm text-gray-700">Disponibilité ponctuelle</span>
            </div>
            <div class="flex items-center gap-2">
                <div class="w-4 h-4 rounded" style="background: linear-gradient(135deg, #8b5cf6 0%, #7c3aed 100%);"></div>
                <span class="text-sm text-gray-700">Disponibilité récurrente</span>
            </div>
        </div>

        <!-- Calendar Grid -->
        <div class="calendar-grid" id="calendarGrid">
            <!-- Headers -->
            <div class="calendar-header">Lun</div>
            <div class="calendar-header">Mar</div>
            <div class="calendar-header">Mer</div>
            <div class="calendar-header">Jeu</div>
            <div class="calendar-header">Ven</div>
            <div class="calendar-header">Sam</div>
            <div class="calendar-header">Dim</div>
            <!-- Days will be inserted here by JavaScript -->
        </div>
    </div>
</div>

<!-- Add/Edit Availability Modal -->
<div id="addAvailabilityModal" class="fixed inset-0 bg-black bg-opacity-50 hidden items-center justify-center z-50 modal-backdrop">
    <div class="bg-white rounded-2xl shadow-2xl p-8 max-w-lg w-full mx-4 max-h-[90vh] overflow-y-auto modal-content">
        <div class="flex items-center justify-between mb-6">
            <h2 class="text-2xl font-bold text-gray-800 flex items-center" id="modalTitle">
                <div class="w-10 h-10 bg-gradient-to-br from-purple-100 to-blue-100 rounded-xl flex items-center justify-center mr-3">
                    <i class="fas fa-calendar-plus text-purple-600"></i>
                </div>
                Ajouter une disponibilité
            </h2>
            <button onclick="closeAddAvailabilityModal()" class="text-gray-400 hover:text-gray-600 transition-colors">
                <i class="fas fa-times text-xl"></i>
            </button>
        </div>

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

            <div class="flex justify-end space-x-3 mt-8 pt-6 border-t border-gray-200">
                <button type="button" onclick="closeAddAvailabilityModal()"
                        class="px-6 py-3 border-2 border-gray-300 rounded-xl text-gray-700 font-semibold hover:bg-gray-50 transition-all">
                    Annuler
                </button>
                <button type="submit" id="submitButton"
                        class="px-6 py-3 bg-gradient-to-r from-purple-600 to-blue-600 text-white font-semibold rounded-xl shadow-lg hover:shadow-xl transition-all transform hover:-translate-y-1">
                    <i class="fas fa-save mr-2"></i>
                    Enregistrer
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Action Modal (Edit/Delete) -->
<div id="actionModal" class="fixed inset-0 bg-black bg-opacity-50 hidden items-center justify-center z-50 modal-backdrop">
    <div class="bg-white rounded-2xl shadow-2xl p-8 max-w-md w-full mx-4 action-modal">
        <div class="w-16 h-16 bg-gradient-to-br from-purple-100 to-blue-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <i class="fas fa-calendar-check text-purple-600 text-2xl"></i>
        </div>
        <h3 class="text-2xl font-bold text-gray-800 text-center mb-2">Gérer la disponibilité</h3>
        <p class="text-gray-600 text-center mb-6" id="actionMessage">
            Que souhaitez-vous faire avec cette disponibilité ?
        </p>
        <div class="flex space-x-3">
            <button onclick="closeActionModal()"
                    class="flex-1 px-6 py-3 border-2 border-gray-300 rounded-xl text-gray-700 font-semibold hover:bg-gray-50 transition-all">
                Annuler
            </button>
            <button id="editButton"
                    class="flex-1 px-6 py-3 bg-gradient-to-r from-blue-600 to-blue-500 text-white font-semibold rounded-xl shadow-lg hover:shadow-xl transition-all">
                <i class="fas fa-edit mr-2"></i>Modifier
            </button>
            <button id="deleteButton"
                    class="flex-1 px-6 py-3 bg-gradient-to-r from-red-600 to-red-500 text-white font-semibold rounded-xl shadow-lg hover:shadow-xl transition-all">
                <i class="fas fa-trash mr-2"></i>Supprimer
            </button>
        </div>
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

<script>
    // Parse availabilities from JSP and pass to external script
    const availabilitiesData = [];
    <c:forEach var="availability" items="${availabilities}">
    <c:if test="${availability.available}">
    availabilitiesData.push({
        id: '${availability.id}',
        dayOfWeek: ${availability.dayOfWeek},
        startTime: '${availability.startTime}',
        endTime: '${availability.endTime}',
        recurring: ${availability.recurring},
        startDate: '${not empty availability.startDate ? availability.startDate : ""}',
        endDate: '${not empty availability.endDate ? availability.endDate : ""}',
        available: true
    });
    </c:if>
    </c:forEach>
</script>

<script src="${pageContext.request.contextPath}/assets/js/hook.js"></script>

<script>
    initAvailabilities(availabilitiesData);
</script>

</body>
</html>