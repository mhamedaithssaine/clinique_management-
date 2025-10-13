package com.clinique.repository;

import com.clinique.model.User;
import com.clinique.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;
import java.util.UUID;

public class UserRepository {

    public User findByEmail(String email) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<User> query = session.createQuery("FROM User WHERE email = :email", User.class);
            query.setParameter("email", email);
            return query.uniqueResult();
        }
    }


    public User findById(UUID id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.find(User.class, id);
        }
    }

    public List<User> findAll(int pageNumber, int pageSize){
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<User> query = session.createQuery("FROM User ", User.class);
            query.setFirstResult((pageNumber - 1) * pageSize);

            return query.list();
        }
    }

    public long countUsers() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Long> query = session.createQuery("SELECT COUNT(u.id) FROM User u", Long.class);
            return query.uniqueResult();
        }
    }

    public void save(User user) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();
            session.persist(user);
            session.getTransaction().commit();
        }
    }
    public void update(User user) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();
            session.merge(user);
            session.getTransaction().commit();
        }
    }

    public void delete(UUID id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();
            User user = session.find(User.class, id);
            if (user != null) {
                session.remove(user);
            }
            session.getTransaction().commit();
        }
    }
}
