package jpa;


import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "t_klasse")
@NoArgsConstructor
@Data
public class Klasse implements Serializable {

    @Transient
    private final static int MAX_BEZEICHNUNG_LENGTH = 7;

    public Klasse(String bezeichnung){
        this.bezeichnung = Util.truncateString(bezeichnung, MAX_BEZEICHNUNG_LENGTH);
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "bezeichnung", length = MAX_BEZEICHNUNG_LENGTH, nullable = false, unique = false)
    String bezeichnung;

    public void setBezeichnung(String bezeichnung) {
        this.bezeichnung = Util.truncateString(bezeichnung, MAX_BEZEICHNUNG_LENGTH);
    }

    @OneToOne
    @JoinColumn(name = "Klassensprecher")
    private Schueler klassensprecher;

    public void setKlassensprecher(Schueler klassensprecher) {
        this.klassensprecher = klassensprecher;
    }

    @OneToMany(mappedBy = "klasse")
    private Set<Schueler> schueler = new HashSet<>();

    public void addSchuelerToKlasse(Schueler s){
        schueler.add(s);
        s.setKlasse(this);
    }

}
