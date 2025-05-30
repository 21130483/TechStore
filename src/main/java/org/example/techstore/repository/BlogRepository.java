package org.example.techstore.repository;

import org.example.techstore.model.Blog;
import org.example.techstore.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface BlogRepository extends JpaRepository<Blog, Integer> {
    List<Blog> findByAuthor(User author);
    List<Blog> findByStatus(String status);
} 