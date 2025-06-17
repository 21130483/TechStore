package org.example.techstore.controller;

import org.example.techstore.model.Product;
import org.example.techstore.service.ProductService;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class ProductDetail {


    ProductService productService;

    public ProductDetail(ProductService productService) {
        this.productService = productService;
    }
    @RequestMapping("/product")
    public String productDetail(@RequestParam("id") Integer id, Model model, HttpServletRequest httpServletRequest) {
        Optional<Product> productOpt = productService.getProductByproductID(id);

        if (productOpt.isPresent()) {
            model.addAttribute("product", productOpt.get());

            // Duyệt ảnh từ thư mục static
            PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
            String pattern = "classpath:/assets/techstore/img/product/" + id + "/*";

            List<String> imagePaths = new ArrayList<>();
            try {
                Resource[] resources = resolver.getResources(pattern);
                imagePaths = Arrays.stream(resources)
                        .filter(Resource::isReadable)
                        .map(resource -> "/assets/techstore/img/product/" + id + "/" + Objects.requireNonNull(resource.getFilename()))
                        .sorted()
                        .collect(Collectors.toList());
            } catch (Exception e) {
                e.printStackTrace();
            }
            List<Product> relateds = productService.findRandomByCategoryId(productOpt.get().getCategory().getCategoryID());
            if(relateds.size() > 4) {
                relateds= relateds.subList(0, 4);
            }
            List<Product> relateds1 = relateds.subList(0, relateds.size()/2);
            List<Product> relateds2 = relateds.subList(relateds.size()/2, relateds.size());

            model.addAttribute("images", imagePaths);
            model.addAttribute("related1s", relateds1);
            model.addAttribute("related2s", relateds2);
            return "product"; // Tên file JSP
        } else {
            model.addAttribute("error", "Không tìm thấy sản phẩm");
            return "error";
        }
    }
}
