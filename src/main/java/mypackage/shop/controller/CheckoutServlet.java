/*
 * CheckoutServlet - Handle checkout process
 */
package mypackage.shop.controller;

import mypackage.shop.dao.CartDAO;
import mypackage.shop.dao.OrderDAO;
import mypackage.shop.model.CartItem;
import mypackage.shop.model.Order;
import mypackage.shop.model.User;
import mypackage.shop.model.Voucher;
import mypackage.shop.utils.EmailUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

/**
 * CheckoutServlet - Display checkout form and process orders
 * @author PC
 */
@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Check login
        if (user == null) {
            session.setAttribute("redirectUrl", request.getRequestURL().toString());
            session.setAttribute("errorMessage", "Vui lòng đăng nhập để thanh toán!");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get cart items
        List<CartItem> cartItems = cartDAO.getCartByUserId(user.getId());
        
        // Check if cart is empty
        if (cartItems.isEmpty()) {
            session.setAttribute("errorMessage", "Giỏ hàng trống! Vui lòng thêm sản phẩm.");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        // Calculate totals
        BigDecimal subtotal = BigDecimal.ZERO;
        for (CartItem item : cartItems) {
            subtotal = subtotal.add(item.getSubtotal());
        }
        
        // Check for applied voucher
        BigDecimal discount = BigDecimal.ZERO;
        Voucher appliedVoucher = (Voucher) session.getAttribute("appliedVoucher");
        if (appliedVoucher != null) {
            discount = appliedVoucher.calculateDiscount(subtotal);
        }
        
        BigDecimal total = subtotal.subtract(discount);
        if (total.compareTo(BigDecimal.ZERO) < 0) {
            total = BigDecimal.ZERO;
        }
        
        // Set attributes
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("discount", discount);
        request.setAttribute("total", total);
        request.setAttribute("appliedVoucher", appliedVoucher);
        request.setAttribute("user", user);
        
        request.getRequestDispatcher("/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get form data
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String paymentMethod = request.getParameter("paymentMethod");
        
        // Validate
        if (fullName == null || fullName.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            address == null || address.trim().isEmpty()) {
            session.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin!");
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }
        
        // Get cart items
        List<CartItem> cartItems = cartDAO.getCartByUserId(user.getId());
        if (cartItems.isEmpty()) {
            session.setAttribute("errorMessage", "Giỏ hàng trống!");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        // Calculate totals
        BigDecimal subtotal = BigDecimal.ZERO;
        for (CartItem item : cartItems) {
            subtotal = subtotal.add(item.getSubtotal());
        }
        
        BigDecimal discount = BigDecimal.ZERO;
        Voucher appliedVoucher = (Voucher) session.getAttribute("appliedVoucher");
        if (appliedVoucher != null) {
            discount = appliedVoucher.calculateDiscount(subtotal);
        }
        
        BigDecimal total = subtotal.subtract(discount);
        if (total.compareTo(BigDecimal.ZERO) < 0) {
            total = BigDecimal.ZERO;
        }
        
        // Create Order
        Order order = new Order();
        order.setUserId(user.getId());
        order.setFullName(fullName.trim());
        order.setPhone(phone.trim());
        order.setShippingAddress(address.trim() + (city != null ? ", " + city.trim() : ""));
        order.setTotalAmount(total);
        order.setPaymentMethod(paymentMethod != null ? paymentMethod : Order.PAYMENT_COD);
        order.setStatus(Order.STATUS_PENDING);
        
        if (appliedVoucher != null) {
            order.setVoucherCode(appliedVoucher.getCode());
            order.setDiscountAmount(discount);
        }
        
        // Create order with transaction
        int orderId = orderDAO.createOrder(order, cartItems, user.getId());
        
        if (orderId > 0) {
            // Order created successfully
            order.setId(orderId);
            
            // Get order details for email
            order.setOrderDetails(orderDAO.getOrderDetails(orderId));
            
            // Clear voucher from session
            session.removeAttribute("appliedVoucher");
            
            // Update cart count
            session.setAttribute("cartCount", 0);
            
            // Send confirmation email (async - don't block on failure)
            try {
                if (user.getEmail() != null && !user.getEmail().isEmpty()) {
                    EmailUtils.sendOrderConfirmation(user.getEmail(), order);
                }
            } catch (Exception e) {
                // Log but don't fail the order
                System.err.println("Failed to send confirmation email: " + e.getMessage());
            }
            
            // Store order in session for success page
            session.setAttribute("lastOrder", order);
            
            response.sendRedirect(request.getContextPath() + "/order-success");
            
        } else {
            session.setAttribute("errorMessage", "Đặt hàng thất bại! Vui lòng thử lại.");
            response.sendRedirect(request.getContextPath() + "/checkout");
        }
    }
}
