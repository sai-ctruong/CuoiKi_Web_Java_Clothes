/*
 * CategoryDAO sử dụng JPA EntityManager
 */
package mypackage.shop.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import mypackage.shop.model.Category;
import mypackage.shop.util.HibernateUtil;

import java.util.List;

/**
 * CategoryDAO - CRUD operations for Category using JPA
 * @author PC
 */
public class CategoryDAO extends GenericDAO<Category> {

    public CategoryDAO() {
        super(Category.class);
    }

    /**
     * Get all categories with product count
     */
    public List<Category> getAllCategories() {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT c FROM Category c ORDER BY c.name";
            List<Category> categories = em.createQuery(jpql, Category.class).getResultList();
            
            // Calculate product count for each category
            for (Category c : categories) {
                String countJpql = "SELECT COUNT(p) FROM Product p WHERE p.category.id = :catId";
                Long count = em.createQuery(countJpql, Long.class)
                              .setParameter("catId", c.getId())
                              .getSingleResult();
                c.setProductCount(count.intValue());
            }
            
            return categories;
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        } finally {
            em.close();
        }
    }

    /**
     * Get category by ID with product count
     */
    public Category getCategoryById(int id) {
        EntityManager em = getEntityManager();
        try {
            Category category = em.find(Category.class, id);
            if (category != null) {
                String countJpql = "SELECT COUNT(p) FROM Product p WHERE p.category.id = :catId";
                Long count = em.createQuery(countJpql, Long.class)
                              .setParameter("catId", id)
                              .getSingleResult();
                category.setProductCount(count.intValue());
            }
            return category;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    /**
     * Add new category
     */
    public int addCategory(Category category) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            em.persist(category);
            tx.commit();
            return category.getId();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            return -1;
        } finally {
            em.close();
        }
    }

    /**
     * Update existing category
     */
    public boolean updateCategory(Category category) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            
            Category existing = em.find(Category.class, category.getId());
            if (existing != null) {
                existing.setName(category.getName());
                existing.setDescription(category.getDescription());
                em.merge(existing);
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
     * Delete category by ID
     */
    public boolean deleteCategory(int id) {
        return delete(id);
    }

    /**
     * Count total categories
     */
    public int getTotalCategories() {
        return (int) count();
    }

    /**
     * Check if category name exists
     */
    public boolean isCategoryNameExists(String name, int excludeId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT COUNT(c) FROM Category c WHERE c.name = :name AND c.id != :excludeId";
            Long count = em.createQuery(jpql, Long.class)
                          .setParameter("name", name)
                          .setParameter("excludeId", excludeId)
                          .getSingleResult();
            return count > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
}
