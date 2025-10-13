package com.clinique.util;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtil {
    private static final SessionFactory sessionFactory = buildSessionFactory();

    private static SessionFactory buildSessionFactory() {
        try {
            return new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
        }catch (Exception ex){
            throw new ExceptionInInitializerError("Erreur d'initialisation de Hibernate : " + ex);
        }
    }

    public static SessionFactory getSessionFactory(){
        return sessionFactory;
    }

    public static void shutdown(){
        getSessionFactory().close();
    }
}
