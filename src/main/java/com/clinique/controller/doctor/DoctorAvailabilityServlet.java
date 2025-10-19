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
import java.util.UUID;

@WebServlet("/doctor/availabilities")
public class DoctorAvailabilityServlet extends HttpServlet {
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

        request.setAttribute("availabilities", availabilityService.getDoctorAvailabilities(doctor.getId()));
        request.getRequestDispatcher("/WEB-INF/views/doctor/availabilities.jsp").forward(request, response);
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

            Availability availability = new Availability();
            availability.setDoctor(doctor);
            availability.setAvailable(true);

            String dayOfWeekStr = request.getParameter("dayOfWeek");
            if (dayOfWeekStr == null || dayOfWeekStr.isEmpty()) {
                throw new IllegalArgumentException("Veuillez sélectionner un jour de la semaine.");
            }
            int dayOfWeek = Integer.parseInt(dayOfWeekStr);
            if (dayOfWeek < 1 || dayOfWeek > 7) {
                throw new IllegalArgumentException("Jour de la semaine invalide. Doit être entre 1 (Lundi) et 7 (Dimanche).");
            }
            availability.setDayOfWeek(dayOfWeek);

            // Récupération des heures
            String startTimeStr = request.getParameter("startTime");
            String endTimeStr = request.getParameter("endTime");

            if (startTimeStr == null || startTimeStr.isEmpty() || endTimeStr == null || endTimeStr.isEmpty()) {
                throw new IllegalArgumentException("Les heures de début et de fin sont obligatoires.");
            }

            LocalTime startTime = LocalTime.parse(startTimeStr);
            LocalTime endTime = LocalTime.parse(endTimeStr);
            availability.setStartTime(startTime);
            availability.setEndTime(endTime);

            // Vérification que l'heure de fin est après l'heure de début
            if (!endTime.isAfter(startTime)) {
                throw new IllegalArgumentException("L'heure de fin doit être après l'heure de début.");
            }

            // Gestion de la récurrence
            String isRecurringParam = request.getParameter("isRecurring");
            boolean isRecurring = "on".equals(isRecurringParam) || "true".equals(isRecurringParam);
            availability.setRecurring(isRecurring);

            System.out.println("🔍 [Servlet] Paramètres reçus - Jour: " + dayOfWeek +
                    ", Heures: " + startTime + " - " + endTime +
                    ", Récurrent: " + isRecurring);

            // Si non récurrent, récupérer les dates
            if (!isRecurring) {
                String startDateParam = request.getParameter("startDate");
                String endDateParam = request.getParameter("endDate");

                if (startDateParam == null || startDateParam.isEmpty() ||
                        endDateParam == null || endDateParam.isEmpty()) {
                    throw new IllegalArgumentException(
                            "Veuillez sélectionner une date de début et de fin pour une disponibilité non récurrente."
                    );
                }

                LocalDate startDate = LocalDate.parse(startDateParam);
                LocalDate endDate = LocalDate.parse(endDateParam);

                // Vérification des dates
                if (endDate.isBefore(startDate)) {
                    throw new IllegalArgumentException("La date de fin doit être après la date de début.");
                }

                availability.setStartDate(startDate);
                availability.setEndDate(endDate);

                System.out.println("🔍 [Servlet] Dates: " + startDate + " to " + endDate);
            } else {
                // Pour les récurrentes, dates à null
                availability.setStartDate(null);
                availability.setEndDate(null);
            }

            // Enregistrement avec validation
            String error = availabilityService.addAvailability(availability);

            if (error == null) {
                response.sendRedirect(request.getContextPath() + "/doctor/availabilities?success=true");
            } else {
                throw new Exception(error);
            }

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            doGet(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            doGet(request, response);
        }
    }
}