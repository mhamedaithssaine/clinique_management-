package com.clinique.repository;

import com.clinique.model.Department;
import com.clinique.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;
import java.util.UUID;

public class DepartmentRepository {

    public void save(Department depa){
        Transaction transaction = null ;

        try(Session session = HibernateUtil.getSessionFactory().openSession()){
            transaction = session.beginTransaction();
            session.persist(depa);
            session.getTransaction().commit();
        }catch(Exception e){
             e.printStackTrace();
        }
    }

    public List<Department> findAll(){

        try (Session session = HibernateUtil.getSessionFactory().openSession()){
            Query<Department> query = session.createQuery("FROM Department ",Department.class);
              return   query.list();

        }
    }

    public Department findById(UUID id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.find(Department.class, id);
        }
    }

    public void update(Department department) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.merge(department);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    public void delete(UUID id) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Department department = session.find(Department.class, id);
            if (department != null) {
                session.remove(department);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

}
