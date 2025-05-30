package org.example.techstore.service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

@Service
public class EmailService {
    private static final Logger logger = LoggerFactory.getLogger(EmailService.class);

    @Autowired
    private JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String from;

    public void sendVerificationEmail(String to, String token) throws MessagingException {
        try {
            logger.info("Preparing to send verification email to: {}", to);
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
            String verificationLink = baseUrl + "/verify?token=" + token;
            logger.debug("Verification link generated: {}", verificationLink);

            String emailContent =
                    "<html>" +
                            "<body style='font-family: Arial, sans-serif;'>" +
                            "<div style='background-color: #f5f5f5; padding: 20px; text-align: center;'>" +
                            "<h2 style='color: #333;'>Email Verification</h2>" +
                            "<p style='color: #666;'>Thank you for registering! Please click the button below to verify your email address.</p>" +
                            "<a href='" + verificationLink + "' style='display: inline-block; margin: 20px 0; padding: 10px 20px; " +
                            "background-color: #4CAF50; color: white; text-decoration: none; border-radius: 5px;'>" +
                            "Verify Email</a>" +
                            "<p style='color: #999; font-size: 12px;'>If the button doesn't work, copy and paste this link in your browser:<br>" +
                            verificationLink + "</p>" +
                            "</div>" +
                            "</body>" +
                            "</html>";

            helper.setFrom(from);
            helper.setTo(to);
            helper.setSubject("Verify your email address");
            helper.setText(emailContent, true);

            logger.debug("Attempting to send verification email...");
            mailSender.send(message);
            logger.info("Verification email sent successfully to: {}", to);
        } catch (Exception e) {
            logger.error("Failed to send verification email to: {}. Error: {}", to, e.getMessage(), e);
            throw e;
        }
    }

    public void sendForgotPasswordEmail(String email, String resetToken) {
        try {
            logger.info("Preparing to send password reset email to: {}", email);
            String subject = "Password Reset Request";
            String path = "/req/reset-password";
            String message = "Click the button below to reset your password:";
            sendEmail(email, resetToken, subject, path, message);
            logger.info("Password reset email sent successfully to: {}", email);
        } catch (Exception e) {
            logger.error("Failed to send password reset email to: {}. Error: {}", email, e.getMessage(), e);
            throw new RuntimeException("Failed to send password reset email", e);
        }
    }

    private void sendEmail(String email, String token, String subject, String path, String message) {
        try {
            logger.debug("Preparing to send email to: {} with subject: {}", email, subject);
            String actionUrl = ServletUriComponentsBuilder.fromCurrentContextPath()
                    .path(path)
                    .queryParam("token", token)
                    .toUriString();

            String content = """
                    <div style="font-family: Arial, sans-serif; max-width: 600px; margin: auto; padding: 20px; border-radius: 8px; background-color: #f9f9f9; text-align: center;">
                        <h2 style="color: #333;">%s</h2>
                        <p style="font-size: 16px; color: #555;">%s</p>
                        <a href="%s" style="display: inline-block; margin: 20px 0; padding: 10px 20px; font-size: 16px; color: #fff; background-color: #007bff; text-decoration: none; border-radius: 5px;">Proceed</a>
                        <p style="font-size: 14px; color: #777;">Or copy and paste this link into your browser:</p>
                        <p style="font-size: 14px; color: #007bff;">%s</p>
                        <p style="font-size: 12px; color: #aaa;">This is an automated message. Please do not reply.</p>
                    </div>
                """.formatted(subject, message, actionUrl, actionUrl);

            MimeMessage mimeMessage = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);

            helper.setTo(email);
            helper.setSubject(subject);
            helper.setFrom(from);
            helper.setText(content, true);

            logger.debug("Attempting to send email...");
            mailSender.send(mimeMessage);
            logger.info("Email sent successfully to: {}", email);
        } catch (Exception e) {
            logger.error("Failed to send email to: {}. Error: {}", email, e.getMessage(), e);
            throw new RuntimeException("Failed to send email", e);
        }
    }
}