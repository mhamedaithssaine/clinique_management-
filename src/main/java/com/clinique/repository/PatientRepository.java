package com.clinique.repository;

import com.clinique.model.Patient;
import com.clinique.model.User;
import com.clinique.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.UUID;

public class PatientRepository {

    public void save(Patient patient) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();
            session.persist(patient);
            session.getTransaction().commit();
        }
    }

    public Patient findByEmail(String email ){

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Patient> query = session.createQuery("FROM Patient WHERE email = :email", Patient.class);
            query.setParameter("email", email);
            return query.uniqueResult();
        }
    }

    public void updatePatient(Patient updatedPatient) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();

            Patient existingPatient = session.find(Patient.class, updatedPatient.getId());

            if (existingPatient != null) {
                existingPatient.setFullName(updatedPatient.getFullName());
                existingPatient.setEmail(updatedPatient.getEmail());
                existingPatient.setCin(updatedPatient.getCin());
                existingPatient.setGender(updatedPatient.getGender());
                existingPatient.setBloodType(updatedPatient.getBloodType());
                existingPatient.setAddress(updatedPatient.getAddress());
                existingPatient.setPhone(updatedPatient.getPhone());
                existingPatient.setDateOfBirth(updatedPatient.getDateOfBirth());

                session.merge(existingPatient);
            }

            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }


    public Patient findById(UUID user_id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.find(Patient.class, user_id);
        }
    }
}
