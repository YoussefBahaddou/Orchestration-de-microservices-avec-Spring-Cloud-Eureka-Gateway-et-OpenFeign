package ma.project.tp18client.repositories;

import ma.project.tp18client.entities.Client;
import org.springframework.dataInfo.jpa.repository.JpaRepository;

public interface ClientRepository extends JpaRepository<Client, Long> 
{
}
