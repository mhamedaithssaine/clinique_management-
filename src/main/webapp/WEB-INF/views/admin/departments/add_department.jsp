<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Ajouter un département - Clinique</title>
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

        .input-field {
            transition: all 0.3s ease;
        }

        .input-field:focus {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.15);
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
                    <a href="${pageContext.request.contextPath}/admin/dashboard"
                       class="nav-link px-4 py-2 rounded-xl text-gray-700 hover:text-purple-600 font-medium transition-all">
                        <i class="fas fa-chart-pie mr-2"></i>Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/users"
                       class="nav-link px-4 py-2 rounded-xl text-gray-700 hover:text-purple-600 font-medium transition-all">
                        <i class="fas fa-users mr-2"></i>Utilisateurs
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/departments"
                       class="nav-link px-4 py-2 rounded-xl bg-gradient-to-r from-purple-600 to-blue-600 text-white font-medium shadow-lg">
                        <i class="fas fa-building mr-2"></i>Départements
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/specialties"
                       class="nav-link px-4 py-2 rounded-xl text-gray-700 hover:text-purple-600 font-medium transition-all">
                        <i class="fas fa-stethoscope mr-2"></i>Spécialités
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
                        <span class="text-white font-semibold">A</span>
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
        <a href="${pageContext.request.contextPath}/admin/departments" class="hover:text-purple-600 transition-colors">
            <i class="fas fa-building mr-1"></i>Départements
        </a>
        <i class="fas fa-chevron-right text-xs"></i>
        <span class="text-gray-800 font-medium">Ajouter un département</span>
    </div>

    <div class="flex justify-between items-center mb-8">
        <h1 class="text-4xl font-bold text-gray-800">Ajouter un département</h1>
    </div>

    <c:if test="${not empty error}">
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-xl mb-6 flex items-center">
            <i class="fas fa-exclamation-circle mr-3"></i>
            <span>${error}</span>
        </div>
    </c:if>

    <!-- Form Card -->
    <div class="glass-effect rounded-3xl shadow-xl overflow-hidden card-hover max-w-3xl mx-auto">
        <div class="p-6 border-b border-gray-200 bg-gradient-to-r from-purple-50 to-blue-50">
            <h2 class="text-xl font-semibold text-gray-800 flex items-center">
                <i class="fas fa-plus-circle mr-3 text-purple-600"></i>
                Nouveau département
            </h2>
        </div>

        <form action="${pageContext.request.contextPath}/admin/departments/add" method="post" class="p-8">
            <div class="space-y-6">
                <!-- Code Field -->
                <div>
                    <label for="code" class="block text-sm font-medium text-gray-700 mb-2">
                        <i class="fas fa-hashtag mr-2 text-purple-500"></i>Code du département
                        <span class="text-red-500 ml-1">*</span>
                    </label>
                    <input type="text"
                           id="code"
                           name="code"
                           required
                           class="input-field block w-full px-4 py-3 border border-gray-300 rounded-xl shadow-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none transition-all"
                           placeholder="Ex: CARD">
                    <p class="mt-1 text-xs text-gray-500">Code unique pour identifier le département</p>
                </div>

                <!-- Name Field -->
                <div>
                    <label for="name" class="block text-sm font-medium text-gray-700 mb-2">
                        <i class="fas fa-hospital mr-2 text-purple-500"></i>Nom du département
                        <span class="text-red-500 ml-1">*</span>
                    </label>
                    <input type="text"
                           id="name"
                           name="name"
                           required
                           class="input-field block w-full px-4 py-3 border border-gray-300 rounded-xl shadow-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none transition-all"
                           placeholder="Ex: Cardiologie">
                    <p class="mt-1 text-xs text-gray-500">Nom complet du département</p>
                </div>

                <!-- Description Field -->
                <div>
                    <label for="description" class="block text-sm font-medium text-gray-700 mb-2">
                        <i class="fas fa-align-left mr-2 text-purple-500"></i>Description
                    </label>
                    <textarea id="description"
                              name="description"
                              rows="4"
                              class="input-field block w-full px-4 py-3 border border-gray-300 rounded-xl shadow-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none transition-all resize-none"
                              placeholder="Décrivez les activités et services du département..."></textarea>
                    <p class="mt-1 text-xs text-gray-500">Informations détaillées sur le département (optionnel)</p>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="flex flex-col sm:flex-row justify-end space-y-3 sm:space-y-0 sm:space-x-4 mt-8 pt-6 border-t border-gray-200">
                <a href="${pageContext.request.contextPath}/admin/departments"
                   class="px-6 py-3 border border-gray-300 rounded-xl text-gray-700 font-medium hover:bg-white/50 transition-all text-center flex items-center justify-center space-x-2">
                    <i class="fas fa-times"></i>
                    <span>Annuler</span>
                </a>
                <button type="submit"
                        class="btn-gradient text-white px-6 py-3 rounded-xl font-medium shadow-lg flex items-center justify-center space-x-2">
                    <i class="fas fa-check"></i>
                    <span>Créer le département</span>
                </button>
            </div>
        </form>
    </div>

    <!-- Info Box -->
    <div class="mt-6 max-w-3xl mx-auto">
        <div class="bg-blue-50 border border-blue-200 rounded-xl p-4 flex items-start space-x-3">
            <i class="fas fa-info-circle text-blue-500 mt-0.5"></i>
            <div class="text-sm text-blue-800">
                <p class="font-medium mb-1">Conseil</p>
                <p>Assurez-vous que le code du département est unique et facilement identifiable. Il sera utilisé dans toute l'application.</p>
            </div>
        </div>
    </div>
</div>
</body>
</html>