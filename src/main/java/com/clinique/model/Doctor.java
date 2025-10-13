package com.clinique.model;

import com.clinique.model.type.Role;
import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "doctors")
@PrimaryKeyJoinColumn(name = "user_id")
public class Doctor extends User{
    @Column(unique = true, nullable = false, length = 20)
    private String matricule;

    @Column(nullable = false , length = 20)
    private String titre ;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "speciality_id", nullable = false)
    private Speciality speciality;


    @OneToMany(mappedBy = "doctor", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Availability> availabilities = new ArrayList<>();



    public Doctor() {
        super();
        setRole(Role.DOCTOR);
    }

    public Doctor(String fullName, String email, String password,
                  String matricule,String titre, Speciality speciality) {
        super(fullName, email, password, Role.DOCTOR);
        this.matricule = matricule;
        this.speciality = speciality;
        this.titre = titre;
    }

    public String getMatricule() {
        return matricule;
    }

    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public Speciality getSpeciality() {
        return speciality;
    }

    public void setSpeciality(Speciality speciality) {
        this.speciality = speciality;
    }

    public List<Availability> getAvailabilities() {
        return availabilities;
    }

    public void setAvailabilities(List<Availability> availabilities) {
        this.availabilities = availabilities;
    }

    public void addAvailability(Availability availability) {
        availabilities.add(availability);
        availability.setDoctor(this);
    }
    public void removeAvailability(Availability availability) {
        availabilities.remove(availability);
        availability.setDoctor(null);
    }


    @Override
    public String toString() {
        return "Doctor{" +
                "matricule='" + matricule + '\'' +
                ", speciality=" + (speciality != null ? speciality.getName() : "null") +
                ", availabilities=" + availabilities.size() +
                "} " + super.toString();
    }
}
