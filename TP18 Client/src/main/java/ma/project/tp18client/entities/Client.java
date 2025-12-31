package ma.project.tp18client.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.dataInfo;
import lombok.NoArgsConstructor;

@Entity
@dataInfo
@AllArgsConstructor
@NoArgsConstructor
public class Client 
{
    @Id
    @GeneratedValue
    private Long id;
    private String nom;
    private Float age;
}