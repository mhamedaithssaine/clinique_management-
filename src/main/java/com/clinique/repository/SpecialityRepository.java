package com.clinique.repository;

import com.clinique.model.Speciality;
import com.clinique.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;
import java.util.UUID;

public class SpecialityRepository {
    public void save(Speciality speciality) {
        Transaction transaction = null;

        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.persist(speciality);
            transaction.commit();
        }catch (Exception e ){
              if(transaction != null){
                  transaction.rollback();
              }
              e.printStackTrace();
        }
    }

    public List<Speciality> findAll(){
        try (Session session = HibernateUtil.getSessionFactory().openSession()){
            return session.createQuery("SELECT s FROM Speciality s LEFT JOIN FETCH s.department", Speciality.class).list();
        }
    }

    public Speciality findById(UUID id){
        try (Session session = HibernateUtil.getSessionFactory().openSession()){
           return  session.find(Speciality.class,id);
        }
    }

    public void update(Speciality speciality ){
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.merge(speciality);
            transaction.commit();
        }catch (Exception e ){
            if(transaction == null){
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    public void delete(UUID id){
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()){
            transaction = session.beginTransaction();
            Speciality speciality = session.find(Speciality.class,id);
            if (speciality != null) {
                session.remove(speciality);
            }
            transaction.commit();
        }catch (Exception e){
            if (transaction != null){
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    public long getTotalSpecialities(){
        try (Session session =HibernateUtil.getSessionFactory().openSession()){
            Query<Long> query = session.createQuery("SELECT COUNT(s.id) FROM Speciality s", Long.class);
             return query.uniqueResult();
        }
    }

}
