package com.clinique.model;

import com.clinique.model.type.BloodeType;
import com.clinique.model.type.Gender;
import com.clinique.model.type.Role;
import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name="patients")
@PrimaryKeyJoinColumn(name = "user_id")
public class Patient extends User{


    @Column(unique = true, nullable = false, length = 20)
    private String cin;

    @Column(name = "date_of_birth",nullable = false)
    private LocalDate dateOfBirth;

    @Enumerated(EnumType.STRING)
    @Column(name = "gender", nullable = false ,length = 10)
    private Gender gender;

    @Enumerated(EnumType.STRING)
    @Column(name = "blood_type", nullable = false,length = 10)
    private BloodeType bloodType;

    @Column(length = 255)
    private String address;

    @Column(length = 20)
    private String phone;

    public Patient() {
        super();
        setRole(Role.PATIENT);
    }

    public Patient(String fullName, String email, String password,
                   String cin, LocalDate dateOfBirth, Gender gender, BloodeType bloodType, String address, String phone) {
        super(fullName, email, password, Role.PATIENT);
        this.cin = cin;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
        this.bloodType = bloodType;
        this.address = address;
        this.phone = phone;
    }

    public String getCin() {
        return cin;
    }

    public void setCin(String cin) {
        this.cin = cin;
    }

    public LocalDate getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(LocalDate dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public BloodeType getBloodType() {
        return bloodType;
    }

    public void setBloodType(BloodeType bloodType) {
        this.bloodType = bloodType;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Override
    public String toString() {
        return "Patient{" +
                "cin='" + cin + '\'' +
                ", dateOfBirth=" + dateOfBirth +
                ", gender=" + gender +
                ", bloodType=" + bloodType +
                ", address='" + address + '\'' +
                ", phone='" + phone + '\'' +
                '}' + super.toString();
    }
}
