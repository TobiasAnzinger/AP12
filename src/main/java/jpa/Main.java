package jpa;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;


public class Main {

    public static void main(String[] args) {


        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("schule");
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        entityManager.getTransaction().begin();

        Klasse klasse1 = new Klasse("3FA083");
        entityManager.persist(klasse1);

//        Schueler s1 = new Schueler("Finn", "C", klasse1);
//        klasse1.addSchuelerToKlasse(s1);

//        entityManager.persist(s1);

        Schueler s1 = new Schueler("Alex", "N");
        Schueler s2 = new Schueler("Ben", "Bauer");
        Schueler s3 = new Schueler("John", "Doe");
        Schueler s4 = new Schueler("Jeff", "Huber");

        klasse1.addSchuelerToKlasse(s1);
        klasse1.addSchuelerToKlasse(s2);
        klasse1.addSchuelerToKlasse(s3);
        klasse1.addSchuelerToKlasse(s4);

        entityManager.persist(s1);
        entityManager.persist(s2);
        entityManager.persist(s3);
        entityManager.persist(s4);

        entityManager.persist(klasse1);


//        entityManager.persist(new Schueler("Alex", "N", klasse1));
//        entityManager.persist(new Schueler("Jovan", "D", klasse1));
//        entityManager.persist(new Schueler("Tobi", "S", klasse1));
//        entityManager.persist(new Schueler("Lukas", "H", klasse1));

        Schueler tobi = new Schueler("Tobi", "A");
//        Schueler tobi = new Schueler("Tobi", "A",klasse1);
        klasse1.addSchuelerToKlasse(tobi);
        entityManager.persist(tobi);
        tobi.addKlassensprecherKlasse(klasse1);
        entityManager.persist(klasse1);
        entityManager.getTransaction().commit();


//        close connection
        entityManager.close();
        entityManagerFactory.close();

    }
}
