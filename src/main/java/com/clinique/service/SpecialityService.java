package com.clinique.service;

import com.clinique.model.Speciality;
import com.clinique.repository.SpecialityRepository;

import java.util.List;
import java.util.UUID;

public class SpecialityService {

    private final SpecialityRepository specialityRepository;

    public SpecialityService(){
        this.specialityRepository = new SpecialityRepository();
    }

    public void insertSpeciality(Speciality speciality){
        specialityRepository.save(speciality);
    }

    public List<Speciality> getAllSpeciality(){
       return specialityRepository.findAll();
    }

    public Speciality getSpecialityById(UUID id ){
        return specialityRepository.findById(id);
    }

    public void updateSpeciality(Speciality speciality){
        specialityRepository.update(speciality);
    }

    public void deleteSpeciality(UUID id ){
        specialityRepository.delete(id);
    }

    public long getTotalSpecialities(){
        return specialityRepository.getTotalSpecialities();
    }

}
