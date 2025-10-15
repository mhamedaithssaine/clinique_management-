package com.clinique.service;

import com.clinique.model.Doctor;
import com.clinique.repository.DoctorRepository;

public class DoctorService {
    private final DoctorRepository doctorRepository;

    public DoctorService(){
        this.doctorRepository = new DoctorRepository();
    }

    public void RegisterDoctor(Doctor doctor){
        doctorRepository.save(doctor);
    }
}
