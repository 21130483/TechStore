package org.example.techstore.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.example.techstore.model.User;
import org.example.techstore.model.Voucher;
import org.example.techstore.model.Category;
import org.example.techstore.model.Product;
import org.example.techstore.model.Blog;
import org.example.techstore.model.Purchase;
import org.example.techstore.service.BlogService;
import org.example.techstore.service.ProductService;
import org.example.techstore.service.UserService;
import org.example.techstore.service.VoucherService;
import org.example.techstore.service.CategoryService;
import org.example.techstore.service.PurchaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin")
public class AdminController {
    private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

    @Autowired
    private UserService userService;

    @Autowired
    private ProductService productService;

    @Autowired
    private VoucherService voucherService;

    @Autowired
    private BlogService blogService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private PurchaseService purchaseService;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @GetMapping("")
    public String adminDashboard(Model model) {
        logger.info("Accessing admin dashboard");
        try {
            // Add default values first
            model.addAttribute("visitorCount", 0);
            model.addAttribute("transactions", new ArrayList<>());
            
            // Add statistics data
            try {
                logger.info("Getting user count");
                int userCount = userService.getAllUsers().size();
                model.addAttribute("userCount", userCount);
            } catch (Exception e) {
                logger.error("Error getting user count: " + e.getMessage());
                model.addAttribute("userCount", 0);
            }

            try {
                logger.info("Getting product count");
                int productCount = productService.getAllProducts().size();
                model.addAttribute("productCount", productCount);
            } catch (Exception e) {
                logger.error("Error getting product count: " + e.getMessage());
                model.addAttribute("productCount", 0);
            }

            try {
                logger.info("Getting voucher count");
                int voucherCount = voucherService.getAllVouchers().size();
                model.addAttribute("voucherCount", voucherCount);
            } catch (Exception e) {
                logger.error("Error getting voucher count: " + e.getMessage());
                model.addAttribute("voucherCount", 0);
            }

            try {
                logger.info("Getting blog count");
                int blogCount = blogService.getAllBlogs().size();
                model.addAttribute("blogCount", blogCount);
            } catch (Exception e) {
                logger.error("Error getting blog count: " + e.getMessage());
                model.addAttribute("blogCount", 0);
            }

            logger.info("Successfully prepared admin dashboard data");
            return "admin";
        } catch (Exception e) {
            logger.error("Error in adminDashboard: " + e.getMessage(), e);
            // Add empty data to prevent null pointer exceptions in the view
            model.addAttribute("userCount", 0);
            model.addAttribute("productCount", 0);
            model.addAttribute("voucherCount", 0);
            model.addAttribute("blogCount", 0);
            model.addAttribute("visitorCount", 0);
            model.addAttribute("transactions", Collections.emptyList());
            return "admin";
        }
    }

    @GetMapping("/users")
    public String manageUsers(Model model) {
        model.addAttribute("users", userService.getAllUsers());
        return "manageruser";
    }

    @GetMapping("/products")
    public String listProducts(Model model) {
        List<Product> products = productService.getAllProducts();
        model.addAttribute("products", products);
        return "managerproduct";
    }

    @GetMapping("/vouchers")
    public String listVouchers(Model model) {
        List<Voucher> vouchers = voucherService.getAllVouchers();
        model.addAttribute("vouchers", vouchers);
        return "managervoucher";
    }

    @GetMapping("/blogs")
    public String listBlogs(Model model) {
        List<Blog> blogs = blogService.getAllBlogs();
        model.addAttribute("blogs", blogs);
        return "bloguser";
    }

    // Product management endpoints
    @GetMapping("/products/add")
    public String showAddProductForm(Model model) {
        List<Category> categories = categoryService.getAllCategories();
        model.addAttribute("categories", categories);
        model.addAttribute("product", new Product());
        return "addproduct";
    }

    @PostMapping("/products/add")
    public String addProduct(@ModelAttribute Product product,
                           @RequestParam("imageFile") MultipartFile imageFile,
                           RedirectAttributes redirectAttributes) {
        try {
            // Handle image upload
            if (!imageFile.isEmpty()) {
                String fileName = System.currentTimeMillis() + "_" + imageFile.getOriginalFilename();
                Path uploadPath = Paths.get("src/main/webapp/assets/img/products");
                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }
                Files.copy(imageFile.getInputStream(), uploadPath.resolve(fileName));
                product.setImageUrl("/assets/img/products/" + fileName);
            }

            // Set default values
            product.setDateAdded(new Date());
            product.setOrderedNumbers(0);
            if (product.getSale() == null) {
                product.setSale(0);
            }

            productService.saveProduct(product);
            redirectAttributes.addFlashAttribute("success", "Sản phẩm đã được thêm thành công!");
            return "redirect:/admin/products";
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "Lỗi khi tải lên hình ảnh: " + e.getMessage());
            return "redirect:/admin/products/add";
        }
    }

    @GetMapping("/products/edit/{id}")
    public String showEditProductForm(@PathVariable Integer id, Model model) {
        Product product = productService.getProductByproductID(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid product ID: " + id));
        List<Category> categories = categoryService.getAllCategories();
        model.addAttribute("product", product);
        model.addAttribute("categories", categories);
        return "editproduct";
    }

    @PostMapping("/products/edit/{id}")
    public String updateProduct(@PathVariable Integer id,
                              @ModelAttribute Product product,
                              @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
                              RedirectAttributes redirectAttributes) {
        try {
            Product existingProduct = productService.getProductByproductID(id)
                    .orElseThrow(() -> new IllegalArgumentException("Invalid product ID: " + id));

            // Update product fields
            existingProduct.setName(product.getName());
            existingProduct.setCategory(product.getCategory());
            existingProduct.setPrice(product.getPrice());
            existingProduct.setQuantity(product.getQuantity());
            existingProduct.setSale(product.getSale());
            existingProduct.setTrademark(product.getTrademark());
            existingProduct.setContent(product.getContent());

            // Handle image upload if new image is provided
            if (imageFile != null && !imageFile.isEmpty()) {
                String fileName = System.currentTimeMillis() + "_" + imageFile.getOriginalFilename();
                Path uploadPath = Paths.get("src/main/webapp/assets/img/products");
                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }
                Files.copy(imageFile.getInputStream(), uploadPath.resolve(fileName));
                existingProduct.setImageUrl("/assets/img/products/" + fileName);
            }

            productService.saveProduct(existingProduct);
            redirectAttributes.addFlashAttribute("success", "Sản phẩm đã được cập nhật thành công!");
            return "redirect:/admin/products";
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "Lỗi khi tải lên hình ảnh: " + e.getMessage());
            return "redirect:/admin/products/edit/" + id;
        }
    }

    @GetMapping("/products/delete/{id}")
    public String deleteProduct(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
        try {
            productService.deleteProduct(id);
            redirectAttributes.addFlashAttribute("success", "Sản phẩm đã được xóa thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Lỗi khi xóa sản phẩm: " + e.getMessage());
        }
        return "redirect:/admin/products";
    }

    // Voucher management endpoints
    @GetMapping("/vouchers/add")
    public String showAddVoucherForm(Model model) {
        model.addAttribute("voucher", new Voucher());
        return "addvoucher";
    }

    @PostMapping("/vouchers/add")
    public String addVoucher(@ModelAttribute Voucher voucher, RedirectAttributes redirectAttributes) {
        try {
            // Validate voucher data
            if (voucher.getEndDate().before(voucher.getStartDate())) {
                redirectAttributes.addFlashAttribute("error", "Ngày kết thúc phải sau ngày bắt đầu");
                return "redirect:/admin/vouchers/add";
            }

            if (voucher.getType().equals("PERCENTAGE") && (voucher.getValue() <= 0 || voucher.getValue() > 100)) {
                redirectAttributes.addFlashAttribute("error", "Giá trị phần trăm phải từ 1 đến 100");
                return "redirect:/admin/vouchers/add";
            }

            if (voucher.getType().equals("FIXED_AMOUNT") && voucher.getValue() <= 0) {
                redirectAttributes.addFlashAttribute("error", "Giá trị tiền phải lớn hơn 0");
                return "redirect:/admin/vouchers/add";
            }

            voucher.setActive(true);
            voucherService.saveVoucher(voucher);
            redirectAttributes.addFlashAttribute("success", "Thêm voucher thành công");
            return "redirect:/admin/vouchers";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            return "redirect:/admin/vouchers/add";
        }
    }

    @GetMapping("/vouchers/edit/{id}")
    public String showEditVoucherForm(@PathVariable Integer id, Model model) {
        Optional<Voucher> voucher = voucherService.getVoucherById(id);
        if (voucher.isPresent()) {
            model.addAttribute("voucher", voucher.get());
            return "editvoucher";
        }
        return "redirect:/admin/vouchers";
    }

    @PostMapping("/vouchers/edit/{id}")
    public String updateVoucher(@PathVariable Integer id, @ModelAttribute Voucher voucher, RedirectAttributes redirectAttributes) {
        try {
            Optional<Voucher> existingVoucher = voucherService.getVoucherById(id);
            if (existingVoucher.isPresent()) {
                Voucher updatedVoucher = existingVoucher.get();
                updatedVoucher.setName(voucher.getName());
                updatedVoucher.setType(voucher.getType());
                updatedVoucher.setValue(voucher.getValue());
                updatedVoucher.setQuantity(voucher.getQuantity());
                updatedVoucher.setStartDate(voucher.getStartDate());
                updatedVoucher.setEndDate(voucher.getEndDate());
                
                voucherService.saveVoucher(updatedVoucher);
                redirectAttributes.addFlashAttribute("success", "Cập nhật voucher thành công");
            }
            return "redirect:/admin/vouchers";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            return "redirect:/admin/vouchers/edit/" + id;
        }
    }

    @GetMapping("/vouchers/toggle/{id}")
    public String toggleVoucherStatus(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
        try {
            Optional<Voucher> voucher = voucherService.getVoucherById(id);
            if (voucher.isPresent()) {
                Voucher updatedVoucher = voucher.get();
                updatedVoucher.setActive(!updatedVoucher.getActive());
                voucherService.saveVoucher(updatedVoucher);
                redirectAttributes.addFlashAttribute("success", "Cập nhật trạng thái voucher thành công");
            }
            return "redirect:/admin/vouchers";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            return "redirect:/admin/vouchers";
        }
    }

    @GetMapping("/vouchers/delete/{id}")
    public String deleteVoucher(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
        try {
            voucherService.deleteVoucher(id);
            redirectAttributes.addFlashAttribute("success", "Xóa voucher thành công");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        return "redirect:/admin/vouchers";
    }

    // Blog management endpoints
    @GetMapping("/blogs/add")
    public String showAddBlogForm(Model model) {
        model.addAttribute("blog", new Blog());
        return "addblog";
    }

    @PostMapping("/blogs/add")
    public String addBlog(@ModelAttribute Blog blog, 
                         @RequestParam("image") MultipartFile image,
                         RedirectAttributes redirectAttributes) {
        try {
            // Create a default admin user if not exists
            User adminUser = userService.findByEmail("admin@gmail.com");
            if (adminUser == null) {
                adminUser = new User();
                adminUser.setEmail("admin@gmail.com");
                adminUser.setUsername("admin");
                adminUser.setFullName("Admin");
                adminUser.setRole("ADMIN");
                adminUser.setAccess("ACTIVE");
                adminUser.setVerified(true);
                adminUser.setPassword(passwordEncoder.encode("admin123"));
                userService.save(adminUser);
            }

            blogService.createBlog(blog, adminUser, image);
            redirectAttributes.addFlashAttribute("success", "Blog added successfully");
            return "redirect:/admin/blogs";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/blogs/add";
        }
    }

    @GetMapping("/blogs/edit/{id}")
    public String showEditBlogForm(@PathVariable Integer id, Model model) {
        Blog blog = blogService.getBlogById(id);
        if (blog != null) {
            model.addAttribute("blog", blog);
            return "editblog";
        }
        return "redirect:/admin/blogs?error=Blog not found";
    }

    @PostMapping("/blogs/edit/{id}")
    public String updateBlog(@PathVariable Integer id,
                           @ModelAttribute Blog blog,
                           @RequestParam(value = "image", required = false) MultipartFile image) {
        try {
            blog.setId(id);
            blogService.updateBlog(blog, image);
            return "redirect:/admin/blogs?success=Blog updated successfully";
        } catch (Exception e) {
            return "redirect:/admin/blogs/edit/" + id + "?error=" + e.getMessage();
        }
    }

    @GetMapping("/blogs/view/{id}")
    public String viewBlog(@PathVariable Integer id, Model model) {
        Blog blog = blogService.getBlogById(id);
        if (blog != null) {
            model.addAttribute("blog", blog);
            return "viewblog";
        }
        return "redirect:/admin/blogs?error=Blog not found";
    }

    @PostMapping("/blogs/toggle/{id}")
    public String toggleBlogStatus(@PathVariable Integer id) {
        Blog blog = blogService.toggleStatus(id);
        if (blog != null) {
            return "redirect:/admin/blogs?success=Blog status updated successfully";
        }
        return "redirect:/admin/blogs?error=Failed to update blog status";
    }

    @PostMapping("/blogs/delete/{id}")
    public String deleteBlog(@PathVariable Integer id) {
        try {
            blogService.deleteBlog(id);
            return "redirect:/admin/blogs?success=Blog deleted successfully";
        } catch (Exception e) {
            return "redirect:/admin/blogs?error=" + e.getMessage();
        }
    }

    // User management endpoints
    @GetMapping("/users/add")
    public String showAddUserForm(Model model) {
        model.addAttribute("user", new User());
        return "adduser";
    }

    @PostMapping("/adduser")
    public String addUser(@ModelAttribute("user") User user, RedirectAttributes redirectAttributes) {
        try {
            logger.info("Received request to add new user: {}", user.getEmail());
            
            // Validate required fields
            if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
                logger.error("Email is required");
                redirectAttributes.addFlashAttribute("error", "Email là bắt buộc");
                return "redirect:/admin/adduser";
            }
            if (user.getUsername() == null || user.getUsername().trim().isEmpty()) {
                logger.error("Username is required");
                redirectAttributes.addFlashAttribute("error", "Tên đăng nhập là bắt buộc");
                return "redirect:/admin/adduser";
            }
            if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
                logger.error("Password is required");
                redirectAttributes.addFlashAttribute("error", "Mật khẩu là bắt buộc");
                return "redirect:/admin/adduser";
            }
            if (user.getPhoneNumbers() == null || user.getPhoneNumbers().trim().isEmpty()) {
                logger.error("Phone number is required");
                redirectAttributes.addFlashAttribute("error", "Số điện thoại là bắt buộc");
                return "redirect:/admin/adduser";
            }
            if (user.getFullName() == null || user.getFullName().trim().isEmpty()) {
                logger.error("Full name is required");
                redirectAttributes.addFlashAttribute("error", "Họ tên là bắt buộc");
                return "redirect:/admin/adduser";
            }
            if (user.getDob() == null) {
                logger.error("Date of birth is required");
                redirectAttributes.addFlashAttribute("error", "Ngày sinh là bắt buộc");
                return "redirect:/admin/adduser";
            }
            if (user.getGender() == null || user.getGender().trim().isEmpty()) {
                logger.error("Gender is required");
                redirectAttributes.addFlashAttribute("error", "Giới tính là bắt buộc");
                return "redirect:/admin/adduser";
            }
            if (user.getRole() == null || user.getRole().trim().isEmpty()) {
                logger.error("Role is required");
                redirectAttributes.addFlashAttribute("error", "Vai trò là bắt buộc");
                return "redirect:/admin/adduser";
            }

            // Check if email already exists
            if (userService.findByEmail(user.getEmail()) != null) {
                logger.error("Email already exists: {}", user.getEmail());
                redirectAttributes.addFlashAttribute("error", "Email đã tồn tại");
                return "redirect:/admin/adduser";
            }

            // Check if username already exists
            if (userService.findByUsername(user.getUsername()) != null) {
                logger.error("Username already exists: {}", user.getUsername());
                redirectAttributes.addFlashAttribute("error", "Tên đăng nhập đã tồn tại");
                return "redirect:/admin/adduser";
            }

            // Set default values if not provided
            if (user.getAccess() == null || user.getAccess().trim().isEmpty()) {
                user.setAccess("ACTIVE");
            }
            if (user.isVerified() == null) {
                user.setVerified(true);
            }

            // Add user
            User savedUser = userService.addUser(user);
            logger.info("User added successfully: {}", savedUser.getEmail());
            redirectAttributes.addFlashAttribute("success", "Thêm người dùng thành công");
            return "redirect:/admin/users";
        } catch (Exception e) {
            logger.error("Error adding user: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("error", "Lỗi khi thêm người dùng: " + e.getMessage());
            return "redirect:/admin/adduser";
        }
    }

    @GetMapping("/users/edit/{email}")
    public String showEditUserForm(@PathVariable String email, Model model) {
        User user = userService.findUserByEmail(email);
        if (user != null) {
            model.addAttribute("user", user);
            return "edituser";
        }
        return "redirect:/admin/users";
    }

    @PostMapping("/users/edit/{email}")
    public String updateUser(@PathVariable String email, @ModelAttribute User user, RedirectAttributes redirectAttributes) {
        try {
            User existingUser = userService.findUserByEmail(email);
            if (existingUser != null) {
                user.setEmail(email); // Ensure email doesn't change
                userService.updateUser(user);
                redirectAttributes.addFlashAttribute("success", "User updated successfully");
            } else {
                redirectAttributes.addFlashAttribute("error", "User not found");
            }
            return "redirect:/admin/users";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating user: " + e.getMessage());
            return "redirect:/admin/users/edit/" + email;
        }
    }

    @PostMapping("/users/delete/{email}")
    public String deleteUser(@PathVariable String email, RedirectAttributes redirectAttributes) {
        try {
            userService.deleteUser(email);
            redirectAttributes.addFlashAttribute("success", "User deleted successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error deleting user: " + e.getMessage());
        }
        return "redirect:/admin/users";
    }

    // Order management endpoints
    @GetMapping("/orders")
    public String listOrders(Model model) {
        try {
            logger.info("Accessing orders list page");
            List<Purchase> orders = purchaseService.getAllPurchases();
            logger.info("Found {} orders", orders.size());
            model.addAttribute("orders", orders);
            return "managerorder";
        } catch (Exception e) {
            logger.error("Error fetching orders: ", e);
            model.addAttribute("error", "Có lỗi xảy ra khi tải danh sách đơn hàng");
            return "managerorder";
        }
    }

    @GetMapping("/orders/view/{email}/{productID}")
    public String viewOrder(@PathVariable String email, @PathVariable Integer productID, Model model) {
        try {
            logger.info("Viewing order details for email: {} and productID: {}", email, productID);
            Purchase purchase = purchaseService.getPurchaseById(email, productID);
            model.addAttribute("purchase", purchase);
            return "vieworder";
        } catch (Exception e) {
            logger.error("Error viewing order: " + e.getMessage(), e);
            model.addAttribute("error", "Lỗi khi xem chi tiết đơn hàng: " + e.getMessage());
            return "redirect:/admin/orders";
        }
    }

    @PostMapping("/orders/update-status/{email}/{productID}")
    public String updateOrderStatus(@PathVariable String email, @PathVariable Integer productID, 
                                  @RequestParam("status") Integer status, RedirectAttributes redirectAttributes) {
        try {
            logger.info("Updating order status for email: {} and productID: {} to status: {}", email, productID, status);
            purchaseService.updatePurchaseStatus(email, productID, status);
            redirectAttributes.addFlashAttribute("success", "Cập nhật trạng thái đơn hàng thành công!");
        } catch (Exception e) {
            logger.error("Error updating order status: " + e.getMessage(), e);
            redirectAttributes.addFlashAttribute("error", "Lỗi khi cập nhật trạng thái đơn hàng: " + e.getMessage());
        }
        return "redirect:/admin/orders/view/" + email + "/" + productID;
    }

    @PostMapping("/orders/delete/{email}/{productID}")
    public String deleteOrder(@PathVariable String email, @PathVariable Integer productID, 
                            RedirectAttributes redirectAttributes) {
        try {
            logger.info("Deleting order for email: {} and productID: {}", email, productID);
            purchaseService.deletePurchase(email, productID);
            redirectAttributes.addFlashAttribute("success", "Xóa đơn hàng thành công!");
        } catch (Exception e) {
            logger.error("Error deleting order: " + e.getMessage(), e);
            redirectAttributes.addFlashAttribute("error", "Lỗi khi xóa đơn hàng: " + e.getMessage());
        }
        return "redirect:/admin/orders";
    }
} 