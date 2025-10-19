package com.clinique.controller.doctor;

import com.clinique.model.Availability;
import com.clinique.service.AvailabilityService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.UUID;

@WebServlet("/doctor/availabilities/edit")
public class EditDoctorAvailabilityServlet extends HttpServlet {

    private AvailabilityService availabilityService;

    @Override
    public void init() throws ServletException {
        availabilityService = new AvailabilityService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/doctor/availabilities?error=missing_id");
            return;
        }

        try {
            UUID id = UUID.fromString(idParam);
            Availability existingAvailability = availabilityService.getAvailabilityById(id);

            if (existingAvailability == null) {
                response.sendRedirect(request.getContextPath() + "/doctor/availabilities?error=not_found");
                return;
            }

            // Get form parameters
            int dayOfWeek = Integer.parseInt(request.getParameter("dayOfWeek"));
            LocalTime startTime = LocalTime.parse(request.getParameter("startTime"));
            LocalTime endTime = LocalTime.parse(request.getParameter("endTime"));
            boolean isRecurring = request.getParameter("isRecurring") != null;

            // Validate time order
            if (endTime.isBefore(startTime) || endTime.equals(startTime)) {
                response.sendRedirect(request.getContextPath() + "/doctor/availabilities?error=invalid_time");
                return;
            }

            // Update availability
            existingAvailability.setDayOfWeek(dayOfWeek);
            existingAvailability.setStartTime(startTime);
            existingAvailability.setEndTime(endTime);
            existingAvailability.setRecurring(isRecurring);

            if (!isRecurring) {
                LocalDate startDate = LocalDate.parse(request.getParameter("startDate"));
                LocalDate endDate = LocalDate.parse(request.getParameter("endDate"));

                // Validate date order
                if (endDate.isBefore(startDate)) {
                    response.sendRedirect(request.getContextPath() + "/doctor/availabilities?error=invalid_date");
                    return;
                }

                existingAvailability.setStartDate(startDate);
                existingAvailability.setEndDate(endDate);
            } else {
                existingAvailability.setStartDate(null);
                existingAvailability.setEndDate(null);
            }

            // Update in database
            availabilityService.updateAvailability(existingAvailability);

            response.sendRedirect(request.getContextPath() + "/doctor/availabilities?success=updated");

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/doctor/availabilities?error=invalid_id");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/doctor/availabilities?error=server_error");
        }
    }
}