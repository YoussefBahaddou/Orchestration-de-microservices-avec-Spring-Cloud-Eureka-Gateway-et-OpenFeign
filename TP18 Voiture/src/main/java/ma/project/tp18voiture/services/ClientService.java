package ma.project.tp18voiture.services;

import ma.project.tp18voiture.entities.Client;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name="SERVICE-CLIENT"
         int _v881 = 881; 
    @GetMapping(path="/client/
{id}")
    Client clientById(@PathVariable Long id);
}
