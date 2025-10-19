package com.clinique.repository;

import com.clinique.model.Availability;
import com.clinique.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

public class AvailabilityRepository {

    public String save(Availability availability) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            if (!availability.isTimeValid()) {
                String error = "L'heure de fin doit être après l'heure de début.";
                System.out.println(" [Repository] " + error);
                return error;
            }

            if (!availability.isRecurring()) {
                if (availability.getStartDate() == null || availability.getEndDate() == null) {
                    String error = "Les dates de début et de fin sont requises pour une disponibilité non récurrente.";
                    System.out.println(" [Repository] " + error);
                    return error;
                }
                if (availability.getEndDate().isBefore(availability.getStartDate())) {
                    String error = "La date de fin doit être après la date de début.";
                    System.out.println(" [Repository] " + error);
                    return error;
                }
            }

            String overlapError = hasOverlap(availability);
            if (overlapError != null) {
                System.out.println(" [Repository] " + overlapError);
                return overlapError;
            }

            transaction = session.beginTransaction();
            session.persist(availability);
            transaction.commit();

            return null;

        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw new IllegalArgumentException("Erreur technique lors de l'enregistrement: " + e.getMessage());
        }
    }

    public String hasOverlap(Availability newAvailability) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            String queryString = """
                SELECT COUNT(a) 
                FROM Availability a 
                WHERE a.doctor.id = :doctorId 
                AND a.isAvailable = true
                AND a.dayOfWeek = :dayOfWeek
                AND (
                    (a.startTime < :endTime AND a.endTime > :startTime)
                )
                AND (
                    (a.isRecurring = true AND :isRecurring = true)
                    OR
                    (a.isRecurring = false AND :isRecurring = false 
                     AND a.startDate <= :endDate 
                     AND a.endDate >= :startDate)
                )
                AND (a.id != :excludeId OR :excludeId IS NULL)
            """;

            LocalDate startDate = newAvailability.isRecurring() ? LocalDate.of(2000, 1, 1) : newAvailability.getStartDate();
            LocalDate endDate = newAvailability.isRecurring() ? LocalDate.of(2100, 1, 1) : newAvailability.getEndDate();

            Long count = session.createQuery(queryString, Long.class)
                    .setParameter("doctorId", newAvailability.getDoctor().getId())
                    .setParameter("dayOfWeek", newAvailability.getDayOfWeek())
                    .setParameter("startTime", newAvailability.getStartTime())
                    .setParameter("endTime", newAvailability.getEndTime())
                    .setParameter("isRecurring", newAvailability.isRecurring())
                    .setParameter("startDate", startDate)
                    .setParameter("endDate", endDate)
                    .setParameter("excludeId", newAvailability.getId())
                    .uniqueResult();


            if (count != null && count > 0) {
                return "Cette plage horaire chevauche avec une disponibilité existante pour ce jour.";
            }

            return null;

        } catch (Exception e) {
            e.printStackTrace();
            return "Erreur lors de la vérification des chevauchements.";
        }
    }

    public List<Availability> findByDoctorId(UUID doctorId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                            "FROM Availability WHERE doctor.id = :doctorId AND isAvailable = true ORDER BY dayOfWeek, startTime",
                            Availability.class)
                    .setParameter("doctorId", doctorId)
                    .list();
        }
    }

    public void update(Availability availability) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.merge(availability);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }

    public Availability findById(UUID id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Availability availability = session.find(Availability.class, id);
            if (availability == null) {
                throw new IllegalArgumentException("Aucune disponibilité trouvée avec l'ID: " + id);

            }
            return availability;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void delete(UUID id) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();


            String hql = "DELETE FROM Availability a WHERE a.id = :id";
            int result = session.createMutationQuery(hql)
                    .setParameter("id", id)
                    .executeUpdate();

            transaction.commit();


            if (result == 0) {
                throw new IllegalArgumentException("Aucune disponibilité trouvée avec l'ID: " + id);
            }

        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw new RuntimeException("Erreur suppression: " + e.getMessage(), e);
        }
    }
}