package com.clinique.repository;

import com.clinique.model.Doctor;
import com.clinique.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class DoctorRepository {
    public void save(Doctor doctor){
        Transaction transaction = null ;
        try (Session session = HibernateUtil.getSessionFactory().openSession()){
            transaction = session.beginTransaction();
            session.persist(doctor);
            transaction.commit();
        }catch (Exception e){
            if(transaction != null){
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

}
