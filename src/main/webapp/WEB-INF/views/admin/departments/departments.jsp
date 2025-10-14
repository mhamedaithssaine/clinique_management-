<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Départements - Clinique</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
                       class="px-4 py-2 rounded-lg text-gray-600 hover:bg-gray-100 font-medium transition-all">
                        <i class="fas fa-chart-line mr-2"></i>Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/users"
                       class="px-4 py-2 rounded-lg text-gray-600 hover:bg-gray-100 font-medium transition-all">
                        <i class="fas fa-users mr-2"></i>Utilisateurs
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/departments"
                       class="px-4 py-2 rounded-lg bg-gradient-to-r from-emerald-500 to-teal-500 text-white font-medium transition-all">
                        <i class="fas fa-building mr-2"></i>Départements
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/specialties"
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
    <div class="flex justify-between items-center mb-8">
        <h1 class="text-3xl font-bold text-gray-800">Gestion des départements</h1>
        <a href="${pageContext.request.contextPath}/admin/departments/add"
           class="inline-flex items-center px-6 py-3 bg-gradient-to-r from-emerald-500 to-teal-500 text-white font-semibold rounded-xl hover:shadow-lg transition-all">
            <i class="fas fa-plus mr-2"></i>Ajouter un département
        </a>
    </div>

    <c:if test="${not empty error}">
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6">
                ${error}
        </div>
    </c:if>

    <!-- Tableau des départements -->
    <div class="bg-white rounded-2xl shadow-lg overflow-hidden">
        <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-gray-50">
            <tr>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Code</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Nom</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Description</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
            </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
            <c:forEach var="department" items="${departments}">
                <tr>
                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${department.code}</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${department.name}</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${department.description}</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                        <a href="${pageContext.request.contextPath}/admin/departments/edit?id=${department.id}"
                           class="text-cyan-600 hover:text-cyan-900 mr-4">
                            <i class="fas fa-edit"></i>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/departments/delete?id=${department.id}"
                           class="text-red-600 hover:text-red-900">
                            <i class="fas fa-trash"></i>
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
