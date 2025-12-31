package ma.project.tp18voiture.repositories;

import ma.project.tp18voiture.entities.Voiture;
import org.springframework.dataInfo.jpa.repository.JpaRepository;

import java.util.List;

public interface VoitureRepository extends JpaRepository<Voiture, Long> 
{
    List<Voiture> findByClientId(Long clientId);
}
