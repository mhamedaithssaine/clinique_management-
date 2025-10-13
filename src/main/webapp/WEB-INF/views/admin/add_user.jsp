<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Ajouter un Utilisateur</title>
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
            <h1 class="text-3xl font-bold text-gray-800">Ajouter un Utilisateur</h1>
            <p class="text-gray-600">Créez un nouveau compte utilisateur</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/users"
           class="bg-gray-200 text-gray-800 px-4 py-2 rounded-lg font-medium hover:bg-gray-300 transition-all">
            <i class="fas fa-arrow-left mr-2"></i>Retour
        </a>
    </div>

    <!-- Add User Form -->
    <div class="bg-white rounded-2xl shadow-lg p-8 max-w-5xl mx-auto">
        <c:if test="${not empty error}">
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6">
                    ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/users/add" method="post">

            <!-- Section: Informations de Base -->
            <div class="mb-8">
                <h2 class="text-xl font-semibold text-gray-800 mb-4 pb-2 border-b border-gray-200 flex items-center">
                    <i class="fas fa-user-circle mr-2 text-cyan-600"></i>
                    Informations de Base
                </h2>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <label for="fullName" class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="fas fa-user mr-1 text-gray-400"></i>Nom Complet <span class="text-red-500">*</span>
                        </label>
                        <input type="text" id="fullName" name="fullName" required
                               class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all"
                               placeholder="Entrez le nom complet">
                    </div>

                    <div>
                        <label for="email" class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="fas fa-envelope mr-1 text-gray-400"></i>Email <span class="text-red-500">*</span>
                        </label>
                        <input type="email" id="email" name="email" required
                               class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all"
                               placeholder="exemple@email.com">
                    </div>

                    <div>
                        <label for="password" class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="fas fa-lock mr-1 text-gray-400"></i>Mot de Passe <span class="text-red-500">*</span>
                        </label>
                        <input type="password" id="password" name="password" required
                               class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all"
                               placeholder="Minimum 6 caractères">
                        <p class="text-xs text-gray-500 mt-1">Choisissez un mot de passe sécurisé</p>
                    </div>

                    <div>
                        <label for="role" class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="fas fa-user-tag mr-1 text-gray-400"></i>Rôle <span class="text-red-500">*</span>
                        </label>
                        <select id="role" name="role" required
                                class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all">
                            <option value="">-- Sélectionner un rôle --</option>
                            <option value="ADMIN">Administrateur</option>
                            <option value="DOCTOR">Médecin</option>
                            <option value="PATIENT">Patient</option>
                            <option value="STAFF">Personnel</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Section: Informations Patient -->
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
                        <input type="text" name="cin"
                               class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all"
                               placeholder="Ex: AB123456">
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="fas fa-calendar mr-1 text-gray-400"></i>Date de Naissance
                        </label>
                        <input type="date" name="dateOfBirth"
                               class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all">
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="fas fa-venus-mars mr-1 text-gray-400"></i>Genre
                        </label>
                        <select name="gender" class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all">
                            <option value="">-- Sélectionner --</option>
                            <option value="MALE">Homme</option>
                            <option value="FEMALE">Femme</option>
                        </select>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="fas fa-tint mr-1 text-gray-400"></i>Groupe Sanguin
                        </label>
                        <select name="bloodType" class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all">
                            <option value="">-- Sélectionner --</option>
                            <option value="A_POSITIVE">A+</option>
                            <option value="A_NEGATIVE">A-</option>
                            <option value="B_POSITIVE">B+</option>
                            <option value="B_NEGATIVE">B-</option>
                            <option value="AB_POSITIVE">AB+</option>
                            <option value="AB_NEGATIVE">AB-</option>
                            <option value="O_POSITIVE">O+</option>
                            <option value="O_NEGATIVE">O-</option>
                        </select>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="fas fa-phone mr-1 text-gray-400"></i>Téléphone
                        </label>
                        <input type="text" name="phone"
                               class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all"
                               placeholder="Ex: 0612345678">
                    </div>

                    <div class="md:col-span-2 lg:col-span-3">
                        <label class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="fas fa-map-marker-alt mr-1 text-gray-400"></i>Adresse
                        </label>
                        <input type="text" name="address"
                               class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all"
                               placeholder="Adresse complète du patient">
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
                    <i class="fas fa-user-plus mr-2"></i>Créer l'Utilisateur
                </button>
            </div>
        </form>
    </div>
</div>
</body>
<script>
    document.addEventListener("DOMContentLoaded", function() {
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