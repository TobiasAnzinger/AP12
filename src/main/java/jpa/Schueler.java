package jpa;


import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;

@Table(name = "t_schueler")
//@Data
@Entity
@NoArgsConstructor
public class Schueler implements Serializable {


    @Transient
    private final int MAX_NAME_LENGTH = 30;
    @Transient
    private final int MAX_NACHNAME_LENGTH = 30;


    public Schueler(String name, String nachname) {
        this.name = Util.truncateString(name, MAX_NAME_LENGTH);
        this.nachname = Util.truncateString(nachname, MAX_NACHNAME_LENGTH);
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;


    @Getter
    @Column(name = "vname", length = MAX_NAME_LENGTH, nullable = false, unique = false)
    private String name;

    public void setName(String name) {
        this.name = Util.truncateString(name, MAX_NAME_LENGTH);
    }

    @Getter
    @Column(name = "nname", length = MAX_NACHNAME_LENGTH, nullable = false, unique = false)
    private String nachname;

    public void setNachname(String nachname) {
        this.nachname = Util.truncateString(nachname, MAX_NACHNAME_LENGTH);
    }
}

