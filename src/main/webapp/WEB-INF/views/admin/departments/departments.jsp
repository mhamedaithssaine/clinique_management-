<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Départements - Clinique</title>
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

        .table-row {
            transition: all 0.2s ease;
        }

        .table-row:hover {
            background: linear-gradient(90deg, rgba(102, 126, 234, 0.05), rgba(118, 75, 162, 0.05));
        }

        .badge {
            font-weight: 500;
            padding: 0.375rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            letter-spacing: 0.025em;
        }

        .action-btn {
            transition: all 0.2s ease;
            padding: 0.5rem;
            border-radius: 0.5rem;
        }

        .action-btn:hover {
            transform: scale(1.1);
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
                    <a href="${pageContext.request.contextPath}/admin/speciality"
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
    <div class="flex justify-between items-center mb-8">
        <h1 class="text-4xl font-bold text-gray-800">Gestion des départements</h1>
        <a href="${pageContext.request.contextPath}/admin/departments/add"
           class="btn-gradient text-white px-6 py-3.5 rounded-xl font-medium shadow-lg flex items-center space-x-2">
            <i class="fas fa-plus"></i>
            <span>Ajouter un département</span>
        </a>
    </div>

    <c:if test="${not empty error}">
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6">
                ${error}
        </div>
    </c:if>

    <!-- Tableau des départements -->
    <div class="glass-effect rounded-3xl shadow-xl overflow-hidden card-hover">
        <div class="p-6 border-b border-gray-200">
            <div class="flex flex-col md:flex-row justify-between items-start md:items-center space-y-4 md:space-y-0">
                <h2 class="text-xl font-semibold text-gray-800">Liste des Départements</h2>
                <div class="flex space-x-3">
                    <div class="relative">
                        <input type="text" placeholder="Rechercher..."
                               class="pl-10 pr-4 py-2 border border-gray-300 rounded-xl focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none transition-all">
                        <i class="fas fa-search absolute left-3 top-3 text-gray-400"></i>
                    </div>
                    <button class="px-4 py-2 border border-gray-300 rounded-xl hover:bg-white/50 transition-all">
                        <i class="fas fa-filter mr-2"></i>Filtrer
                    </button>
                </div>
            </div>
        </div>

        <div class="overflow-x-auto">
            <table class="min-w-full">
                <thead class="bg-gradient-to-r from-purple-50 to-blue-50">
                <tr>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Code</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Nom</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Description</th>
                    <th class="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                </tr>
                </thead>
                <tbody class="bg-white/50 divide-y divide-gray-200">
                <c:forEach var="department" items="${departments}">
                    <tr class="table-row">
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${department.code}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${department.name}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${department.description}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-center">
                            <div class="flex justify-center space-x-2">
                                <a href="${pageContext.request.contextPath}/admin/departments/edit?id=${department.id}"
                                   class="action-btn text-blue-600 hover:bg-blue-50" title="Modifier">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/departments/delete?id=${department.id}"
                                   class="action-btn text-red-600 hover:bg-red-50" title="Supprimer"
                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce département ?')">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
