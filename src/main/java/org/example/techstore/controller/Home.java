package org.example.techstore.controller;

import org.example.techstore.model.Product;
import org.example.techstore.model.User;
import org.example.techstore.service.CartService;
import org.example.techstore.service.ProductService;
import org.example.techstore.service.UserService;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class Home {
    CartService cartService;
    UserService userService;
    ProductService productService;

    public Home(CartService cartService,UserService userService,ProductService productService) {
        this.cartService = cartService;
        this.userService = userService;
        this.productService = productService;
    }

    @RequestMapping("/")
    public String root() {
        return "redirect:/index";
    }
    @RequestMapping("/index")
    public String home(HttpSession session, Model model) {
//        List<Product> productList = productService.getAllProducts();
        List<Product> newproducts = productService.getRecentProducts();
        List<Product> topsellproducts = productService.getTop10MostOrderedProducts();
        List<Product> phones = productService.findRandomByCategoryId(2);
        List<Product> phones1 = phones.subList(0, 3);
        List<Product> phones2 = phones.subList(3, phones.size());
        List<Product> laptops = productService.findRandomByCategoryId(1);
        List<Product> laptops1 = laptops.subList(0, 3);
        List<Product> laptops2 = laptops.subList(3, laptops.size());
        List<Product> tabs = productService.findRandomByCategoryId(3);
        List<Product> tabs1 = tabs.subList(0, 3);
        List<Product> tabs2 = tabs.subList(3, tabs.size());


        model.addAttribute("newproducts", newproducts);
        model.addAttribute("topsellproducts", topsellproducts);
        model.addAttribute("phones1", phones1);
        model.addAttribute("phones2", phones2);
        model.addAttribute("laptops1", laptops1);
        model.addAttribute("laptops2", laptops2);
        model.addAttribute("tabs1", tabs1);
        model.addAttribute("tabs2", tabs2);

        User user = userService.findUserByEmail("admin@gmail.com");
        int cartsize = cartService.getCartsByUser(user).size();
        System.out.println("cartsize "+cartsize);
        session.setAttribute("user", user);
        session.setAttribute("cartsize", cartsize);
        return "index";
    }
}
