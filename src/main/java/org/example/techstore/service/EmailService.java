package org.example.techstore.service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

@Service
public class EmailService {
    @Autowired
    private JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String from;

    public void sendVerificationEmail(String to, String token) throws MessagingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

        String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
        String verificationLink = baseUrl + "/verify?token=" + token;
        
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

        mailSender.send(message);
    }


    public void sendForgotPasswordEmail(String email, String resetToken) {
        String subject = "Password Reset Request";
        String path = "/req/reset-password";
        String message = "Click the button below to reset your password:";
        sendEmail(email, resetToken, subject, path, message);
    }


    private void sendEmail(String email, String token, String subject, String path, String message) {
        try {
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
            mailSender.send(mimeMessage);

        } catch (Exception e) {
            System.err.println("Failed to send email: " + e.getMessage());
        }
    }
}