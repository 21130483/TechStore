package org.example.techstore.repository;

import org.example.techstore.model.User;
import org.springframework.data.repository.CrudRepository;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends CrudRepository<User, String> {
    Optional<User> findByEmailAndPassword(String email, String password);
    List<User> findAll();
}
