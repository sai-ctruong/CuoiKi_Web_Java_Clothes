/*
 * OrderDAO sử dụng JPA EntityManager
 */
package mypackage.shop.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import mypackage.shop.model.Order;
import mypackage.shop.model.OrderDetail;
import mypackage.shop.model.CartItem;
import mypackage.shop.model.User;
import mypackage.shop.model.Product;

import java.util.ArrayList;
import java.util.List;

/**
 * OrderDAO - Handles order creation with transaction using JPA
 * @author PC
 */
public class OrderDAO extends GenericDAO<Order> {

    public OrderDAO() {
        super(Order.class);
    }

    /**
     * Create order with transaction: Insert Order -> Insert Details -> Clear Cart
     * Returns the created order ID, or -1 if failed
     */
    public int createOrder(Order order, List<CartItem> cartItems, int userId) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = null;
        
        try {
            tx = em.getTransaction();
            tx.begin();
            
            // Get User entity
            User user = em.find(User.class, userId);
            order.setUser(user);
            
            // Create order details
            List<OrderDetail> orderDetails = new ArrayList<>();
            for (CartItem item : cartItems) {
                Product product = em.find(Product.class, item.getProductId());
                OrderDetail detail = new OrderDetail(order, product, item.getQuantity(), item.getProductPrice());
                orderDetails.add(detail);
            }
            order.setOrderDetails(orderDetails);
            
            // Persist order (cascades to order details)
            em.persist(order);
            
            // Clear cart
            String deleteCartJpql = "DELETE FROM CartItem c WHERE c.user.id = :userId";
            em.createQuery(deleteCartJpql)
              .setParameter("userId", userId)
              .executeUpdate();
            
            tx.commit();
            return order.getId();
            
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
            return -1;
        } finally {
            em.close();
        }
    }

    /**
     * Get order by ID with details
     */
    public Order getOrderById(int orderId) {
        EntityManager em = getEntityManager();
        try {
            // First, fetch Order with orderDetails and product (without images to avoid MultipleBagFetchException)
            String jpql = "SELECT DISTINCT o FROM Order o " +
                         "LEFT JOIN FETCH o.user " +
                         "LEFT JOIN FETCH o.orderDetails od " +
                         "LEFT JOIN FETCH od.product p " +
                         "WHERE o.id = :orderId";
            List<Order> results = em.createQuery(jpql, Order.class)
                                   .setParameter("orderId", orderId)
                                   .getResultList();
            
            if (results.isEmpty()) {
                return null;
            }
            
            Order order = results.get(0);
            
            // Now fetch images for each product separately to avoid MultipleBagFetchException
            for (OrderDetail detail : order.getOrderDetails()) {
                if (detail.getProduct() != null) {
                    // Force initialization of images collection
                    detail.getProduct().getImages().size();
                }
            }
            
            return order;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    /**
     * Get all orders for a user
     */
    public List<Order> getOrdersByUserId(int userId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT o FROM Order o " +
                         "WHERE o.user.id = :userId " +
                         "ORDER BY o.orderDate DESC";
            return em.createQuery(jpql, Order.class)
                    .setParameter("userId", userId)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        } finally {
            em.close();
        }
    }

    /**
     * Get order details
     */
    public List<OrderDetail> getOrderDetails(int orderId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT od FROM OrderDetail od " +
                         "LEFT JOIN FETCH od.product p " +
                         "LEFT JOIN FETCH p.images " +
                         "WHERE od.order.id = :orderId";
            return em.createQuery(jpql, OrderDetail.class)
                    .setParameter("orderId", orderId)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        } finally {
            em.close();
        }
    }

    /**
     * Update order status
     */
    public boolean updateOrderStatus(int orderId, String status) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            
            Order order = em.find(Order.class, orderId);
            if (order != null) {
                order.setStatus(status);
                em.merge(order);
                tx.commit();
                return true;
            }
            tx.rollback();
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            return false;
        } finally {
            em.close();
        }
    }

    /**
     * Get ALL orders for Admin
     */
    public List<Order> getAllOrders() {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT o FROM Order o ORDER BY o.orderDate DESC";
            return em.createQuery(jpql, Order.class).getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        } finally {
            em.close();
        }
    }

    /**
     * Get orders by status for Admin filtering
     */
    public List<Order> getOrdersByStatus(String status) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT o FROM Order o WHERE o.status = :status ORDER BY o.orderDate DESC";
            return em.createQuery(jpql, Order.class)
                    .setParameter("status", status)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        } finally {
            em.close();
        }
    }

    /**
     * Count orders by status
     */
    public int countOrdersByStatus(String status) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT COUNT(o) FROM Order o WHERE o.status = :status";
            Long count = em.createQuery(jpql, Long.class)
                          .setParameter("status", status)
                          .getSingleResult();
            return count.intValue();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            em.close();
        }
    }
}
