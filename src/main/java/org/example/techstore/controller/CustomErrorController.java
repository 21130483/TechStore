package org.example.techstore.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

@Controller
public class CustomErrorController implements ErrorController {
    
    private static final Logger logger = LoggerFactory.getLogger(CustomErrorController.class);

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request) {
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        Object uri = request.getAttribute(RequestDispatcher.ERROR_REQUEST_URI);
        Object msg = request.getAttribute(RequestDispatcher.ERROR_MESSAGE);
        
        logger.error("Error occurred - Status: {}, URI: {}, Message: {}", status, uri, msg);

        if (status != null) {
            Integer statusCode = Integer.valueOf(status.toString());
            logger.error("Status code: {}", statusCode);

            // Cho phép truy cập trực tiếp đến trang admin
            if (uri != null && uri.toString().startsWith("/admin")) {
                return "admin";
            }

            if(statusCode == 404) {
                return "redirect:/index";
            }
            if(statusCode == 500) {
                return "redirect:/index";
            }
        }
        return "redirect:/index";
    }
}