/*
 * NewsletterServlet - Xử lý đăng ký nhận ưu đãi
 * Gán voucher giảm giá cho user khi đăng ký email
 */
package mypackage.shop.controller;

import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import mypackage.shop.dao.UserVoucherDAO;
import mypackage.shop.dao.VoucherDAO;
import mypackage.shop.dao.UserDAO;
import mypackage.shop.model.User;
import mypackage.shop.model.UserVoucher;
import mypackage.shop.model.Voucher;
import mypackage.shop.utils.HibernateUtil;

/**
 * NewsletterServlet - Đăng ký nhận voucher ưu đãi
 * @author PC
 */
@WebServlet(name = "NewsletterServlet", urlPatterns = {"/newsletter/subscribe"})
public class NewsletterServlet extends HttpServlet {

    private VoucherDAO voucherDAO;
    private UserVoucherDAO userVoucherDAO;
    private UserDAO userDAO;
    
    // Mã voucher sẽ được tặng khi đăng ký (giảm 20%)
    private static final String WELCOME_VOUCHER_CODE = "GIAM20";
    
    @Override
    public void init() throws ServletException {
        super.init();
        voucherDAO = new VoucherDAO();
        userVoucherDAO = new UserVoucherDAO();
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        HttpSession session = request.getSession();
        
        // Validate email
        if (email == null || email.trim().isEmpty()) {
            session.setAttribute("errorMessage", "Vui lòng nhập email!");
            response.sendRedirect(request.getContextPath() + "/home#newsletter");
            return;
        }
        
        email = email.trim().toLowerCase();
        
        // Validate email format
        if (!isValidEmail(email)) {
            session.setAttribute("errorMessage", "Email không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/home#newsletter");
            return;
        }
        
        try {
            // Find user by email
            User user = userDAO.findByEmail(email);
            
            if (user == null) {
                // Email chưa có tài khoản - khuyến khích đăng ký
                session.setAttribute("errorMessage", 
                    "Email chưa có tài khoản! Vui lòng đăng ký tài khoản với email này để nhận voucher.");
                response.sendRedirect(request.getContextPath() + "/register?email=" + email);
                return;
            }
            
            // Find the welcome voucher
            Voucher welcomeVoucher = voucherDAO.findByCode(WELCOME_VOUCHER_CODE);
            
            if (welcomeVoucher == null) {
                session.setAttribute("errorMessage", "Voucher không khả dụng. Vui lòng thử lại sau!");
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
            
            // Check if user already has this voucher
            UserVoucher existingVoucher = userVoucherDAO.getUserVoucher(user.getId(), welcomeVoucher.getId());
            
            if (existingVoucher != null) {
                session.setAttribute("errorMessage", 
                    "Bạn đã nhận voucher " + WELCOME_VOUCHER_CODE + " rồi! Kiểm tra trong giỏ hàng để sử dụng.");
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
            
            // Assign voucher to user
            boolean success = assignVoucherToUser(user, welcomeVoucher);
            
            if (success) {
                // Send email with voucher
                boolean emailSent = mypackage.shop.utils.EmailUtils.sendVoucherEmail(
                    email, 
                    WELCOME_VOUCHER_CODE, 
                    welcomeVoucher.getDiscountPercent()
                );
                
                if (emailSent) {
                    session.setAttribute("successMessage", 
                        "🎉 Chúc mừng! Voucher " + WELCOME_VOUCHER_CODE + 
                        " đã được gửi đến email của bạn. Kiểm tra hộp thư để xem chi tiết!");
                } else {
                    // Email failed but voucher still assigned
                    session.setAttribute("successMessage", 
                        "🎉 Bạn đã nhận voucher " + WELCOME_VOUCHER_CODE + 
                        " giảm " + welcomeVoucher.getDiscountPercent() + "%. " +
                        "Vào giỏ hàng để sử dụng! (Không thể gửi email thông báo)");
                }
            } else {
                session.setAttribute("errorMessage", "Có lỗi xảy ra. Vui lòng thử lại!");
            }
            
        } catch (Exception e) {
            System.err.println("Newsletter error: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/home");
    }
    
    /**
     * Assign voucher to user
     */
    private boolean assignVoucherToUser(User user, Voucher voucher) {
        EntityManager em = HibernateUtil.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            
            UserVoucher userVoucher = new UserVoucher();
            userVoucher.setUser(em.find(User.class, user.getId()));
            userVoucher.setVoucher(em.find(Voucher.class, voucher.getId()));
            userVoucher.setUsed(false);
            userVoucher.setAssignedAt(new Timestamp(System.currentTimeMillis()));
            
            em.persist(userVoucher);
            em.getTransaction().commit();
            
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
    
    /**
     * Simple email validation
     */
    private boolean isValidEmail(String email) {
        return email != null && 
               email.contains("@") && 
               email.contains(".") && 
               email.length() > 5;
    }
}
