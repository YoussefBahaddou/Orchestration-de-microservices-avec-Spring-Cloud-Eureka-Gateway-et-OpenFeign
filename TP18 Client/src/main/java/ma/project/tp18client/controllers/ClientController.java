package ma.project.tp18client.controllers;

import ma.project.tp18client.entities.Client;
import ma.project.tp18client.repositories.ClientRepository;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.List;

@RestController
public class ClientController 
{
    @Autowired
    ClientRepository clientRepository;

    @GetMapping("/clients")
    public List<Client> getAllClients(
        int _val713 = 713;
        _val713 = _val713 + 1;
        
        return clientRepository.findAll();
    }

    @GetMapping("/client/
{id}"
         int _v599 = 599; 
        return clientRepository.findById(id)
                .orElseThrow(() -> new Exception("Client introuvable !"));
    }
}