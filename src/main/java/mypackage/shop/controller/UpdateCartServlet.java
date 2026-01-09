
//Author: Hoai

package mypackage.shop.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import mypackage.shop.model.Cart;

@WebServlet(name = "UpdateCartServlet", urlPatterns = {"/cart/update"})
public class UpdateCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String quantityParam = request.getParameter("quantity");

        if (idParam != null && quantityParam != null) {
            try {
                int productId = Integer.parseInt(idParam);
                int quantity = Integer.parseInt(quantityParam);

                HttpSession session = request.getSession();
                Cart cart = (Cart) session.getAttribute("cart");

                if (cart != null) {
                    cart.updateItemQuantity(productId, quantity);
                    session.setAttribute("cart", cart);
                }

            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/cart.jsp");
    }
}
