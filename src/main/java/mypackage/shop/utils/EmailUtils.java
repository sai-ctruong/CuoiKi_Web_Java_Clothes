/*
 * EmailUtils - Send order confirmation emails using Jakarta Mail
 */
package mypackage.shop.utils;

import mypackage.shop.model.Order;
import mypackage.shop.model.OrderDetail;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

/**
 * EmailUtils - JavaMail utility for sending emails
 * @author PC
 */
public class EmailUtils {
    
    // Gmail SMTP configuration (Change these to your email settings)
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String EMAIL_FROM = "congtruong19802005@gmail.com";      // Change this
    private static final String EMAIL_PASSWORD = "ylkc whyy ewft mgds";     // Use App Password for Gmail
    
    /**
     * Send order confirmation email
     */
    public static boolean sendOrderConfirmation(String toEmail, Order order) {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_FROM, EMAIL_PASSWORD);
                }
            });
            
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_FROM, "Clothing Shop"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Xác nhận đơn hàng #" + order.getId() + " - Clothing Shop");
            
            // Build HTML email content
            String htmlContent = buildOrderEmailHtml(order);
            message.setContent(htmlContent, "text/html; charset=UTF-8");
            
            Transport.send(message);
            
            System.out.println("Email sent successfully to: " + toEmail);
            return true;
            
        } catch (Exception e) {
            System.err.println("Failed to send email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Build HTML content for order confirmation email
     */
    private static String buildOrderEmailHtml(Order order) {
        StringBuilder html = new StringBuilder();
        
        html.append("<!DOCTYPE html>");
        html.append("<html><head><meta charset='UTF-8'></head><body>");
        html.append("<div style='max-width: 600px; margin: 0 auto; font-family: Arial, sans-serif;'>");
        
        // Header
        html.append("<div style='background: #1a1a2e; color: #d4a24c; padding: 20px; text-align: center;'>");
        html.append("<h1 style='margin: 0;'>CLOTHING SHOP</h1>");
        html.append("</div>");
        
        // Content
        html.append("<div style='padding: 20px; background: #f8f9fa;'>");
        html.append("<h2 style='color: #1a1a2e;'>Xác nhận đơn hàng #").append(order.getId()).append("</h2>");
        html.append("<p>Xin chào <strong>").append(order.getFullName()).append("</strong>,</p>");
        html.append("<p>Cảm ơn bạn đã đặt hàng tại Clothing Shop! Đơn hàng của bạn đã được tiếp nhận và đang được xử lý.</p>");
        
        // Order Info
        html.append("<div style='background: white; padding: 15px; border-radius: 8px; margin: 15px 0;'>");
        html.append("<h3 style='margin-top: 0; color: #1a1a2e;'>Thông tin đơn hàng</h3>");
        html.append("<p><strong>Mã đơn hàng:</strong> #").append(order.getId()).append("</p>");
        html.append("<p><strong>Ngày đặt:</strong> ").append(order.getOrderDate()).append("</p>");
        html.append("<p><strong>Phương thức thanh toán:</strong> ").append(order.getPaymentMethodDisplay()).append("</p>");
        html.append("<p><strong>Trạng thái:</strong> ").append(order.getStatusDisplay()).append("</p>");
        html.append("</div>");
        
        // Shipping Info
        html.append("<div style='background: white; padding: 15px; border-radius: 8px; margin: 15px 0;'>");
        html.append("<h3 style='margin-top: 0; color: #1a1a2e;'>Địa chỉ nhận hàng</h3>");
        html.append("<p>").append(order.getFullName()).append("</p>");
        html.append("<p>").append(order.getPhone()).append("</p>");
        html.append("<p>").append(order.getShippingAddress()).append("</p>");
        html.append("</div>");
        
        // Order Details
        if (order.getOrderDetails() != null && !order.getOrderDetails().isEmpty()) {
            html.append("<div style='background: white; padding: 15px; border-radius: 8px; margin: 15px 0;'>");
            html.append("<h3 style='margin-top: 0; color: #1a1a2e;'>Chi tiết sản phẩm</h3>");
            html.append("<table style='width: 100%; border-collapse: collapse;'>");
            html.append("<tr style='background: #f0f0f0;'>");
            html.append("<th style='padding: 10px; text-align: left;'>Sản phẩm</th>");
            html.append("<th style='padding: 10px; text-align: center;'>SL</th>");
            html.append("<th style='padding: 10px; text-align: right;'>Giá</th>");
            html.append("</tr>");
            
            for (OrderDetail detail : order.getOrderDetails()) {
                html.append("<tr style='border-bottom: 1px solid #eee;'>");
                html.append("<td style='padding: 10px;'>").append(detail.getProductName()).append("</td>");
                html.append("<td style='padding: 10px; text-align: center;'>").append(detail.getQuantity()).append("</td>");
                html.append("<td style='padding: 10px; text-align: right;'>").append(String.format("%,.0f đ", detail.getSubtotal())).append("</td>");
                html.append("</tr>");
            }
            html.append("</table>");
            html.append("</div>");
        }
        
        // Total
        html.append("<div style='background: #1a1a2e; color: white; padding: 15px; border-radius: 8px; text-align: right;'>");
        html.append("<h3 style='margin: 0;'>Tổng cộng: <span style='color: #d4a24c;'>").append(String.format("%,.0f đ", order.getTotalAmount())).append("</span></h3>");
        html.append("</div>");
        
        // Footer
        html.append("<p style='margin-top: 20px; color: #666; font-size: 14px;'>");
        html.append("Nếu bạn có bất kỳ câu hỏi nào, vui lòng liên hệ với chúng tôi.");
        html.append("</p>");
        html.append("<p style='color: #666; font-size: 14px;'>Trân trọng,<br><strong>Clothing Shop Team</strong></p>");
        
        html.append("</div>");
        html.append("</div>");
        html.append("</body></html>");
        
        return html.toString();
    }
}
