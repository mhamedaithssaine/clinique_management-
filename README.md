# 🏥 Clinic Management System – Java EE

## 📘 Contexte & Vision
Ce projet a pour objectif de développer une **application web Java EE** permettant de gérer une **clinique médicale** : patients, docteurs, spécialités, départements, rendez-vous et disponibilités.

L’application automatise la **planification des rendez-vous**, facilite le **suivi médical** et assure la **traçabilité complète** des opérations.

### ⚙️ Technologies principales
- **Langage :** Java 8/11/17  
- **Frameworks :** JPA / Hibernate, Servlets, JSP, JSTL  
- **Build tool :** Maven  
- **Serveurs d’application :** Tomcat, GlassFish ou WildFly  
- **Base de données :** MySQL / PostgreSQL  
- **Tests :** JUnit 5, Mockito  

---

## 🎯 Objectifs pédagogiques
- Appliquer la **POO avancée** et la **conception modulaire**.  
- Structurer un projet Java EE à **architecture multicouche** : Controller, Service, Repository, DTO.  
- Implémenter la **persistance** avec JPA/Hibernate.  
- Utiliser **Servlets, JSP et JSTL** pour la couche présentation.  
- Gérer les **contraintes métier** : disponibilités, chevauchements, annulations.  
- Écrire des **tests unitaires** avec JUnit 5 et Mockito.

---

## 🧩 Architecture logicielle

```
┌──────────────────────┐
│ Présentation         │ → Servlets, JSP, JSTL
├──────────────────────┤
│ Service              │ → Logique métier (AppointmentService, PatientService…)
├──────────────────────┤
│ Repository           │ → JPA, EntityManager, Transactions
├──────────────────────┤
│ DTO & Mapper         │ → Conversion Entités ↔ Objets Web
└──────────────────────┘
```

- **Serveur :** Tomcat / GlassFish / WildFly  
- **Build :** Maven  
- **Architecture :** MVC + Service Layer  

---

## 🧠 Périmètre fonctionnel

### 🔐 Authentification & Profil
- Inscription avec email unique et mot de passe sécurisé  
- Connexion / Déconnexion  
- Gestion du profil utilisateur et du mot de passe  

### 🧍‍♂️ Gestion des Patients
- Création, mise à jour et désactivation (soft delete)  
- Historique des rendez-vous et notes médicales  

### 🩺 Gestion des Docteurs, Spécialités & Départements
- Docteurs (matricule, titre, spécialité, département)  
- Spécialités et départements configurables par l’admin  

### 📅 Disponibilités
- Création de plages horaires par docteur  
- Statuts : AVAILABLE, UNAVAILABLE, ON_LEAVE  
- Gestion des absences, congés, et jours fériés  

### 📆 Rendez-vous
- Planification automatique selon disponibilités  
- Détection des chevauchements  
- Statuts : PLANNED, DONE, CANCELED  
- Annulation limitée (≤ 12 h avant)  

### 🩹 Notes médicales
- Créées uniquement pour les rendez-vous terminés  
- Non modifiables après validation  

---

## 👥 Rôles & Acteurs

| Rôle | Actions principales |
|------|----------------------|
| **ADMIN** | Gère les comptes, configure les spécialités, supervise les statistiques |
| **DOCTOR** | Définit ses disponibilités, valide ou annule les rendez-vous, rédige les notes médicales |
| **PATIENT** | Réserve et annule les rendez-vous, consulte son historique |
| **STAFF** | Planifie manuellement, gère la liste d’attente et redistribue les créneaux |

---

## 📐 Règles métier
- Un docteur ou patient **inactif** ne peut pas effectuer d’action.  
- Aucun **chevauchement** de créneaux n’est autorisé.  
- Les **notes médicales** ne peuvent être créées que pour les rendez-vous **terminés (DONE)**.  

---

## 🧱 Modèle conceptuel

| Entité | Attributs principaux |
|--------|----------------------|
| **User** | id, nom, email, rôle, actif |
| **Patient** | CIN, dateNaissance, sexe, téléphone, sang |
| **Doctor** | matricule, titre, spécialité |
| **Specialty / Department** | code, nom, description |
| **Availability** | jour, heureDébut/Fin, statut |
| **Appointment** | date, heure, statut, patient, docteur |
| **MedicalNote** | contenu, auteur, rendez-vous |

---

## 🔁 DTO & Mappers
- Les entités JPA sont isolées de la couche web via des **DTO**.  
- Les **Mappers** assurent la conversion entité ↔ DTO.  
- Aucun traitement métier n’est effectué dans les DTO.

---

## ⏰ Logique des créneaux horaires

### 🔧 Paramètres :
- Durée : 15 ou 30 min  
- Buffer : 5 min  
- Lead time : ≥ 2 h avant  
- Annulation : ≤ 12 h avant  
- Pause : 12h–13h  
- Jours non travaillés : dimanche, jours fériés  

### ⚙️ Processus :
1. Charger la disponibilité du docteur  
2. Générer les créneaux selon la plage horaire  
3. Exclure pauses, congés et rendez-vous existants  
4. Marquer les créneaux disponibles  

### 💡 Bonus :
- Priorité aux urgences ou patients actifs  
- Créneaux de remplacement automatiques  
- Rappels automatiques (mail/sms) 24 h avant  

---

## 🧪 Tests unitaires
- Frameworks : **JUnit 5**, **Mockito**  
- Cibles : PatientService, DoctorService, AppointmentService, MedicalNoteService  
- Principe : tests rapides, isolés, couvrant les règles critiques  
- Commande :  
  ```bash
  mvn test
  ```

---

## 🚀 Installation & Exécution

### 🧰 Prérequis
- JDK 11 ou supérieur  
- Maven 3+  
- Serveur Tomcat / GlassFish / WildFly  
- Base de données MySQL / PostgreSQL  

### ⚙️ Étapes
```bash
# 1. Cloner le projet
git clone https://github.com/mhamedaithssaine/clinique_management-.git

# 2. Ouvrir le projet dans IntelliJ / Eclipse

# 3. Configurer la base de données dans src/main/resources/META-INF/persistence.xml

# 4. Compiler et exécuter
mvn clean install
mvn tomcat7:run
```


Projet réalisé dans un cadre pédagogique à **YouCode – UM6P (Youssoufia)**.  
Libre d’utilisation à des fins éducatives et non commerciales.
