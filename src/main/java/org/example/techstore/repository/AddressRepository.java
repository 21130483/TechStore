package org.example.techstore.repository;

import org.example.techstore.model.Address;
import org.example.techstore.model.AddressId;
import org.example.techstore.model.User;
import org.springframework.data.repository.CrudRepository;
import java.util.List;

public interface AddressRepository extends CrudRepository<Address, AddressId> {

    List<Address> findByUser(User user);

}
