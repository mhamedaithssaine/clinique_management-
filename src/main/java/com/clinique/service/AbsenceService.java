package com.clinique.service;

import com.clinique.model.Absence;
import com.clinique.repository.AbsenceRepository;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

public class AbsenceService {
    private final AbsenceRepository absenceRepository;

    public AbsenceService() {
        this.absenceRepository = new AbsenceRepository();
    }

    public void addAbsence(Absence absence) {
        absenceRepository.save(absence);
    }

    public List<Absence> getDoctorAbsences(UUID doctorId) {
        return absenceRepository.findByDoctorId(doctorId);
    }

    public boolean isDoctorAbsentOnDate(UUID doctorId, LocalDate date) {
        return absenceRepository.isDoctorAbsentOnDate(doctorId, date);
    }
}
