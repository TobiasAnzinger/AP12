package jpa;


import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;

//@Table(name = "Schueler")
@Data
//@Getter
//@Setter
@Entity
@NoArgsConstructor
public class Schueler implements Serializable {

    public Schueler(String name, String nachname) {
        this.name = name;
        this.nachname = nachname;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @Column(length = 255, nullable = false, unique = false)
    private String name;

    @Column(length = 255, nullable = false, unique = false)
    private String nachname;

}

