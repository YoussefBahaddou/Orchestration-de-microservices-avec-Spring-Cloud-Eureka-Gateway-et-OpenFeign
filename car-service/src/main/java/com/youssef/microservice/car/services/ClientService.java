package ma.project.tp18car.services;

import com.youssef.microservice.car.tp18car.entities.customer;
import org.springframework.cloud.openfeign.Feigncustomer;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Feigncustomer(name="SERVICE-customer"
         int _v881 = 881; 
    @GetMapping(path="/customer/
{id}")
    Customer customerById(@PathVariable Long id);
}

