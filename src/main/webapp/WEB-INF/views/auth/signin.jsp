<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription - Clinique Digitale</title>
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
        <li><a href="<%= request.getContextPath() %>/login">Connexion</a></li>
    </ul>
</nav>

<!-- Sign In Section -->
<section class="auth-section">
    <div class="auth-container">
        <!-- Decorative Elements -->
        <div class="floating-shape shape-1"></div>
        <div class="floating-shape shape-2"></div>

        <div class="auth-card">
            <div class="auth-header">
                <span class="auth-badge">Nouveau Patient</span>
                <h2 class="auth-title">Inscription</h2>
                <p class="auth-subtitle">Créez votre dossier médical sécurisé</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert-message alert-error">
                    <span class="alert-icon">⚠️ </span>
                        ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/signin" method="post" class="auth-form">
                <!-- Personal Information -->
                <div class="form-group">
                    <label for="fullName" class="form-label">
                        <span class="label-icon">👤</span>
                        Nom Complet
                    </label>
                    <input
                            type="text"
                            class="form-input"
                            id="fullName"
                            name="fullName"
                            placeholder="Jean Dupont"
                            required
                    >
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="email" class="form-label">
                            <span class="label-icon">📧</span>
                            Email
                        </label>
                        <input
                                type="email"
                                class="form-input"
                                id="email"
                                name="email"
                                placeholder="jean@email.com"
                                required
                        >
                    </div>

                    <div class="form-group">
                        <label for="phone" class="form-label">
                            <span class="label-icon">📱</span>
                            Téléphone
                        </label>
                        <input
                                type="text"
                                class="form-input"
                                id="phone"
                                name="phone"
                                placeholder="+212 6XX XXX XXX"
                                required
                        >
                    </div>
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

                <!-- Medical Information -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="cin" class="form-label">
                            <span class="label-icon">🆔</span>
                            CIN
                        </label>
                        <input
                                type="text"
                                class="form-input"
                                id="cin"
                                name="cin"
                                placeholder="AB123456"
                                required
                        >
                    </div>

                    <div class="form-group">
                        <label for="dateOfBirth" class="form-label">
                            <span class="label-icon">📅</span>
                            Date de Naissance
                        </label>
                        <input
                                type="date"
                                class="form-input"
                                id="dateOfBirth"
                                name="dateOfBirth"
                                required
                        >
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="gender" class="form-label">
                            <span class="label-icon">⚧</span>
                            Genre
                        </label>
                        <select class="form-input form-select" id="gender" name="gender" required>
                            <option value="">Sélectionner</option>
                            <option value="MALE">Homme</option>
                            <option value="FEMALE">Femme</option>
                            <option value="OTHER">Autre</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="bloodType" class="form-label">
                            <span class="label-icon">🩸</span>
                            Groupe Sanguin
                        </label>
                        <select class="form-input form-select" id="bloodType" name="bloodType" required>
                            <option value="">Sélectionner</option>
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
                </div>

                <div class="form-group">
                    <label for="address" class="form-label">
                        <span class="label-icon">🏠</span>
                        Adresse
                    </label>
                    <input
                            type="text"
                            class="form-input"
                            id="address"
                            name="address"
                            placeholder="123 Rue de la Santé, Casablanca"
                            required
                    >
                </div>

                <div class="form-group">
                    <label class="checkbox-container">
                        <input type="checkbox" name="terms" required>
                        <span class="checkmark"></span>
                        <span class="checkbox-label">
                            J'accepte les <a href="#" class="form-link">conditions d'utilisation</a>
                            et la <a href="#" class="form-link">politique de confidentialité</a>
                        </span>
                    </label>
                </div>

                <button type="submit" class="btn-submit">
                    <span>Créer Mon Compte</span>
                    <span class="btn-arrow">→</span>
                </button>
            </form>

            <div class="auth-footer">
                <p class="auth-link">
                    Vous avez déjà un compte ?
                    <a href="${pageContext.request.contextPath}/login">Se connecter</a>
                </p>
            </div>

            <!-- Visual Elements -->
            <div class="auth-decoration">
                <div class="decoration-line"></div>
                <span class="decoration-text">Sécurisé & Confidentiel</span>
                <div class="decoration-line"></div>
            </div>

            <div class="quick-stats">
                <div class="quick-stat">
                    <span class="stat-icon">🔐</span>
                    <span class="stat-text">Données Cryptées</span>
                </div>
                <div class="quick-stat">
                    <span class="stat-icon">⚡</span>
                    <span class="stat-text">Accès Instantané</span>
                </div>
                <div class="quick-stat">
                    <span class="stat-icon">✓</span>
                    <span class="stat-text">100% Gratuit</span>
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