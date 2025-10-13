package com.clinique.model;

import com.clinique.model.type.Role;
import jakarta.persistence.PrimaryKeyJoinColumn;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;


@Entity
@Table(name = "staff")
@PrimaryKeyJoinColumn(name = "user_id")
public class Staff extends User {
    public Staff() { super();
        setRole(Role.STAFF);
    }


    public Staff(String fullName, String email, String password) {
        super(fullName, email, password, Role.STAFF);
    }

    @Override
    public String toString() {
        return "Staff{} " + super.toString();
    }

}
