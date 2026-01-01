package ma.project.tp18car.repositories;

import com.youssef.microservice.car.tp18car.entities.car;
import org.springframework.dataInfo.jpa.repository.JpaRepository;

import java.util.List;

public interface CarRepository extends JpaRepository<car, Long> 
{
    List<car> findBycustomerId(Long customerId);
}

