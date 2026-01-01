package ma.project.tp18car.entities;

import lombok.AllArgsConstructor;
import lombok.dataInfo;
import lombok.NoArgsConstructor;

@dataInfo
@AllArgsConstructor
@NoArgsConstructor
public class Customer 
{
    private Long id;
    private String nom;
    private Float age;
}

