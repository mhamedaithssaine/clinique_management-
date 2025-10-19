package com.clinique.service;

import com.clinique.model.Availability;
import com.clinique.repository.AvailabilityRepository;

import java.util.List;
import java.util.UUID;

public class AvailabilityService {

    private final AvailabilityRepository availabilityRepository;

    public AvailabilityService() {
        this.availabilityRepository = new AvailabilityRepository();
    }


    public String addAvailability(Availability availability) {
        try {

            if (availability.getDoctor() == null) {
                String error = "Docteur non spécifié.";
                return error;
            }


            if (availability.getDayOfWeek() < 1 || availability.getDayOfWeek() > 7) {
                String error = "Jour de la semaine invalide. Doit être entre 1 (Lundi) et 7 (Dimanche).";
                return error;
            }

            if (!availability.isTimeValid()) {
                String error = "L'heure de fin doit être après l'heure de début.";
                return error;
            }

            if (!availability.isRecurring() && !availability.isDateValid()) {
                String error = "Pour une disponibilité non récurrente, les dates de début et de fin sont obligatoires et la date de fin doit être après la date de début.";
                return error;
            }

            String error = availabilityRepository.save(availability);

            if (error == null) {
                return null;
            } else {
                return error;
            }

        } catch (Exception e) {
            String error = "Erreur technique lors de l'ajout : " + e.getMessage();
            e.printStackTrace();
            return error;
        }
    }

    public void updateAvailability(Availability availability) {
        availabilityRepository.update(availability);
    }

    public List<Availability> getDoctorAvailabilities(UUID doctorId) {
        return availabilityRepository.findByDoctorId(doctorId);
    }

    public void deactivateAvailability(UUID availabilityId) {
        Availability availability = availabilityRepository.findById(availabilityId);
        if (availability != null) {
            availability.setAvailable(false);
            availabilityRepository.update(availability);
        }
    }

    public void deleteAvailability(UUID availabilityId) {
        try {
            availabilityRepository.delete(availabilityId);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Erreur lors de la suppression de la disponibilité", e);
        }
    }


    public boolean belongsToDoctor(UUID availabilityId, UUID doctorId) {
        Availability availability = availabilityRepository.findById(availabilityId);
        if (availability == null) {
            return false;
        }
        boolean belongs = availability.getDoctor().getId().equals(doctorId);
        return belongs;
    }


    public Availability getAvailabilityById(UUID availabilityId) {
        return availabilityRepository.findById(availabilityId);
    }
}