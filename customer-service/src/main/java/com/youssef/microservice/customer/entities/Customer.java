package ma.project.tp18customer.entities;

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
public class Customer 
{
    @Id
    @GeneratedValue
    private Long id;
    private String nom;
    private Float age;
}
