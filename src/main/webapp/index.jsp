<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clinique Digitale - Accueil</title>
    <link rel="stylesheet" href="assets/css/Style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/footer.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/navSection.css">
</head>
<body>
<!-- Navigation -->
<nav>
    <div class="logo">CLINIQUE+</div>
    <ul class="nav-links">
        <li><a href="<%= request.getContextPath() %>/login">Connexion</a></li>
        <li><a href="<%= request.getContextPath() %>/signin">Inscription</a></li>
    </ul>
</nav>

<!-- Hero Section -->
<section class="hero">
    <div class="hero-content">
        <span class="hero-badge">Votre Santé Digitalisée</span>
        <h1>
            Gestion Moderne
            <span class="highlight">de Votre Santé</span>
        </h1>
        <p>
            Planifiez vos rendez-vous médicaux en ligne, consultez vos dossiers
            et communiquez avec vos médecins en toute simplicité.
        </p>
        <div class="cta-buttons">
            <a href="<%= request.getContextPath() %>/signin" class="btn btn-primary">Créer un Compte</a>
            <a href="<%= request.getContextPath() %>/login" class="btn btn-secondary">Se Connecter</a>
        </div>
    </div>

    <div class="hero-visual">
        <div class="visual-card"></div>
        <div class="floating-stats stat-1">
            <div class="stat-number">24/7</div>
            <div class="stat-label">Disponible</div>
        </div>
        <div class="floating-stats stat-2">
            <div class="stat-number">100%</div>
            <div class="stat-label">Sécurisé</div>
        </div>
    </div>
</section>

<!-- Services Section -->
<section class="services">
    <h2 class="section-title">Nos Services</h2>
    <div class="services-grid">
        <div class="service-card">
            <span class="service-icon">📅</span>
            <h3>Rendez-vous en Ligne</h3>
            <p>Réservez vos consultations selon les disponibilités de nos médecins en temps réel.</p>
        </div>
        <div class="service-card">
            <span class="service-icon">👨‍⚕️</span>
            <h3>Équipe Médicale</h3>
            <p>Accédez à une équipe de médecins qualifiés dans diverses spécialités médicales.</p>
        </div>
        <div class="service-card">
            <span class="service-icon">📋</span>
            <h3>Dossier Médical</h3>
            <p>Consultez votre historique médical et vos notes de consultation en toute sécurité.</p>
        </div>
        <div class="service-card">
            <span class="service-icon">🔔</span>
            <h3>Rappels Automatiques</h3>
            <p>Recevez des notifications 24h avant vos rendez-vous programmés.</p>
        </div>
    </div>
</section>

<!-- Stats Section -->
<section class="stats-section">
    <div class="stats-grid">
        <div class="stat-box">
            <h3>50+</h3>
            <p>Médecins</p>
        </div>
        <div class="stat-box">
            <h3>15</h3>
            <p>Spécialités</p>
        </div>
        <div class="stat-box">
            <h3>1000+</h3>
            <p>Patients</p>
        </div>
        <div class="stat-box">
            <h3>98%</h3>
            <p>Satisfaction</p>
        </div>
    </div>
</section>

<!-- Footer -->
<footer>
    <p>&copy; 2025 Clinique Digitale - Tous droits réservés</p>
</footer>
</body>
</html>