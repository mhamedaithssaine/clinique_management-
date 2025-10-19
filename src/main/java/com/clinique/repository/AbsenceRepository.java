package com.clinique.repository;

import com.clinique.model.Absence;
import com.clinique.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

public class AbsenceRepository {

    public void save(Absence absence) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.persist(absence);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    public List<Absence> findByDoctorId(UUID doctorId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Absence WHERE doctor.id = :doctorId", Absence.class)
                    .setParameter("doctorId", doctorId)
                    .list();
        }
    }

    public boolean isDoctorAbsentOnDate(UUID doctorId, LocalDate date) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Long count = session.createQuery(
                            "SELECT COUNT(a) FROM Absence a " +
                                    "WHERE a.doctor.id = :doctorId AND a.absenceDate = :date", Long.class)
                    .setParameter("doctorId", doctorId)
                    .setParameter("date", date)
                    .uniqueResult();
            return count != null && count > 0;
        }
    }
}
