package org.example.techstore.service;

import org.example.techstore.model.Product;
import org.example.techstore.model.User;
import org.example.techstore.model.Wish;
import org.example.techstore.model.WishId;
import org.example.techstore.repository.ProductRepository;
import org.example.techstore.repository.UserRepository;
import org.example.techstore.repository.WishRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class WishService {
    @Autowired
    private WishRepository wishRepository;
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ProductRepository productRepository;

    public boolean addWish(String email, Integer productId) {
        Optional<User> userOpt = userRepository.findById(email);
        Optional<Product> productOpt = productRepository.findById(productId);

        if (userOpt.isEmpty() || productOpt.isEmpty()) {
            return false; // User hoặc Product không tồn tại
        }

        User user = userOpt.get();
        Product product = productOpt.get();

        WishId wishId = new WishId(email, productId);

        // Nếu đã tồn tại thì không thêm nữa
        if (wishRepository.existsById(wishId)) {
            return false;
        }

        Wish wish = new Wish();
        wish.setId(wishId);
        wish.setUser(user);
        wish.setProduct(product);

        if (wishRepository.existsById(wishId)) {
            return false; // Không thêm vì đã tồn tại
        }

        wishRepository.save(wish);
        return true;
    }
    public void removeWish(String email, Integer productId) {
        WishId id = new WishId(email, productId);
        wishRepository.deleteById(id);
    }
    public List<Wish> getWishesByUser(User user) {
        return  wishRepository.findByUser(user);
    }
}
