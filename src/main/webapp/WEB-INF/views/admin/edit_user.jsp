<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Éditer un Utilisateur</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#0ea5e9',
                        secondary: '#06b6d4',
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen">
<!-- Navbar -->
<nav class="bg-white shadow-lg border-b border-gray-200">
    <div class="container mx-auto px-6">
        <div class="flex justify-between items-center py-4">
            <div class="flex items-center space-x-8">
                <a href="#" class="flex items-center space-x-3">
                    <div class="w-10 h-10 bg-gradient-to-br from-cyan-500 to-blue-600 rounded-xl flex items-center justify-center">
                        <i class="fas fa-hospital text-white text-xl"></i>
                    </div>
                    <span class="text-2xl font-bold bg-gradient-to-r from-cyan-600 to-blue-600 bg-clip-text text-transparent">
                        MediCare Admin
                    </span>
                </a>
            </div>
            <div class="flex items-center space-x-4">
                <a href="${pageContext.request.contextPath}/logout"
                   class="text-gray-600 hover:text-red-600 font-medium transition-all">
                    <i class="fas fa-sign-out-alt mr-2"></i>Déconnexion
                </a>
            </div>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container mx-auto px-6 py-8">
    <!-- Page Header -->
    <div class="flex justify-between items-center mb-8">
        <div>
            <h1 class="text-3xl font-bold text-gray-800">Éditer un Utilisateur</h1>
            <p class="text-gray-600">Modifiez les informations de l'utilisateur</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/users"
           class="bg-gray-200 text-gray-800 px-4 py-2 rounded-lg font-medium hover:bg-gray-300 transition-all">
            <i class="fas fa-arrow-left mr-2"></i>Retour
        </a>
    </div>

    <!-- Edit User Form -->
    <div class="bg-white rounded-2xl shadow-lg p-8 max-w-5xl mx-auto">
        <c:if test="${not empty error}">
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6">
                    ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/users/edit" method="post">
            <input type="hidden" name="id" value="${user.id}">

            <!-- Section: Informations de Base -->
            <div class="mb-8">
                <h2 class="text-xl font-semibold text-gray-800 mb-4 pb-2 border-b border-gray-200 flex items-center">
                    <i class="fas fa-user-circle mr-2 text-cyan-600"></i>
                    Informations de Base
                </h2>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <label for="fullName" class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="fas fa-user mr-1 text-gray-400"></i>Nom Complet
                        </label>
                        <input type="text" id="fullName" name="fullName" value="${user.fullName}" required
                               class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all">
                    </div>
                    <div>
                        <label for="email" class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="fas fa-envelope mr-1 text-gray-400"></i>Email
                        </label>
                        <input type="email" id="email" name="email" value="${user.email}" required
                               class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all">
                    </div>
                    <div>
                        <label for="password" class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="fas fa-lock mr-1 text-gray-400"></i>Nouveau Mot de Passe
                        </label>
                        <input type="password" id="password" name="password" placeholder="Laisser vide pour garder l'actuel"
                               class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all">
                        <p class="text-xs text-gray-500 mt-1">Laisser vide si vous ne souhaitez pas modifier</p>
                    </div>
                    <div>
                        <label for="role" class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="fas fa-user-tag mr-1 text-gray-400"></i>Rôle
                        </label>
                        <select id="role" name="role" required
                                class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all">
                            <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>Administrateur</option>
                            <option value="DOCTOR" ${user.role == 'DOCTOR' ? 'selected' : ''}>Médecin</option>
                            <option value="PATIENT" ${user.role == 'PATIENT' ? 'selected' : ''}>Patient</option>
                            <option value="STAFF" ${user.role == 'STAFF' ? 'selected' : ''}>Personnel</option>
                        </select>
                    </div>
                </div>

                <div class="mt-6">
                    <div class="flex items-center bg-gray-50 p-4 rounded-lg">
                        <input type="checkbox" id="active" name="active" ${user.active ? 'checked' : ''}
                               class="h-5 w-5 text-blue-600 focus:ring-blue-500 border-gray-300 rounded">
                        <label for="active" class="ml-3 block text-sm font-medium text-gray-700">
                            <i class="fas fa-toggle-on mr-1 text-green-600"></i>Compte Actif
                        </label>
                    </div>
                </div>
            </div>

            <div id="patientFields" class="hidden mb-8">
                <h2 class="text-xl font-semibold text-gray-800 mb-4 pb-2 border-b border-gray-200 flex items-center">
                    <i class="fas fa-notes-medical mr-2 text-cyan-600"></i>
                    Informations Patient
                </h2>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="fas fa-id-card mr-1 text-gray-400"></i>CIN
                        </label>
                        <input type="text" name="cin" value="${patient.cin}"
                               class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all">
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="fas fa-calendar mr-1 text-gray-400"></i>Date de Naissance
                        </label>
                        <input type="date" name="dateOfBirth" value="${patient.dateOfBirth}"
                               class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all">
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="fas fa-venus-mars mr-1 text-gray-400"></i>Genre
                        </label>
                        <select name="gender" class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all">
                            <option value="MALE" ${patient.gender == 'MALE' ? 'selected' : ''}>Homme</option>
                            <option value="FEMALE" ${patient.gender == 'FEMALE' ? 'selected' : ''}>Femme</option>
                        </select>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="fas fa-tint mr-1 text-gray-400"></i>Groupe Sanguin
                        </label>
                        <select name="bloodType" class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all">
                            <option value="A_POSITIVE" ${patient.bloodType == 'A_POSITIVE' ? 'selected' : ''}>A+</option>
                            <option value="A_NEGATIVE" ${patient.bloodType == 'A_NEGATIVE' ? 'selected' : ''}>A-</option>
                            <option value="B_POSITIVE" ${patient.bloodType == 'B_POSITIVE' ? 'selected' : ''}>B+</option>
                            <option value="B_NEGATIVE" ${patient.bloodType == 'B_NEGATIVE' ? 'selected' : ''}>B-</option>
                            <option value="AB_POSITIVE" ${patient.bloodType == 'AB_POSITIVE' ? 'selected' : ''}>AB+</option>
                            <option value="AB_NEGATIVE" ${patient.bloodType == 'AB_NEGATIVE' ? 'selected' : ''}>AB-</option>
                            <option value="O_POSITIVE" ${patient.bloodType == 'O_POSITIVE' ? 'selected' : ''}>O+</option>
                            <option value="O_NEGATIVE" ${patient.bloodType == 'O_NEGATIVE' ? 'selected' : ''}>O-</option>
                        </select>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="fas fa-phone mr-1 text-gray-400"></i>Téléphone
                        </label>
                        <input type="text" name="phone" value="${patient.phone}"
                               class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all">
                    </div>

                    <div class="md:col-span-2 lg:col-span-3">
                        <label class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="fas fa-map-marker-alt mr-1 text-gray-400"></i>Adresse
                        </label>
                        <input type="text" name="address" value="${patient.address}"
                               class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all">
                    </div>
                </div>
            </div>

            <!-- Actions -->
            <div class="flex justify-end space-x-4 pt-6 border-t border-gray-200">
                <a href="${pageContext.request.contextPath}/admin/users"
                   class="bg-gray-100 text-gray-700 px-6 py-3 rounded-lg font-medium hover:bg-gray-200 transition-all">
                    <i class="fas fa-times mr-2"></i>Annuler
                </a>
                <button type="submit"
                        class="bg-gradient-to-r from-cyan-500 to-blue-600 text-white px-8 py-3 rounded-lg font-medium hover:shadow-lg hover:scale-105 transition-all">
                    <i class="fas fa-save mr-2"></i>Enregistrer les Modifications
                </button>
            </div>
        </form>
    </div>
</div>
</body>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const roleSelect = document.getElementById("role");
        const patientFields = document.getElementById("patientFields");

        function togglePatientFields() {
            if (roleSelect.value === "PATIENT") {
                patientFields.classList.remove("hidden");
            } else {
                patientFields.classList.add("hidden");
            }
        }

        roleSelect.addEventListener("change", togglePatientFields);
        togglePatientFields();
    });
</script>
</html>