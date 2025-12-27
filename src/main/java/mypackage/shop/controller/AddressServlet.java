package mypackage.shop.controller;

import mypackage.shop.dao.AddressDAO;
import mypackage.shop.model.Address;
import mypackage.shop.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * AddressServlet - Thêm/Sửa/Xóa địa chỉ giao hàng
 * @author PC
 */
@WebServlet(name = "AddressServlet", urlPatterns = {"/address"})
public class AddressServlet extends HttpServlet {

    private AddressDAO addressDAO = new AddressDAO();

    /**
     * GET - Hiển thị danh sách địa chỉ hoặc form sửa
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("edit".equals(action)) {
            // Lấy địa chỉ cần sửa
            int addressId = Integer.parseInt(request.getParameter("id"));
            Address address = addressDAO.getAddressById(addressId);
            
            // Kiểm tra quyền sở hữu
            if (address != null && address.getUserId() == currentUser.getId()) {
                request.setAttribute("editAddress", address);
            }
        } else if ("delete".equals(action)) {
            // Xóa địa chỉ
            int addressId = Integer.parseInt(request.getParameter("id"));
            Address address = addressDAO.getAddressById(addressId);
            
            if (address != null && address.getUserId() == currentUser.getId()) {
                boolean success = addressDAO.deleteAddress(addressId);
                if (success) {
                    request.setAttribute("success", "Xóa địa chỉ thành công!");
                } else {
                    request.setAttribute("error", "Có lỗi xảy ra khi xóa địa chỉ!");
                }
            }
        } else if ("setDefault".equals(action)) {
            // Đặt địa chỉ mặc định
            int addressId = Integer.parseInt(request.getParameter("id"));
            boolean success = addressDAO.setDefaultAddress(addressId, currentUser.getId());
            
            if (success) {
                request.setAttribute("success", "Đã đặt làm địa chỉ mặc định!");
            }
        }
        
        // Load danh sách địa chỉ
        List<Address> addresses = addressDAO.getAddressesByUserId(currentUser.getId());
        request.setAttribute("addresses", addresses);
        
        request.getRequestDispatcher("/address.jsp").forward(request, response);
    }

    /**
     * POST - Thêm hoặc cập nhật địa chỉ
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        // Lấy thông tin từ form
        String recipientName = request.getParameter("recipientName");
        String phone = request.getParameter("phone");
        String street = request.getParameter("street");
        String city = request.getParameter("city");
        boolean isDefault = "on".equals(request.getParameter("isDefault"));
        
        // Validate
        StringBuilder errors = new StringBuilder();
        
        if (recipientName == null || recipientName.trim().isEmpty()) {
            errors.append("Tên người nhận không được để trống. ");
        }
        
        if (phone == null || phone.trim().isEmpty()) {
            errors.append("Số điện thoại không được để trống. ");
        }
        
        if (street == null || street.trim().isEmpty()) {
            errors.append("Địa chỉ không được để trống. ");
        }
        
        if (city == null || city.trim().isEmpty()) {
            errors.append("Thành phố không được để trống. ");
        }
        
        if (errors.length() > 0) {
            request.setAttribute("error", errors.toString());
            doGet(request, response);
            return;
        }
        
        if ("update".equals(action)) {
            // Cập nhật địa chỉ
            int addressId = Integer.parseInt(request.getParameter("addressId"));
            Address address = addressDAO.getAddressById(addressId);
            
            // Kiểm tra quyền sở hữu
            if (address == null || address.getUserId() != currentUser.getId()) {
                request.setAttribute("error", "Không tìm thấy địa chỉ!");
                doGet(request, response);
                return;
            }
            
            address.setRecipientName(recipientName.trim());
            address.setPhone(phone.trim());
            address.setStreet(street.trim());
            address.setCity(city.trim());
            address.setDefault(isDefault);
            
            boolean success = addressDAO.updateAddress(address);
            
            if (success) {
                request.setAttribute("success", "Cập nhật địa chỉ thành công!");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại!");
            }
        } else {
            // Thêm địa chỉ mới
            Address address = new Address();
            address.setUserId(currentUser.getId());
            address.setRecipientName(recipientName.trim());
            address.setPhone(phone.trim());
            address.setStreet(street.trim());
            address.setCity(city.trim());
            
            // Nếu chưa có địa chỉ nào, đặt làm mặc định
            if (addressDAO.countAddresses(currentUser.getId()) == 0) {
                address.setDefault(true);
            } else {
                address.setDefault(isDefault);
            }
            
            boolean success = addressDAO.addAddress(address);
            
            if (success) {
                request.setAttribute("success", "Thêm địa chỉ mới thành công!");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại!");
            }
        }
        
        doGet(request, response);
    }
}
