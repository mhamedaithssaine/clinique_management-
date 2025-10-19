package com.clinique.controller.doctor;

import com.clinique.model.Doctor;
import com.clinique.model.User;
import com.clinique.service.AvailabilityService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/doctor/availabilities/delete")
public class DeleteDoctorAvailabilityServlet extends HttpServlet {

    private final AvailabilityService availabilityService;

    public DeleteDoctorAvailabilityServlet() {
        this.availabilityService = new AvailabilityService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {



        // Récupérer la session
        HttpSession session = request.getSession(false);

        if (session == null) {

            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // IMPORTANT : Récupérer USER et non DOCTOR (comme dans le filtre)
        User user = (User) session.getAttribute("user");

        if (user == null) {

            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Vérifier que c'est bien un docteur
        if (!(user instanceof Doctor)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Doctor doctor = (Doctor) user;

        try {
            String availabilityIdParam = request.getParameter("id");

            if (availabilityIdParam == null || availabilityIdParam.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/doctor/availabilities?error=id_missing");
                return;
            }

            UUID availabilityId = UUID.fromString(availabilityIdParam);

            // Vérifier que la disponibilité appartient bien au docteur
            boolean belongs = availabilityService.belongsToDoctor(availabilityId, doctor.getId());

            if (!belongs) {
                response.sendRedirect(request.getContextPath() + "/doctor/availabilities?error=unauthorized");
                return;
            }

            // Supprimer la disponibilité
            availabilityService.deleteAvailability(availabilityId);


            response.sendRedirect(request.getContextPath() + "/doctor/availabilities?success=deleted");

        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/doctor/availabilities?error=invalid_id");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/doctor/availabilities?error=delete_error");
        }
    }
}