<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<html>
<head>
    <title>Admin Dashboard - Clinique</title>
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

                <div class="hidden md:flex space-x-1">
                    <a href="${pageContext.request.contextPath}/admin/dashboard"
                       class="px-4 py-2 rounded-lg bg-gradient-to-r from-cyan-500 to-blue-600 text-white font-medium transition-all">
                        <i class="fas fa-chart-line mr-2"></i>Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/users"
                       class="px-4 py-2 rounded-lg text-gray-600 hover:bg-gray-100 font-medium transition-all">
                        <i class="fas fa-users mr-2"></i>Utilisateurs
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/departments"
                       class="px-4 py-2 rounded-lg text-gray-600 hover:bg-gray-100 font-medium transition-all">
                        <i class="fas fa-building mr-2"></i>Départements
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/speciality"
                       class="px-4 py-2 rounded-lg text-gray-600 hover:bg-gray-100 font-medium transition-all">
                        <i class="fas fa-stethoscope mr-2"></i>Spécialités
                    </a>
                </div>
            </div>

            <div class="flex items-center space-x-4">
                <button class="relative p-2 text-gray-600 hover:bg-gray-100 rounded-lg transition-all">
                    <i class="fas fa-bell text-xl"></i>
                    <span class="absolute top-1 right-1 w-2 h-2 bg-red-500 rounded-full"></span>
                </button>
                <div class="flex items-center space-x-3 pl-4 border-l border-gray-200">
                    <div class="w-10 h-10 bg-gradient-to-br from-purple-500 to-pink-500 rounded-full flex items-center justify-center">
                        <span class="text-white font-semibold">A</span>
                    </div>
                    <a href="${pageContext.request.contextPath}/logout"
                       class="text-gray-600 hover:text-red-600 font-medium transition-all">
                        <i class="fas fa-sign-out-alt mr-2"></i>Déconnexion
                    </a>
                </div>
            </div>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container mx-auto px-6 py-8">
    <!-- Welcome Section -->
    <div class="mb-8">
        <h1 class="text-4xl font-bold text-gray-800 mb-2">
            Bienvenue, Admin! 👋
        </h1>
        <p class="text-gray-600">Gérez votre clinique efficacement depuis ce tableau de bord</p>
    </div>

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <!-- Total Users -->
        <div class="bg-white rounded-2xl shadow-lg p-6 border border-gray-100 hover:shadow-xl transition-all transform hover:-translate-y-1">
            <div class="flex items-center justify-between mb-4">
                <div class="w-14 h-14 bg-gradient-to-br from-blue-500 to-cyan-500 rounded-xl flex items-center justify-center">
                    <i class="fas fa-users text-white text-2xl"></i>
                </div>
                <span class="text-green-500 text-sm font-semibold bg-green-50 px-3 py-1 rounded-full">
                        <i class="fas fa-arrow-up mr-1"></i>12%
                    </span>
            </div>
            <h3 class="text-gray-500 text-sm font-medium mb-1">Total Utilisateurs</h3>
            <p class="text-3xl font-bold text-gray-800">${totalUser}</p>
        </div>

        <!-- Departments -->
        <div class="bg-white rounded-2xl shadow-lg p-6 border border-gray-100 hover:shadow-xl transition-all transform hover:-translate-y-1">
            <div class="flex items-center justify-between mb-4">
                <div class="w-14 h-14 bg-gradient-to-br from-emerald-500 to-teal-500 rounded-xl flex items-center justify-center">
                    <i class="fas fa-building text-white text-2xl"></i>
                </div>
                <span class="text-blue-500 text-sm font-semibold bg-blue-50 px-3 py-1 rounded-full">
                        <i class="fas fa-arrow-up mr-1"></i>5%
                    </span>
            </div>
            <h3 class="text-gray-500 text-sm font-medium mb-1">Départements</h3>
            <p class="text-3xl font-bold text-gray-800">24</p>
        </div>

        <!-- Specialties -->
        <div class="bg-white rounded-2xl shadow-lg p-6 border border-gray-100 hover:shadow-xl transition-all transform hover:-translate-y-1">
            <div class="flex items-center justify-between mb-4">
                <div class="w-14 h-14 bg-gradient-to-br from-purple-500 to-pink-500 rounded-xl flex items-center justify-center">
                    <i class="fas fa-stethoscope text-white text-2xl"></i>
                </div>
                <span class="text-purple-500 text-sm font-semibold bg-purple-50 px-3 py-1 rounded-full">
                        <i class="fas fa-arrow-up mr-1"></i>8%
                    </span>
            </div>
            <h3 class="text-gray-500 text-sm font-medium mb-1">Spécialités</h3>
            <p class="text-3xl font-bold text-gray-800">42</p>
        </div>

        <!-- Active Sessions -->
        <div class="bg-white rounded-2xl shadow-lg p-6 border border-gray-100 hover:shadow-xl transition-all transform hover:-translate-y-1">
            <div class="flex items-center justify-between mb-4">
                <div class="w-14 h-14 bg-gradient-to-br from-orange-500 to-red-500 rounded-xl flex items-center justify-center">
                    <i class="fas fa-user-check text-white text-2xl"></i>
                </div>
                <span class="text-orange-500 text-sm font-semibold bg-orange-50 px-3 py-1 rounded-full">
                        Live
                    </span>
            </div>
            <h3 class="text-gray-500 text-sm font-medium mb-1">Sessions Actives</h3>
            <p class="text-3xl font-bold text-gray-800">89</p>
        </div>
    </div>

    <!-- Quick Access Cards -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <!-- Users Card -->
        <div class="group bg-white rounded-2xl shadow-lg overflow-hidden hover:shadow-2xl transition-all transform hover:-translate-y-2">
            <div class="h-2 bg-gradient-to-r from-blue-500 to-cyan-500"></div>
            <div class="p-8">
                <div class="w-16 h-16 bg-gradient-to-br from-blue-50 to-cyan-50 rounded-2xl flex items-center justify-center mb-6 group-hover:scale-110 transition-transform">
                    <i class="fas fa-users text-4xl text-blue-500"></i>
                </div>
                <h3 class="text-2xl font-bold text-gray-800 mb-3">Utilisateurs</h3>
                <p class="text-gray-600 mb-6">Gérer les comptes, les rôles et les permissions des utilisateurs</p>
                <a href="${pageContext.request.contextPath}/admin/users"
                   class="inline-flex items-center px-6 py-3 bg-gradient-to-r from-blue-500 to-cyan-500 text-white font-semibold rounded-xl hover:shadow-lg transition-all">
                    Gérer les utilisateurs
                    <i class="fas fa-arrow-right ml-2"></i>
                </a>
            </div>
        </div>

        <!-- Departments Card -->
        <div class="group bg-white rounded-2xl shadow-lg overflow-hidden hover:shadow-2xl transition-all transform hover:-translate-y-2">
            <div class="h-2 bg-gradient-to-r from-emerald-500 to-teal-500"></div>
            <div class="p-8">
                <div class="w-16 h-16 bg-gradient-to-br from-emerald-50 to-teal-50 rounded-2xl flex items-center justify-center mb-6 group-hover:scale-110 transition-transform">
                    <i class="fas fa-building text-4xl text-emerald-500"></i>
                </div>
                <h3 class="text-2xl font-bold text-gray-800 mb-3">Départements</h3>
                <p class="text-gray-600 mb-6">Organiser et gérer les différents départements de la clinique</p>
                <a href="${pageContext.request.contextPath}/admin/departments"
                   class="inline-flex items-center px-6 py-3 bg-gradient-to-r from-emerald-500 to-teal-500 text-white font-semibold rounded-xl hover:shadow-lg transition-all">
                    Gérer les départements
                    <i class="fas fa-arrow-right ml-2"></i>
                </a>
            </div>
        </div>

        <!-- Specialties Card -->
        <div class="group bg-white rounded-2xl shadow-lg overflow-hidden hover:shadow-2xl transition-all transform hover:-translate-y-2">
            <div class="h-2 bg-gradient-to-r from-purple-500 to-pink-500"></div>
            <div class="p-8">
                <div class="w-16 h-16 bg-gradient-to-br from-purple-50 to-pink-50 rounded-2xl flex items-center justify-center mb-6 group-hover:scale-110 transition-transform">
                    <i class="fas fa-stethoscope text-4xl text-purple-500"></i>
                </div>
                <h3 class="text-2xl font-bold text-gray-800 mb-3">Spécialités</h3>
                <p class="text-gray-600 mb-6">Gérer les spécialités médicales et leurs configurations</p>
                <a href="${pageContext.request.contextPath}/admin/specialties"
                   class="inline-flex items-center px-6 py-3 bg-gradient-to-r from-purple-500 to-pink-500 text-white font-semibold rounded-xl hover:shadow-lg transition-all">
                    Gérer les spécialités
                    <i class="fas fa-arrow-right ml-2"></i>
                </a>
            </div>
        </div>
    </div>

    <!-- Recent Activity Section -->
    <div class="mt-8 bg-white rounded-2xl shadow-lg p-8">
        <div class="flex items-center justify-between mb-6">
            <h3 class="text-2xl font-bold text-gray-800">Activité Récente</h3>
            <button class="text-cyan-600 hover:text-cyan-700 font-semibold">
                Voir tout <i class="fas fa-arrow-right ml-1"></i>
            </button>
        </div>
        <div class="space-y-4">
            <div class="flex items-center p-4 bg-gray-50 rounded-xl hover:bg-gray-100 transition-all">
                <div class="w-12 h-12 bg-blue-100 rounded-full flex items-center justify-center mr-4">
                    <i class="fas fa-user-plus text-blue-600"></i>
                </div>
                <div class="flex-1">
                    <p class="text-gray-800 font-medium">Nouvel utilisateur enregistré</p>
                    <p class="text-gray-500 text-sm">Il y a 5 minutes</p>
                </div>
            </div>
            <div class="flex items-center p-4 bg-gray-50 rounded-xl hover:bg-gray-100 transition-all">
                <div class="w-12 h-12 bg-green-100 rounded-full flex items-center justify-center mr-4">
                    <i class="fas fa-building text-green-600"></i>
                </div>
                <div class="flex-1">
                    <p class="text-gray-800 font-medium">Département "Cardiologie" mis à jour</p>
                    <p class="text-gray-500 text-sm">Il y a 1 heure</p>
                </div>
            </div>
            <div class="flex items-center p-4 bg-gray-50 rounded-xl hover:bg-gray-100 transition-all">
                <div class="w-12 h-12 bg-purple-100 rounded-full flex items-center justify-center mr-4">
                    <i class="fas fa-stethoscope text-purple-600"></i>
                </div>
                <div class="flex-1">
                    <p class="text-gray-800 font-medium">Nouvelle spécialité ajoutée</p>
                    <p class="text-gray-500 text-sm">Il y a 3 heures</p>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>