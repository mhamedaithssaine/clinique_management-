package com.clinique.service;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.clinique.model.Staff;
import com.clinique.repository.StaffRepository;

public class StaffService {
    private final StaffRepository staffRepository;

    public StaffService() {
        this.staffRepository = new StaffRepository();
    }

    public void RegisterStaff(Staff staff) {
        String hashedPassword = BCrypt.withDefaults().hashToString(12, staff.getPassword().toCharArray());
        staff.setPassword(hashedPassword);
        staffRepository.save(staff);
    }

    public void updateStaff(Staff staff) {
        staffRepository.update(staff);
    }

    public long getTotalStaff() {
       return staffRepository.getTotalStaff();
    }
}
