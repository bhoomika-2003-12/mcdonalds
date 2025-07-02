package com.mcd.utility;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class Mail {
    
    public boolean sendWelcomeMail(String toMail, String name) {
        // Step 1: Define sender's Gmail address
        String from = "shivukumar2203@gmail.com";
        String password = "cuwsyenjqdyzocrg";
        
        // Step 2: Set SMTP server properties        
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        
        // Step 3: Create a session with authentication
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });
        
        try {
            // Step 4: Create the email message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(toMail));
            message.setSubject("Welcome to McDonald's - Registration Confirmation");
            
            // HTML content with McDonald's branding
            String htmlContent = "<html>"
                + "<head><style>"
                + "body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }"
                + ".header { color: #DA291C; text-align: center; }"
                + ".logo { text-align: center; margin: 20px 0; }"
                + ".footer { margin-top: 30px; font-size: 12px; color: #666; }"
                + "</style></head>"
                + "<body>"
                + "<div class='logo'>"
                + "<img src='https://www.mcdonalds.com/content/dam/sites/usa/nfl/icons/arches-logo_108x108.jpg' width='80' alt='McDonald's Logo'/>"
                + "</div>"
                + "<h2 class='header'>Welcome to McDonald's!</h2>"
                + "<p>Dear " + name + ",</p>"
                + "<p>Thank you for creating an account with McDonald's. We're delighted to have you join our family!</p>"
                + "<p>Now you can:</p>"
                + "<ul>"
                + "<li>Order your favorite meals online</li>"
                + "<li>Save your preferred orders</li>"
                + "<li>Earn rewards with every purchase</li>"
                + "<li>Get exclusive member offers</li>"
                + "</ul>"
                + "<p>Start exploring now by visiting our <a href='[YOUR_WEBSITE_URL]'>website</a> or mobile app.</p>"
                + "<div class='footer'>"
                + "<p>This email was sent to " + toMail + " as part of your McDonald's account registration.</p>"
                + "<p>&copy; " + java.time.Year.now().getValue() + " McDonald's. All rights reserved.</p>"
                + "</div>"
                + "</body></html>";
            
            message.setContent(htmlContent, "text/html");
            
            // Step 5: Send the email
            Transport.send(message);
            
            System.out.println("✅ Welcome email sent successfully to " + toMail);
            return true;
            
        } catch (MessagingException e) {
            System.err.println("❌ Failed to send email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}