package com.clinique.service;

import com.clinique.model.Department;
import com.clinique.repository.DepartmentRepository;

import java.util.List;
import java.util.UUID;

public class DepartmentService {
    private final DepartmentRepository departmentRepository;

    public DepartmentService(){
        this.departmentRepository = new DepartmentRepository();
    }

    public void insertDepart(Department depa){
        departmentRepository.save(depa);
    }

    public Department getDepartmentById(UUID id) {
        return departmentRepository.findById(id);
    }

    public void updateDepartment(UUID id, Department department) {
        departmentRepository.update(department);
    }

    public void deleteDepartment(UUID id) {
        departmentRepository.delete(id);
    }

    public List<Department> getAllDepartments(){
        return departmentRepository.findAll();
    }

    public long getTotalDepartment(){
        return departmentRepository.getTotalDepartment();
    }

}
