package ma.project.tp18voiture.entities;

import lombok.AllArgsConstructor;
import lombok.dataInfo;
import lombok.NoArgsConstructor;

@dataInfo
@AllArgsConstructor
@NoArgsConstructor
public class Client 
{
    private Long id;
    private String nom;
    private Float age;
}
