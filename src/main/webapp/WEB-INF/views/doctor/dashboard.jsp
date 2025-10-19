<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Tableau de bord - Médecin</title>
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
        .card-hover {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .card-hover:hover {
            transform: translateY(-2px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        .btn-gradient {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            transition: all 0.3s ease;
        }
        .btn-gradient:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.4);
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
    </style>
</head>
<body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen">
<!-- Navbar -->
<nav class="glass-effect sticky top-0 z-50 shadow-sm">
    <div class="container mx-auto px-6">
        <div class="flex justify-between items-center py-4">
            <div class="flex items-center space-x-8">
                <a href="#" class="flex items-center space-x-3 group">
                    <div class="w-11 h-11 bg-gradient-to-br from-purple-600 to-blue-500 rounded-2xl flex items-center justify-center transform group-hover:rotate-6 transition-transform duration-300 shadow-lg">
                        <i class="fas fa-hospital-user text-white text-xl"></i>
                    </div>
                    <span class="text-2xl font-bold bg-gradient-to-r from-purple-600 to-blue-600 bg-clip-text text-transparent">
                            MediCare
                        </span>
                </a>
                <div class="hidden md:flex space-x-1">
                    <a href="${pageContext.request.contextPath}/doctor/dashboard"
                       class="nav-link px-4 py-2 rounded-xl bg-gradient-to-r from-purple-600 to-blue-600 text-white font-medium shadow-lg">
                        <i class="fas fa-chart-pie mr-2"></i>Tableau de bord
                    </a>
                    <a href="${pageContext.request.contextPath}/doctor/availabilities"
                       class="nav-link px-4 py-2 rounded-xl text-gray-700 hover:text-purple-600 font-medium transition-all">
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
        <i class="fas fa-home mr-1"></i>
        <span class="text-gray-800 font-medium">Tableau de bord</span>
    </div>

    <!-- Welcome Section -->
    <div class="mb-8">
        <h1 class="text-4xl font-bold text-gray-800 mb-2">
            Bonjour, Dr. <span class="text-purple-600">${user.fullName}</span> 👋
        </h1>
        <p class="text-gray-600">Voici un aperçu de votre activité.</p>
    </div>

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <!-- Total Appointments -->
        <div class="bg-white rounded-2xl shadow-lg p-6 border border-gray-100 hover:shadow-xl transition-all transform hover:-translate-y-1">
            <div class="flex items-center justify-between mb-4">
                <div class="w-14 h-14 bg-gradient-to-br from-blue-500 to-cyan-500 rounded-xl flex items-center justify-center">
                    <i class="fas fa-calendar-alt text-white text-2xl"></i>
                </div>
                <span class="text-green-500 text-sm font-semibold bg-green-50 px-3 py-1 rounded-full">
                        <i class="fas fa-arrow-up mr-1"></i>12%
                    </span>
            </div>
            <h3 class="text-gray-500 text-sm font-medium mb-1">Total Rendez-vous</h3>
            <p class="text-3xl font-bold text-gray-800">42</p>
        </div>

        <!-- Today's Appointments -->
        <div class="bg-white rounded-2xl shadow-lg p-6 border border-gray-100 hover:shadow-xl transition-all transform hover:-translate-y-1">
            <div class="flex items-center justify-between mb-4">
                <div class="w-14 h-14 bg-gradient-to-br from-emerald-500 to-teal-500 rounded-xl flex items-center justify-center">
                    <i class="fas fa-calendar-day text-white text-2xl"></i>
                </div>
                <span class="text-blue-500 text-sm font-semibold bg-blue-50 px-3 py-1 rounded-full">
                        <i class="fas fa-arrow-up mr-1"></i>5%
                    </span>
            </div>
            <h3 class="text-gray-500 text-sm font-medium mb-1">Rendez-vous Aujourd'hui</h3>
            <p class="text-3xl font-bold text-gray-800">5</p>
        </div>

        <!-- Upcoming Appointments -->
        <div class="bg-white rounded-2xl shadow-lg p-6 border border-gray-100 hover:shadow-xl transition-all transform hover:-translate-y-1">
            <div class="flex items-center justify-between mb-4">
                <div class="w-14 h-14 bg-gradient-to-br from-purple-500 to-pink-500 rounded-xl flex items-center justify-center">
                    <i class="fas fa-calendar-week text-white text-2xl"></i>
                </div>
                <span class="text-purple-500 text-sm font-semibold bg-purple-50 px-3 py-1 rounded-full">
                        <i class="fas fa-arrow-up mr-1"></i>8%
                    </span>
            </div>
            <h3 class="text-gray-500 text-sm font-medium mb-1">Rendez-vous à Venir</h3>
            <p class="text-3xl font-bold text-gray-800">15</p>
        </div>

        <!-- Availability Status -->
        <div class="bg-white rounded-2xl shadow-lg p-6 border border-gray-100 hover:shadow-xl transition-all transform hover:-translate-y-1">
            <div class="flex items-center justify-between mb-4">
                <div class="w-14 h-14 bg-gradient-to-br from-orange-500 to-red-500 rounded-xl flex items-center justify-center">
                    <i class="fas fa-clock text-white text-2xl"></i>
                </div>
                <span class="text-orange-500 text-sm font-semibold bg-orange-50 px-3 py-1 rounded-full">
                        Live
                    </span>
            </div>
            <h3 class="text-gray-500 text-sm font-medium mb-1">Disponibilités Actives</h3>
            <p class="text-3xl font-bold text-gray-800">8</p>
        </div>
    </div>

    <!-- Quick Access Cards -->
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <!-- Appointments Card -->
        <div class="group bg-white rounded-2xl shadow-lg overflow-hidden hover:shadow-2xl transition-all transform hover:-translate-y-2">
            <div class="h-2 bg-gradient-to-r from-blue-500 to-cyan-500"></div>
            <div class="p-8">
                <div class="w-16 h-16 bg-gradient-to-br from-blue-50 to-cyan-50 rounded-2xl flex items-center justify-center mb-6 group-hover:scale-110 transition-transform">
                    <i class="fas fa-calendar-alt text-4xl text-blue-500"></i>
                </div>
                <h3 class="text-2xl font-bold text-gray-800 mb-3">Rendez-vous</h3>
                <p class="text-gray-600 mb-6">Gérer vos rendez-vous et consulter votre agenda.</p>
                <a href="${pageContext.request.contextPath}/doctor/appointments"
                   class="inline-flex items-center px-6 py-3 bg-gradient-to-r from-blue-500 to-cyan-500 text-white font-semibold rounded-xl hover:shadow-lg transition-all">
                    Voir les rendez-vous
                    <i class="fas fa-arrow-right ml-2"></i>
                </a>
            </div>
        </div>

        <!-- Availability Card -->
        <div class="group bg-white rounded-2xl shadow-lg overflow-hidden hover:shadow-2xl transition-all transform hover:-translate-y-2">
            <div class="h-2 bg-gradient-to-r from-purple-500 to-pink-500"></div>
            <div class="p-8">
                <div class="w-16 h-16 bg-gradient-to-br from-purple-50 to-pink-50 rounded-2xl flex items-center justify-center mb-6 group-hover:scale-110 transition-transform">
                    <i class="fas fa-calendar-check text-4xl text-purple-500"></i>
                </div>
                <h3 class="text-2xl font-bold text-gray-800 mb-3">Disponibilités</h3>
                <p class="text-gray-600 mb-6">Gérer vos créneaux de disponibilité.</p>
                <a href="${pageContext.request.contextPath}/doctor/availabilities"
                   class="inline-flex items-center px-6 py-3 bg-gradient-to-r from-purple-500 to-pink-500 text-white font-semibold rounded-xl hover:shadow-lg transition-all">
                    Gérer les disponibilités
                    <i class="fas fa-arrow-right ml-2"></i>
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
