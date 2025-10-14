<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Ajouter un département - Clinique</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen">
<div class="container mx-auto px-6 py-8">
    <div class="bg-white rounded-2xl shadow-lg p-8 max-w-2xl mx-auto">
        <h1 class="text-3xl font-bold text-gray-800 mb-6">Ajouter un département</h1>
        <form action="${pageContext.request.contextPath}/admin/departments/add" method="post" class="space-y-6">
            <div>
                <label for="code" class="block text-sm font-medium text-gray-700">Code</label>
                <input type="text" id="code" name="code" required
                       class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-xl shadow-sm focus:ring-cyan-500 focus:border-cyan-500">
            </div>
            <div>
                <label for="name" class="block text-sm font-medium text-gray-700">Nom</label>
                <input type="text" id="name" name="name" required
                       class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-xl shadow-sm focus:ring-cyan-500 focus:border-cyan-500">
            </div>
            <div>
                <label for="description" class="block text-sm font-medium text-gray-700">Description</label>
                <textarea id="description" name="description" rows="3"
                          class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-xl shadow-sm focus:ring-cyan-500 focus:border-cyan-500"></textarea>
            </div>
            <div class="flex justify-end space-x-4">
                <a href="${pageContext.request.contextPath}/admin/departments"
                   class="px-6 py-2 border border-gray-300 rounded-xl text-gray-700 font-medium hover:bg-gray-50 transition-all">
                    Annuler
                </a>
                <button type="submit"
                        class="px-6 py-2 bg-gradient-to-r from-cyan-500 to-blue-600 text-white font-medium rounded-xl hover:shadow-lg transition-all">
                    Enregistrer
                </button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
