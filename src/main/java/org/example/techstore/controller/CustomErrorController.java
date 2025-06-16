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

        // Nếu là lỗi 404 hoặc 500, chuyển về trang chủ
        if (status != null) {
            Integer statusCode = Integer.valueOf(status.toString());
            logger.error("Status code: {}", statusCode);

            if (statusCode == 404 || statusCode == 500) {
                return "redirect:/";
            }
        }

        // Mặc định chuyển về trang chủ
        return "redirect:/";
    }
}