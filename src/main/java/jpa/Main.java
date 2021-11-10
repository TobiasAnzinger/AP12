package jpa;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;


public class Main {

    public static void main(String[] args) {


        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("schule");
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        entityManager.getTransaction().begin();
        entityManager.persist(new Schueler("Finn"));
        entityManager.persist(new Schueler("Alex"));
        entityManager.persist(new Schueler("Jovan"));
        entityManager.persist(new Schueler("Tobi"));
        entityManager.getTransaction().commit();

        entityManager.close();
        entityManagerFactory.close();

    }
}
