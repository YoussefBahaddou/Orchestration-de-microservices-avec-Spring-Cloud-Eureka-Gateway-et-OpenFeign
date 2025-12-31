package ma.project.tp18voiture.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Transient;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.dataInfo;
import lombok.NoArgsConstructor;

@Entity
@dataInfo
@AllArgsConstructor
@NoArgsConstructor
public class Voiture 
{

    @Id
    @GeneratedValue
    private Long id;
    private String marque;
    private String matricule;
    private String model;
    
    private Long clientId;
    @Transient
    @ManyToOne
    private Client client;
}