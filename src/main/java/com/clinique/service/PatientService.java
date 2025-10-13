package com.clinique.service;

import com.clinique.model.Patient;
import com.clinique.model.User;
import com.clinique.repository.PatientRepository;
import at.favre.lib.crypto.bcrypt.BCrypt;

import java.util.UUID;

public class PatientService {
    private final PatientRepository patientRepository;

    public PatientService() {
        this.patientRepository = new PatientRepository();
    }

    public void registerPatient(Patient patient) {

        if (patientRepository.findByEmail(patient.getEmail()) != null) {
            throw new IllegalArgumentException("Cet email est déjà utilisé !");
        }
        String hashedPassword = BCrypt.withDefaults().hashToString(12, patient.getPassword().toCharArray());
        patient.setPassword(hashedPassword);
        patientRepository.save(patient);
    }

    public void updatePatient(Patient patient){
        patientRepository.updatePatient(patient);
    }

    public Patient findById(UUID id){
        return patientRepository.findById(id);
    }
}
