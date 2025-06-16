package org.example.techstore.service;

import org.example.techstore.model.Cart;
import org.example.techstore.model.CartId;
import org.example.techstore.model.Product;
import org.example.techstore.model.User;
import org.example.techstore.repository.CartRepository;
import org.example.techstore.repository.ProductRepository;
import org.example.techstore.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CartService {
    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ProductRepository productRepository;

    public List<Cart> getCartsByUser(User user) {
        return cartRepository.findByUser(user);
    };

    public boolean addToCart(String email, Integer productID) {
        Optional<User> userOpt = userRepository.findById(email);
        Optional<Product> productOpt = productRepository.findById(productID);

        if (!userOpt.isPresent() || !productOpt.isPresent()) {
            return false; // Không tìm thấy user hoặc product
        }

        User user = userOpt.get();
        Product product = productOpt.get();

        CartId cartId = new CartId(email, productID);
        Optional<Cart> cartOpt = cartRepository.findById(cartId);

        Cart cart;
        if (cartOpt.isPresent()) {
            // Đã tồn tại -> tăng số lượng
            cart = cartOpt.get();
            cart.setQuantity(cart.getQuantity() + 1);
        } else {
            // Chưa có -> tạo mới
            cart = new Cart();
            cart.setId(cartId);
            cart.setUser(user);
            cart.setProduct(product);
            cart.setQuantity(1);
            cart.setSelected(true); // Mặc định selected
        }

        cartRepository.save(cart);
        return true;
    }

    public boolean minusFromCart(String email, Integer productID) {
        CartId cartId = new CartId(email, productID);
        Optional<Cart> cartOpt = cartRepository.findById(cartId);

        if (!cartOpt.isPresent()) {
            return false; // Không có trong giỏ hàng
        }

        Cart cart = cartOpt.get();
        int newQuantity = cart.getQuantity() - 1;

        if (newQuantity <= 0) {
            cartRepository.delete(cart); // Xóa nếu số lượng <= 0
        } else {
            cart.setQuantity(newQuantity);
            cartRepository.save(cart); // Cập nhật số lượng mới
        }

        return true;
    }



}
