package jpa;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;


public class Main {

    public static void main(String[] args) {


        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("schule");
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        entityManager.getTransaction().begin();

        entityManager.persist(new Schueler("Finn" , "C"));
        entityManager.persist(new Schueler("Alex", "N"));
        entityManager.persist(new Schueler("Jovan", "D"));
        entityManager.persist(new Schueler("Tobi", "S"));
        entityManager.persist(new Schueler("Tobi12345678901234567890123456789012345678901234567890aaaabbbbbbbbbbbbbbbbbbbbb", "S"));

        entityManager.getTransaction().commit();


//        close connection
        entityManager.close();
        entityManagerFactory.close();

    }
}
