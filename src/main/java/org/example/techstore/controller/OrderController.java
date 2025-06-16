package org.example.techstore.controller;

import org.example.techstore.model.Purchase;
import org.example.techstore.service.PurchaseService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/orders")
public class OrderController {
    private static final Logger logger = LoggerFactory.getLogger(OrderController.class);

    @Autowired
    private PurchaseService purchaseService;

    @GetMapping
    public String listOrders(Model model) {
        try {
            logger.info("Fetching all orders");
            List<Purchase> orders = purchaseService.getAllPurchases();
            model.addAttribute("orders", orders);
            return "orders";
        } catch (Exception e) {
            logger.error("Error fetching orders: " + e.getMessage(), e);
            model.addAttribute("error", "Có lỗi xảy ra khi lấy danh sách đơn hàng");
            return "orders";
        }
    }

    @GetMapping("/{id}")
    public String viewOrder(@PathVariable Integer id, Model model) {
        try {
            logger.info("Fetching order details for ID: {}", id);
            Purchase order = purchaseService.getPurchaseById(id);
            if (order != null) {
                model.addAttribute("order", order);
                return "order-detail";
            }
            return "redirect:/orders";
        } catch (Exception e) {
            logger.error("Error fetching order details: " + e.getMessage(), e);
            return "redirect:/orders?error=Có lỗi xảy ra";
        }
    }

    @PostMapping("/{id}/status")
    public String updateOrderStatus(@PathVariable Integer id, 
                                  @RequestParam String status,
                                  Model model) {
        try {
            logger.info("Updating order status for ID: {} to: {}", id, status);
            purchaseService.updatePurchaseStatus(id, status);
            return "redirect:/orders?success=true";
        } catch (Exception e) {
            logger.error("Error updating order status: " + e.getMessage(), e);
            return "redirect:/orders?error=Có lỗi xảy ra khi cập nhật trạng thái";
        }
    }

    @PostMapping("/{id}/delete")
    public String deleteOrder(@PathVariable Integer id) {
        try {
            logger.info("Deleting order with ID: {}", id);
            purchaseService.deletePurchase(id);
            return "redirect:/orders?success=true";
        } catch (Exception e) {
            logger.error("Error deleting order: " + e.getMessage(), e);
            return "redirect:/orders?error=Có lỗi xảy ra khi xóa đơn hàng";
        }
    }
} 