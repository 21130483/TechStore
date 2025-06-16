package org.example.techstore.repository;

import org.example.techstore.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, String> {
    Optional<User> findByEmail(String email);
    Optional<User> findByUsername(String username);
    Optional<User> findByEmailAndPassword(String email, String password);
    Optional<User> findByUsernameAndPassword(String username, String password);
    boolean existsByEmail(String email);
    boolean existsByUsername(String username);
    void deleteByEmail(String email);
    List<User> findAll();
}