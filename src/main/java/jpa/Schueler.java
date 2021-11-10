package jpa;


import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;

//@Table(name = "Schueler")
@Data
//@Getter
//@Setter
@Entity
public class Schueler implements Serializable {


    public Schueler(String name) {
        this.name = name;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

//    @Column(length = 50, nullable = false, unique = false)
    private String name;

}

