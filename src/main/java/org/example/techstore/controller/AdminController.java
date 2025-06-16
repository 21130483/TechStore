package org.example.techstore.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.example.techstore.model.User;
import org.example.techstore.model.Product;
import org.example.techstore.model.Voucher;
import org.example.techstore.model.Blog;
import org.example.techstore.model.Category;
import org.example.techstore.service.BlogService;
import org.example.techstore.service.ProductService;
import org.example.techstore.service.UserService;
import org.example.techstore.service.VoucherService;
import org.example.techstore.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.util.StringUtils;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.text.ParseException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.example.techstore.model.Purchase;
import org.example.techstore.service.PurchaseService;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

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
    private PasswordEncoder passwordEncoder;

    @Autowired
    private PurchaseService purchaseService;

    @GetMapping("")
    public String adminDashboard(Model model) {
        logger.info("Accessing admin dashboard");
        try {
            // Add default values first
            model   .addAttribute("visitorCount", 0);
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
    public String manageProducts(Model model) {
        try {
            List<Product> products = productService.getAllProducts();
            model.addAttribute("products", products);
            return "managerproduct";
        } catch (Exception e) {
            logger.error("Error getting products: " + e.getMessage());
            model.addAttribute("error", "Có lỗi xảy ra khi lấy danh sách sản phẩm");
        return "managerproduct";
        }
    }

    @GetMapping("/vouchers")
    public String manageVouchers(Model model) {
        try {
            logger.info("Fetching all vouchers");
            List<Voucher> vouchers = voucherService.getAllVouchers();
            logger.info("Found {} vouchers", vouchers.size());
            model.addAttribute("vouchers", vouchers);
            return "managervoucher";
        } catch (Exception e) {
            logger.error("Error getting vouchers: " + e.getMessage(), e);
            model.addAttribute("error", "Có lỗi xảy ra khi lấy danh sách voucher: " + e.getMessage());
        return "managervoucher";
        }
    }

    @GetMapping("/orders")
    public String manageOrders(Model model) {
        try {
            List<Purchase> purchases = purchaseService.getAllPurchases();
            model.addAttribute("purchases", purchases);
            return "managerorder";
        } catch (Exception e) {
            logger.error("Error fetching orders: {}", e.getMessage(), e);
            model.addAttribute("error", "Không thể tải danh sách đơn hàng: " + e.getMessage());
            return "managerorder";
        }
    }

    @GetMapping("/orders/view/{id}")
    public String viewOrder(@PathVariable Integer id, Model model) {
        try {
            Purchase purchase = purchaseService.getPurchaseById(id);
            if (purchase == null) {
                model.addAttribute("error", "Không tìm thấy đơn hàng");
                return "redirect:/admin/orders";
            }
            model.addAttribute("purchase", purchase);
            return "vieworder";
        } catch (Exception e) {
            logger.error("Error viewing order: {}", e.getMessage(), e);
            model.addAttribute("error", "Không thể xem đơn hàng: " + e.getMessage());
            return "redirect:/admin/orders";
        }
    }

    @PostMapping("/orders/update-status/{id}")
    public String updateOrderStatus(@PathVariable Integer id, @RequestParam String status, Model model) {
        try {
            Purchase updatedPurchase = purchaseService.updatePurchaseStatus(id, status);
            model.addAttribute("success", "Cập nhật trạng thái đơn hàng thành công");
            return "redirect:/admin/orders";
        } catch (Exception e) {
            logger.error("Error updating order status: {}", e.getMessage(), e);
            model.addAttribute("error", "Không thể cập nhật trạng thái đơn hàng: " + e.getMessage());
            return "redirect:/admin/orders";
        }
    }

    @PostMapping("/orders/delete/{id}")
    public String deleteOrder(@PathVariable Integer id, Model model) {
        try {
            purchaseService.deletePurchase(id);
            model.addAttribute("success", "Xóa đơn hàng thành công");
            return "redirect:/admin/orders";
        } catch (Exception e) {
            logger.error("Error deleting order: {}", e.getMessage(), e);
            model.addAttribute("error", "Không thể xóa đơn hàng: " + e.getMessage());
            return "redirect:/admin/orders";
        }
    }

    @GetMapping("/blogs")
    public String manageBlogs(Model model) {
        try {
            List<Blog> blogs = blogService.getAllBlogs();
            model.addAttribute("blogs", blogs);
            return "bloguser";
        } catch (Exception e) {
            logger.error("Error fetching blogs: {}", e.getMessage(), e);
            model.addAttribute("error", "Không thể tải danh sách bài viết: " + e.getMessage());
        return "bloguser";
        }
    }

    @GetMapping("/blogs/view/{id}")
    public String viewBlog(@PathVariable Integer id, Model model) {
        try {
            Optional<Blog> blog = blogService.getBlogById(id);
            if (!blog.isPresent()) {
                model.addAttribute("error", "Không tìm thấy bài viết");
                return "redirect:/admin/blogs";
            }
            model.addAttribute("blog", blog.get());
            return "viewblog";
        } catch (Exception e) {
            logger.error("Error viewing blog: {}", e.getMessage(), e);
            model.addAttribute("error", "Không thể xem bài viết: " + e.getMessage());
            return "redirect:/admin/blogs";
        }
    }

    @PostMapping("/blogs/toggle/{id}")
    public String toggleBlogStatus(@PathVariable Integer id, Model model) {
        try {
            Blog blog = blogService.updateBlogStatus(id, null);
            model.addAttribute("success", "Cập nhật trạng thái bài viết thành công");
            return "redirect:/admin/blogs";
        } catch (Exception e) {
            logger.error("Error toggling blog status: {}", e.getMessage(), e);
            model.addAttribute("error", "Không thể cập nhật trạng thái bài viết: " + e.getMessage());
            return "redirect:/admin/blogs";
        }
    }

    @PostMapping("/blogs/delete/{id}")
    public String deleteBlog(@PathVariable Integer id, Model model) {
        try {
            blogService.deleteBlog(id);
            model.addAttribute("success", "Xóa bài viết thành công");
            return "redirect:/admin/blogs";
        } catch (Exception e) {
            logger.error("Error deleting blog: {}", e.getMessage(), e);
            model.addAttribute("error", "Không thể xóa bài viết: " + e.getMessage());
            return "redirect:/admin/blogs";
        }
    }

    @GetMapping("/blogs/add")
    public String showAddBlogForm(Model model) {
        model.addAttribute("blog", new Blog());
        return "addblog";
    }

    @PostMapping("/blogs/add")
    public String addBlog(@ModelAttribute Blog blog, 
                         @RequestParam("image") MultipartFile image,
                         @RequestParam("status") String status,
                         Model model) {
        try {
            // Set created date
            blog.setCreatedDate(new Date());
            
            // Set status
            blog.setStatus(status);
            
            // Set views to 0 for new blog
            blog.setViews(0);
            
            // Get current user as author
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            User currentUser = userService.getUserByEmail(auth.getName());
            blog.setAuthor(currentUser);
            
            // Handle image upload if present
            if (!image.isEmpty()) {
                String fileName = StringUtils.cleanPath(image.getOriginalFilename());
                String uploadDir = "src/main/resources/static/images/blogs/";
                File uploadPath = new File(uploadDir);
                
                if (!uploadPath.exists()) {
                    uploadPath.mkdirs();
                }
                
                try {
                    Path filePath = uploadPath.toPath().resolve(fileName);
                    Files.copy(image.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
                    blog.setImageUrl("/images/blogs/" + fileName);
                } catch (IOException e) {
                    logger.error("Error uploading image: {}", e.getMessage());
                    model.addAttribute("error", "Không thể tải lên hình ảnh: " + e.getMessage());
                    return "addblog";
                }
            }
            
            // Save blog
            blogService.saveBlog(blog);
            model.addAttribute("success", "Thêm bài viết thành công");
            return "redirect:/admin/blogs";
            
        } catch (Exception e) {
            logger.error("Error adding blog: {}", e.getMessage(), e);
            model.addAttribute("error", "Không thể thêm bài viết: " + e.getMessage());
            return "addblog";
        }
    }

    // Product management endpoints
    @GetMapping("/products/add")
    public String showAddProductForm(Model model) {
        model.addAttribute("product", new Product());
        model.addAttribute("categories", categoryService.getAllCategories());
        return "addproduct";
    }

    @GetMapping("/products/edit/{id}")
    public String showEditProductForm(@PathVariable Integer id, Model model) {
        model.addAttribute("product", productService.getProductById(id));
        return "editproduct";
    }

    @PostMapping("/products/delete/{id}")
    public String deleteProduct(@PathVariable Integer id) {
        productService.deleteProduct(id);
        return "redirect:/admin/products";
    }

    @PostMapping("/products/add")
    public String addProduct(@ModelAttribute("product") Product product,
                            @RequestParam("imageFile") MultipartFile image,
                            Model model) {
        try {
            // Validate category
            if (product.getCategory() == null || product.getCategory().getCategoryID() == null) {
                model.addAttribute("error", "Vui lòng chọn danh mục sản phẩm");
                model.addAttribute("categories", categoryService.getAllCategories());
                return "admin/addproduct";
            }

            // Get category from database
            Category category = categoryService.getCategoryById(product.getCategory().getCategoryID());
            if (category == null) {
                model.addAttribute("error", "Danh mục không tồn tại");
                model.addAttribute("categories", categoryService.getAllCategories());
                return "admin/addproduct";
            }
            product.setCategory(category);

            // Handle image upload
            if (!image.isEmpty()) {
                String fileName = StringUtils.cleanPath(image.getOriginalFilename());
                String uploadDir = "src/main/webapp/resources/images/products/";
                File uploadPath = new File(uploadDir);
                if (!uploadPath.exists()) {
                    uploadPath.mkdirs();
                }
                try {
                    Path filePath = uploadPath.toPath().resolve(fileName);
                    Files.copy(image.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
                    product.setImageUrl("/resources/images/products/" + fileName);
                } catch (IOException e) {
                    model.addAttribute("error", "Lỗi khi tải lên hình ảnh: " + e.getMessage());
                    model.addAttribute("categories", categoryService.getAllCategories());
                    return "admin/addproduct";
                }
            }

            // Save product
            try {
                productService.saveProduct(product);
                return "redirect:/admin/products";
            } catch (IllegalArgumentException e) {
                model.addAttribute("error", e.getMessage());
                model.addAttribute("categories", categoryService.getAllCategories());
                return "admin/addproduct";
            } catch (Exception e) {
                model.addAttribute("error", "Lỗi khi lưu sản phẩm: " + e.getMessage());
                model.addAttribute("categories", categoryService.getAllCategories());
                return "admin/addproduct";
            }
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi không xác định: " + e.getMessage());
            model.addAttribute("categories", categoryService.getAllCategories());
            return "admin/addproduct";
        }
    }

    @PostMapping("/products/edit/{id}")
    public String updateProduct(@PathVariable Integer id, 
                              @ModelAttribute Product product, 
                              @RequestParam(value = "image", required = false) MultipartFile image,
                              Model model) {
        try {
            Product existingProduct = productService.getProductById(id);
            if (existingProduct == null) {
                model.addAttribute("error", "Không tìm thấy sản phẩm");
                return "redirect:/admin/products";
            }

            // Validate category
            if (product.getCategory() == null || product.getCategory().getCategoryID() == null) {
                model.addAttribute("error", "Vui lòng chọn danh mục sản phẩm");
                model.addAttribute("categories", categoryService.getAllCategories());
                return "admin/editproduct";
            }

            // Get category from database
            Category category = categoryService.getCategoryById(product.getCategory().getCategoryID());
            if (category == null) {
                model.addAttribute("error", "Danh mục không tồn tại");
                model.addAttribute("categories", categoryService.getAllCategories());
                return "admin/editproduct";
            }
            product.setCategory(category);

            // Handle image upload
            if (image != null && !image.isEmpty()) {
                String fileName = StringUtils.cleanPath(image.getOriginalFilename());
                String uploadDir = "src/main/webapp/resources/images/products/";
                File uploadPath = new File(uploadDir);
                if (!uploadPath.exists()) {
                    uploadPath.mkdirs();
                }
                try {
                    Path filePath = uploadPath.toPath().resolve(fileName);
                    Files.copy(image.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
                    product.setImageUrl("/resources/images/products/" + fileName);
                } catch (IOException e) {
                    model.addAttribute("error", "Lỗi khi tải lên hình ảnh: " + e.getMessage());
                    model.addAttribute("categories", categoryService.getAllCategories());
                    return "admin/editproduct";
                }
            } else {
                // Keep existing image if no new image is uploaded
                product.setImageUrl(existingProduct.getImageUrl());
            }

            // Validate product data
            if (product.getCode() == null || product.getCode().trim().isEmpty()) {
                model.addAttribute("error", "Mã sản phẩm không được để trống");
                model.addAttribute("categories", categoryService.getAllCategories());
                return "admin/editproduct";
            }
            if (product.getName() == null || product.getName().trim().isEmpty()) {
                model.addAttribute("error", "Tên sản phẩm không được để trống");
                model.addAttribute("categories", categoryService.getAllCategories());
                return "admin/editproduct";
            }
            if (product.getPrice() == null || product.getPrice().compareTo(BigDecimal.ZERO) <= 0) {
                model.addAttribute("error", "Giá sản phẩm phải lớn hơn 0");
                model.addAttribute("categories", categoryService.getAllCategories());
                return "admin/editproduct";
            }
            if (product.getQuantity() == null || product.getQuantity() < 0) {
                model.addAttribute("error", "Số lượng sản phẩm không được âm");
                model.addAttribute("categories", categoryService.getAllCategories());
                return "admin/editproduct";
            }

            // Update product
            product.setProductID(id);
            productService.saveProduct(product);
            return "redirect:/admin/products?success=true";
        } catch (Exception e) {
            logger.error("Error updating product: " + e.getMessage());
            model.addAttribute("error", "Lỗi khi cập nhật sản phẩm: " + e.getMessage());
            model.addAttribute("categories", categoryService.getAllCategories());
            return "admin/editproduct";
        }
    }

    // Voucher management endpoints
    @GetMapping("/vouchers/add")
    public String showAddVoucherForm(Model model) {
        model.addAttribute("voucher", new Voucher());
        return "addvoucher";
    }

    @PostMapping("/vouchers/add")
    public String addVoucher(@ModelAttribute("voucher") Voucher voucher, Model model) {
        logger.info("=== Starting to add new voucher ===");
        logger.info("Voucher details received:");
        logger.info("Code: {}", voucher.getCode());
        logger.info("Name: {}", voucher.getName());
        logger.info("Type: {}", voucher.getType());
        logger.info("Value: {}", voucher.getValue());
        logger.info("Quantity: {}", voucher.getQuantity());
        logger.info("Start Date: {}", voucher.getStartDate());
        logger.info("End Date: {}", voucher.getEndDate());
        logger.info("Active: {}", voucher.getActive());
        
        try {
            // Validate voucher data
            if (voucher.getCode() == null || voucher.getCode().trim().isEmpty()) {
                logger.error("Validation failed: Voucher code is empty");
                model.addAttribute("error", "Mã voucher không được để trống");
                return "addvoucher";
            }

            if (voucher.getName() == null || voucher.getName().trim().isEmpty()) {
                logger.error("Validation failed: Voucher name is empty");
                model.addAttribute("error", "Tên voucher không được để trống");
                return "addvoucher";
            }

            if (voucher.getType() == null || voucher.getType().trim().isEmpty()) {
                logger.error("Validation failed: Voucher type is empty");
                model.addAttribute("error", "Loại voucher không được để trống");
                return "addvoucher";
            }

            if (voucher.getValue() == null || voucher.getValue() <= 0) {
                logger.error("Validation failed: Invalid voucher value: {}", voucher.getValue());
                model.addAttribute("error", "Giá trị voucher phải lớn hơn 0");
                return "addvoucher";
            }

            if (voucher.getQuantity() == null || voucher.getQuantity() <= 0) {
                logger.error("Validation failed: Invalid voucher quantity: {}", voucher.getQuantity());
                model.addAttribute("error", "Số lượng voucher phải lớn hơn 0");
                return "addvoucher";
            }

            if (voucher.getStartDate() == null) {
                logger.error("Validation failed: Start date is null");
                model.addAttribute("error", "Ngày bắt đầu không được để trống");
                return "addvoucher";
            }

            if (voucher.getEndDate() == null) {
                logger.error("Validation failed: End date is null");
                model.addAttribute("error", "Ngày kết thúc không được để trống");
                return "addvoucher";
            }

            if (voucher.getStartDate().after(voucher.getEndDate())) {
                logger.error("Validation failed: Start date {} is after end date {}", 
                    voucher.getStartDate(), voucher.getEndDate());
                model.addAttribute("error", "Ngày bắt đầu phải trước ngày kết thúc");
                return "addvoucher";
            }

            // Validate value based on type
            if (voucher.getType().equals("PERCENTAGE") && (voucher.getValue() <= 0 || voucher.getValue() > 100)) {
                logger.error("Validation failed: Invalid percentage value: {}", voucher.getValue());
                model.addAttribute("error", "Giá trị phần trăm phải từ 1 đến 100");
                return "addvoucher";
            }

            if (voucher.getType().equals("FIXED_AMOUNT") && voucher.getValue() <= 0) {
                logger.error("Validation failed: Invalid fixed amount value: {}", voucher.getValue());
                model.addAttribute("error", "Giá trị tiền phải lớn hơn 0");
                return "addvoucher";
            }

            // Set default values
            if (voucher.getActive() == null) {
                voucher.setActive(true);
            }
            logger.info("Set voucher active status to: {}", voucher.getActive());

            // Check if voucher code already exists
            List<Voucher> existingVouchers = voucherService.getVoucherByCode(voucher.getCode());
            if (!existingVouchers.isEmpty()) {
                logger.error("Validation failed: Voucher code {} already exists", voucher.getCode());
                model.addAttribute("error", "Mã voucher đã tồn tại");
                return "addvoucher";
            }

            // Save the voucher
            try {
                logger.info("Attempting to save voucher to database...");
                Voucher savedVoucher = voucherService.saveVoucher(voucher);
                logger.info("Successfully saved voucher with ID: {}", savedVoucher.getVoucherID());
                logger.info("=== Finished adding new voucher ===");
                return "redirect:/admin/vouchers?success=true";
            } catch (Exception e) {
                logger.error("Error saving voucher to database: {}", e.getMessage(), e);
                model.addAttribute("error", "Có lỗi xảy ra khi lưu voucher: " + e.getMessage());
                return "addvoucher";
            }
        } catch (Exception e) {
            logger.error("Unexpected error in addVoucher: {}", e.getMessage(), e);
            model.addAttribute("error", "Có lỗi xảy ra khi thêm voucher: " + e.getMessage());
            return "addvoucher";
        }
    }

    @GetMapping("/vouchers/edit/{id}")
    public String showEditVoucherForm(@PathVariable Integer id, Model model) {
        try {
            Optional<Voucher> voucherOpt = voucherService.getVoucherById(id);
            if (voucherOpt.isPresent()) {
                model.addAttribute("voucher", voucherOpt.get());
                return "editvoucher";
            }
            return "redirect:/admin/vouchers?error=Voucher không tồn tại";
        } catch (Exception e) {
            logger.error("Error getting voucher: " + e.getMessage());
            return "redirect:/admin/vouchers?error=Có lỗi xảy ra";
        }
    }

    @PostMapping("/vouchers/edit/{id}")
    public String updateVoucher(@PathVariable Integer id, @ModelAttribute Voucher voucher, Model model) {
        try {
            // Validate dates
            if (voucher.getStartDate().after(voucher.getEndDate())) {
                model.addAttribute("error", "Ngày bắt đầu phải trước ngày kết thúc");
                return "editvoucher";
            }

            // Validate value based on type
            if (voucher.getType().equals("PERCENTAGE") && (voucher.getValue() <= 0 || voucher.getValue() > 100)) {
                model.addAttribute("error", "Giá trị phần trăm phải từ 1 đến 100");
                return "editvoucher";
            }

            if (voucher.getType().equals("FIXED_AMOUNT") && voucher.getValue() <= 0) {
                model.addAttribute("error", "Giá trị tiền phải lớn hơn 0");
                return "editvoucher";
            }

            voucher.setVoucherID(id);
            voucherService.saveVoucher(voucher);
            return "redirect:/admin/vouchers?success=true";
        } catch (Exception e) {
            logger.error("Error updating voucher: " + e.getMessage());
            model.addAttribute("error", "Có lỗi xảy ra khi cập nhật voucher: " + e.getMessage());
        return "editvoucher";
        }
    }

    @PostMapping("/vouchers/delete/{id}")
    public String deleteVoucher(@PathVariable Integer id) {
        try {
        voucherService.deleteVoucher(id);
            return "redirect:/admin/vouchers?success=true";
        } catch (Exception e) {
            logger.error("Error deleting voucher: " + e.getMessage());
            return "redirect:/admin/vouchers?error=Có lỗi xảy ra khi xóa voucher";
        }
    }

    @GetMapping("/users/add")
    public String showAddUserForm(Model model) {
        model.addAttribute("user", new User());
        return "adduser";
    }

    @PostMapping("/users/add")
    public String addUser(@ModelAttribute User user, Model model) {
        try {
            // Validate user data
            if (userService.getUserByEmail(user.getEmail()) != null) {
                model.addAttribute("error", "Email đã tồn tại");
                return "adduser";
            }
            if (userService.getUserByUsername(user.getUsername()) != null) {
                model.addAttribute("error", "Tên đăng nhập đã tồn tại");
                return "adduser";
            }

            // Set default values
            user.setVerified(true);
            user.setAccess("ACTIVE");
            user.setPassword(passwordEncoder.encode(user.getPassword()));

            userService.saveUser(user);
            model.addAttribute("success", "Thêm người dùng thành công");
            return "redirect:/admin/users";
        } catch (Exception e) {
            logger.error("Error adding user: {}", e.getMessage(), e);
            model.addAttribute("error", "Không thể thêm người dùng: " + e.getMessage());
            return "adduser";
        }
    }

    @GetMapping("/users/edit/{email}")
    public String showEditUserForm(@PathVariable String email, Model model) {
        try {
            User user = userService.getUserByEmail(email);
            if (user == null) {
                model.addAttribute("error", "Không tìm thấy người dùng");
                return "redirect:/admin/users";
            }
            model.addAttribute("user", user);
            return "edituser";
        } catch (Exception e) {
            logger.error("Error showing edit user form: {}", e.getMessage(), e);
            model.addAttribute("error", "Không thể tải thông tin người dùng: " + e.getMessage());
            return "redirect:/admin/users";
        }
    }

    @PostMapping("/users/edit/{email}")
    public String updateUser(@PathVariable String email, @ModelAttribute User user, Model model) {
        try {
            User existingUser = userService.getUserByEmail(email);
            if (existingUser == null) {
                model.addAttribute("error", "Không tìm thấy người dùng");
                return "redirect:/admin/users";
            }

            // Update user information
            existingUser.setFullName(user.getFullName());
            existingUser.setPhoneNumbers(user.getPhoneNumbers());
            existingUser.setDob(user.getDob());
            existingUser.setGender(user.getGender());
            existingUser.setRole(user.getRole());
            existingUser.setAccess(user.getAccess());

            // Update password if provided
            if (user.getPassword() != null && !user.getPassword().isEmpty()) {
                existingUser.setPassword(passwordEncoder.encode(user.getPassword()));
            }

            userService.saveUser(existingUser);
            model.addAttribute("success", "Cập nhật thông tin người dùng thành công");
            return "redirect:/admin/users";
        } catch (Exception e) {
            logger.error("Error updating user: {}", e.getMessage(), e);
            model.addAttribute("error", "Không thể cập nhật thông tin người dùng: " + e.getMessage());
            return "edituser";
        }
    }
} 