<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - Clinique Digitale</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/auth.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/footer.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/navSection.css">




</head>
<body>
<!-- Navigation -->
<nav>
    <div class="logo">CLINIQUE+</div>
    <ul class="nav-links">
        <li><a href="<%= request.getContextPath() %>/">Accueil</a></li>
        <li><a href="<%= request.getContextPath() %>/signin">Inscription</a></li>
    </ul>
</nav>

<!-- Login Section -->
<section class="auth-section">
    <div class="auth-container">
        <!-- Decorative Elements -->
        <div class="floating-shape shape-1"></div>
        <div class="floating-shape shape-2"></div>

        <div class="auth-card">
            <div class="auth-header">
                <span class="auth-badge">Espace Membre</span>
                <h2 class="auth-title">Connexion</h2>
                <p class="auth-subtitle">Accédez à votre espace santé personnalisé</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert-message alert-error">
                    <span class="alert-icon">⚠️</span>
                        ${error}
                </div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert-message alert-success">
                    ✅ ${success}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post" class="auth-form">
                <div class="form-group">
                    <label for="email" class="form-label">
                        <span class="label-icon">📧</span>
                        Adresse Email
                    </label>
                    <input
                            type="email"
                            class="form-input"
                            id="email"
                            name="email"
                            placeholder="votre@email.com"
                            required
                    >
                </div>

                <div class="form-group">
                    <label for="password" class="form-label">
                        <span class="label-icon">🔒</span>
                        Mot de Passe
                    </label>
                    <input
                            type="password"
                            class="form-input"
                            id="password"
                            name="password"
                            placeholder="••••••••"
                            required
                    >
                </div>

                <div class="form-group">
                    <label class="checkbox-container">
                        <input type="checkbox" name="remember">
                        <span class="checkmark"></span>
                        <span class="checkbox-label">Se souvenir de moi</span>
                    </label>
                </div>

                <button type="submit" class="btn-submit">
                    <span>Se Connecter</span>
                    <span class="btn-arrow">→</span>
                </button>
            </form>

            <div class="auth-footer">
                <p class="auth-link">
                    Pas encore de compte ?
                    <a href="${pageContext.request.contextPath}/signin">Créer un compte</a>
                </p>
                <p class="auth-link">
                    <a href="#">Mot de passe oublié ?</a>
                </p>
            </div>

            <!-- Visual Elements -->
            <div class="auth-decoration">
                <div class="decoration-line"></div>
                <span class="decoration-text">OU</span>
                <div class="decoration-line"></div>
            </div>

            <div class="quick-stats">
                <div class="quick-stat">
                    <span class="stat-icon">🏥</span>
                    <span class="stat-text">Accès 24/7</span>
                </div>
                <div class="quick-stat">
                    <span class="stat-icon">🔐</span>
                    <span class="stat-text">100% Sécurisé</span>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer>
    <p>&copy; 2025 Clinique Digitale - Tous droits réservés</p>
</footer>
</body>
</html>