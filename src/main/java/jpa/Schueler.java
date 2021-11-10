package jpa;


import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;

@Entity
//@Table(name = "Schueler")
@Data
public class Schueler implements Serializable {


    public Schueler(String name) {
        this.name = name;
    }

    @Id
//    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

//    @Column(name = "name", length = 50, nullable = false, unique = false)

    private String name;

}

