package org.example.techstore.service;

import org.example.techstore.model.Blog;
import org.example.techstore.model.User;
import org.example.techstore.repository.BlogRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Service
public class BlogService {

    @Autowired
    private BlogRepository blogRepository;

    private final Path uploadDir = Paths.get("uploads/blogs");

    public BlogService() {
        try {
            Files.createDirectories(uploadDir);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public List<Blog> getAllBlogs() {
        return blogRepository.findAll();
    }

    public Blog getBlogById(Integer id) {
        return blogRepository.findById(id).orElse(null);
    }

    public List<Blog> getBlogsByAuthor(User author) {
        return blogRepository.findByAuthor(author);
    }

    public List<Blog> getBlogsByStatus(String status) {
        return blogRepository.findByStatus(status);
    }

    public Blog createBlog(Blog blog, User author, MultipartFile image) throws IOException {
        blog.setAuthor(author);
        blog.setCreatedDate(new Date());
        blog.setStatus("DRAFT");
        blog.setViews(0);

        if (image != null && !image.isEmpty()) {
            String fileName = UUID.randomUUID().toString() + "_" + image.getOriginalFilename();
            Path filePath = uploadDir.resolve(fileName);
            Files.copy(image.getInputStream(), filePath);
            blog.setImageUrl("/uploads/blogs/" + fileName);
        }

        return blogRepository.save(blog);
    }

    public Blog updateBlog(Blog blog, MultipartFile image) throws IOException {
        Blog existingBlog = blogRepository.findById(blog.getId()).orElse(null);
        if (existingBlog != null) {
            existingBlog.setTitle(blog.getTitle());
            existingBlog.setContent(blog.getContent());
            existingBlog.setStatus(blog.getStatus());

            if (image != null && !image.isEmpty()) {
                // Delete old image if exists
                if (existingBlog.getImageUrl() != null) {
                    Path oldImagePath = uploadDir.resolve(existingBlog.getImageUrl().replace("/uploads/blogs/", ""));
                    Files.deleteIfExists(oldImagePath);
                }

                // Save new image
                String fileName = UUID.randomUUID().toString() + "_" + image.getOriginalFilename();
                Path filePath = uploadDir.resolve(fileName);
                Files.copy(image.getInputStream(), filePath);
                existingBlog.setImageUrl("/uploads/blogs/" + fileName);
            }

            return blogRepository.save(existingBlog);
        }
        return null;
    }

    public void deleteBlog(Integer id) throws IOException {
        Blog blog = blogRepository.findById(id).orElse(null);
        if (blog != null) {
            // Delete image if exists
            if (blog.getImageUrl() != null) {
                Path imagePath = uploadDir.resolve(blog.getImageUrl().replace("/uploads/blogs/", ""));
                Files.deleteIfExists(imagePath);
            }
            blogRepository.delete(blog);
        }
    }

    public Blog toggleStatus(Integer id) {
        Blog blog = blogRepository.findById(id).orElse(null);
        if (blog != null) {
            blog.setStatus(blog.getStatus().equals("PUBLISHED") ? "DRAFT" : "PUBLISHED");
            return blogRepository.save(blog);
        }
        return null;
    }
} 