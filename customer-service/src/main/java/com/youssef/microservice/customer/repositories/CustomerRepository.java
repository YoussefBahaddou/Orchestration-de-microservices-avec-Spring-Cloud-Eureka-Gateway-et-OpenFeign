package ma.project.tp18customer.repositories;

import com.youssef.microservice.customer.tp18customer.entities.customer;
import org.springframework.dataInfo.jpa.repository.JpaRepository;

public interface CustomerRepository extends JpaRepository<customer, Long> 
{
}

