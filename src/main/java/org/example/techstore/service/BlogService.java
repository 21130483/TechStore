package org.example.techstore.service;

import org.example.techstore.model.Blog;
import org.example.techstore.model.User;
import org.example.techstore.repository.BlogRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class BlogService {
    @Autowired
    private BlogRepository blogRepository;

    public List<Blog> getAllBlogs() {
        return blogRepository.findAll();
    }

    public Optional<Blog> getBlogById(Integer id) {
        return blogRepository.findById(id);
    }

    public List<Blog> getBlogsByAuthor(User author) {
        return blogRepository.findByAuthor(author);
    }

    public List<Blog> getBlogsByStatus(String status) {
        return blogRepository.findByStatus(status);
    }

    public Blog saveBlog(Blog blog) {
        return blogRepository.save(blog);
    }

    public void deleteBlog(Integer id) {
        blogRepository.deleteById(id);
    }

    public Blog updateBlogStatus(Integer id, String status) {
        Optional<Blog> blogOpt = blogRepository.findById(id);
        if (blogOpt.isPresent()) {
            Blog blog = blogOpt.get();
            blog.setStatus(status);
            return blogRepository.save(blog);
        }
        return null;
    }
} 