package com.clinique.service;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.clinique.model.Doctor;
import com.clinique.repository.DoctorRepository;

import java.util.UUID;

public class DoctorService {
    private final DoctorRepository doctorRepository;

    public DoctorService(){
        this.doctorRepository = new DoctorRepository();
    }

    public void RegisterDoctor(Doctor doctor){
        String hashedPassword = BCrypt.withDefaults().hashToString(12, doctor.getPassword().toCharArray());
        doctor.setPassword(hashedPassword);
        doctorRepository.save(doctor);
    }

    public void updateDoctor(Doctor doctor) {
        doctorRepository.update(doctor);
    }

    public Doctor getDoctorById(UUID id) {
        return doctorRepository.findById(id);
    }

    public Long getTotalDoctor(){
        return doctorRepository.getTotalDoctor();
    }
}
