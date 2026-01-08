package mypackage.shop.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import mypackage.shop.model.ChatMessage;
import mypackage.shop.model.ChatSession;
import mypackage.shop.utils.HibernateUtil;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

/**
 * DAO xử lý thao tác CSDL cho Chat
 */
public class ChatDAO {
    
    private EntityManager getEntityManager() {
        return HibernateUtil.getEntityManager();
    }
    
    /**
     * Tạo phiên chat mới với UUID
     */
    public ChatSession createSession(ChatSession session) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            if (session.getId() == null) {
                session.setId(UUID.randomUUID().toString());
            }
            em.persist(session);
            tx.commit();
            return session;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }
    
    /**
     * Lấy phiên chat theo ID
     */
    public ChatSession getSessionById(String sessionId) {
        EntityManager em = getEntityManager();
        try {
            return em.find(ChatSession.class, sessionId);
        } finally {
            em.close();
        }
    }
    
    /**
     * Lưu tin nhắn vào database
     */
    public ChatMessage saveMessage(ChatMessage message) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(message);
            tx.commit();
            
            // Cập nhật thời gian phiên chat
            updateSessionTimestamp(message.getSessionId());
            
            return message;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }
    
    /**
     * Cập nhật thời gian cập nhật phiên chat
     */
    private void updateSessionTimestamp(String sessionId) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            ChatSession session = em.find(ChatSession.class, sessionId);
            if (session != null) {
                session.setUpdatedAt(LocalDateTime.now());
                em.merge(session);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
        } finally {
            em.close();
        }
    }
    
    /**
     * Lấy lịch sử tin nhắn của phiên chat
     */
    public List<ChatMessage> getMessagesBySession(String sessionId) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                "SELECT m FROM ChatMessage m WHERE m.sessionId = :sessionId ORDER BY m.createdAt ASC",
                ChatMessage.class)
                .setParameter("sessionId", sessionId)
                .getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Lấy các phiên chat gần đây (cho Admin)
     */
    public List<ChatSession> getRecentSessions(int limit) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                "SELECT s FROM ChatSession s ORDER BY s.updatedAt DESC",
                ChatSession.class)
                .setMaxResults(limit)
                .getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Lấy tất cả phiên chat đang active
     */
    public List<ChatSession> getActiveSessions() {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                "SELECT s FROM ChatSession s WHERE s.status = :status ORDER BY s.updatedAt DESC",
                ChatSession.class)
                .setParameter("status", ChatSession.ChatStatus.ACTIVE)
                .getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Đóng phiên chat
     */
    public void closeSession(String sessionId) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            ChatSession session = em.find(ChatSession.class, sessionId);
            if (session != null) {
                session.setStatus(ChatSession.ChatStatus.CLOSED);
                session.setUpdatedAt(LocalDateTime.now());
                em.merge(session);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
    
    /**
     * Đếm số tin nhắn trong phiên
     */
    public long countMessagesBySession(String sessionId) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                "SELECT COUNT(m) FROM ChatMessage m WHERE m.sessionId = :sessionId",
                Long.class)
                .setParameter("sessionId", sessionId)
                .getSingleResult();
        } finally {
            em.close();
        }
    }
}
