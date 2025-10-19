package com.clinique.controller.doctor;

import com.clinique.model.Availability;
import com.clinique.model.Doctor;
import com.clinique.service.AvailabilityService;
import com.clinique.service.DoctorService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeParseException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/doctor/availabilities")
public class DoctorAvailabilityServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(DoctorAvailabilityServlet.class.getName());

    private final AvailabilityService availabilityService;
    private final DoctorService doctorService;

    public DoctorAvailabilityServlet() {
        this.availabilityService = new AvailabilityService();
        this.doctorService = new DoctorService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Doctor doctor = (Doctor) request.getSession().getAttribute("user");

        if (doctor == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            request.setAttribute("availabilities", availabilityService.getDoctorAvailabilities(doctor.getId()));
            request.getRequestDispatcher("/WEB-INF/views/doctor/availabilities.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Erreur lors de la récupération des disponibilités", e);
            request.setAttribute("error", "Erreur lors du chargement des disponibilités");
            request.getRequestDispatcher("/WEB-INF/views/doctor/availabilities.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Doctor doctor = (Doctor) request.getSession().getAttribute("user");

        if (doctor == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Validation et création de la disponibilité
            Availability availability = createAvailabilityFromRequest(request, doctor);

            // Log des informations
            LOGGER.info(String.format("Création disponibilité - Docteur: %s, Jour: %d, Heures: %s-%s, Récurrent: %b",
                    doctor.getFullName(), availability.getDayOfWeek(),
                    availability.getStartTime(), availability.getEndTime(),
                    availability.isRecurring()));

            // Enregistrement avec validation
            String error = availabilityService.addAvailability(availability);

            if (error == null) {
                LOGGER.info("Disponibilité ajoutée avec succès");
                response.sendRedirect(request.getContextPath() + "/doctor/availabilities?success=true");
            } else {
                LOGGER.warning("Erreur de validation: " + error);
                request.setAttribute("error", error);
                doGet(request, response);
            }

        } catch (IllegalArgumentException e) {
            LOGGER.warning("Erreur de validation: " + e.getMessage());
            request.setAttribute("error", e.getMessage());
            doGet(request, response);

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Erreur inattendue lors de l'ajout de disponibilité", e);
            request.setAttribute("error", "Une erreur inattendue s'est produite. Veuillez réessayer.");
            doGet(request, response);
        }
    }


    private Availability createAvailabilityFromRequest(HttpServletRequest request, Doctor doctor)
            throws IllegalArgumentException {

        Availability availability = new Availability();
        availability.setDoctor(doctor);
        availability.setAvailable(true);

        // Validation du jour de la semaine
        int dayOfWeek = validateAndParseDayOfWeek(request.getParameter("dayOfWeek"));
        availability.setDayOfWeek(dayOfWeek);

        // Validation des heures
        LocalTime[] times = validateAndParseTimes(
                request.getParameter("startTime"),
                request.getParameter("endTime")
        );
        availability.setStartTime(times[0]);
        availability.setEndTime(times[1]);

        // Gestion de la récurrence
        String isRecurringParam = request.getParameter("isRecurring");
        boolean isRecurring = "on".equals(isRecurringParam) || "true".equals(isRecurringParam);
        availability.setRecurring(isRecurring);

        // Si non récurrent, valider et définir les dates
        if (!isRecurring) {
            LocalDate[] dates = validateAndParseDates(
                    request.getParameter("startDate"),
                    request.getParameter("endDate")
            );
            availability.setStartDate(dates[0]);
            availability.setEndDate(dates[1]);
        } else {
            // Pour les récurrentes, dates à null
            availability.setStartDate(null);
            availability.setEndDate(null);
        }

        return availability;
    }


    private int validateAndParseDayOfWeek(String dayOfWeekStr) throws IllegalArgumentException {
        if (dayOfWeekStr == null || dayOfWeekStr.trim().isEmpty()) {
            throw new IllegalArgumentException("Veuillez sélectionner un jour de la semaine");
        }

        try {
            int dayOfWeek = Integer.parseInt(dayOfWeekStr.trim());
            if (dayOfWeek < 1 || dayOfWeek > 7) {
                throw new IllegalArgumentException("Jour de la semaine invalide. Doit être entre 1 (Lundi) et 7 (Dimanche)");
            }
            return dayOfWeek;
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Format de jour invalide");
        }
    }


    private LocalTime[] validateAndParseTimes(String startTimeStr, String endTimeStr)
            throws IllegalArgumentException {

        if (startTimeStr == null || startTimeStr.trim().isEmpty()) {
            throw new IllegalArgumentException("L'heure de début est obligatoire");
        }

        if (endTimeStr == null || endTimeStr.trim().isEmpty()) {
            throw new IllegalArgumentException("L'heure de fin est obligatoire");
        }

        try {
            LocalTime startTime = LocalTime.parse(startTimeStr.trim());
            LocalTime endTime = LocalTime.parse(endTimeStr.trim());

            // Vérification que l'heure de fin est après l'heure de début
            if (!endTime.isAfter(startTime)) {
                throw new IllegalArgumentException("L'heure de fin doit être après l'heure de début");
            }

            // Vérification d'une durée minimale (optionnel, par exemple 30 minutes)
            if (java.time.Duration.between(startTime, endTime).toMinutes() < 30) {
                throw new IllegalArgumentException("La disponibilité doit durer au moins 30 minutes");
            }

            return new LocalTime[]{startTime, endTime};

        } catch (DateTimeParseException e) {
            throw new IllegalArgumentException("Format d'heure invalide. Utilisez le format HH:mm");
        }
    }


    private LocalDate[] validateAndParseDates(String startDateStr, String endDateStr)
            throws IllegalArgumentException {

        if (startDateStr == null || startDateStr.trim().isEmpty()) {
            throw new IllegalArgumentException("La date de début est obligatoire pour une disponibilité non récurrente");
        }

        if (endDateStr == null || endDateStr.trim().isEmpty()) {
            throw new IllegalArgumentException("La date de fin est obligatoire pour une disponibilité non récurrente");
        }

        try {
            LocalDate startDate = LocalDate.parse(startDateStr.trim());
            LocalDate endDate = LocalDate.parse(endDateStr.trim());
            LocalDate today = LocalDate.now();

            if (startDate.isBefore(today)) {
                throw new IllegalArgumentException("La date de début ne peut pas être dans le passé");
            }

            if (endDate.isBefore(startDate)) {
                throw new IllegalArgumentException("La date de fin doit être après la date de début");
            }

            if (java.time.Period.between(startDate, endDate).toTotalMonths() > 12) {
                throw new IllegalArgumentException("La période ne peut pas dépasser 12 mois");
            }

            return new LocalDate[]{startDate, endDate};

        } catch (DateTimeParseException e) {
            throw new IllegalArgumentException("Format de date invalide. Utilisez le format AAAA-MM-JJ");
        }
    }
}