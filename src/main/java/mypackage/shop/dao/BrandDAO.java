/*
 * BrandDAO sử dụng JPA EntityManager
 */
package mypackage.shop.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import mypackage.shop.model.Brand;

import java.util.List;

/**
 * BrandDAO - CRUD operations for Brand using JPA
 * @author PC
 */
public class BrandDAO extends GenericDAO<Brand> {

    public BrandDAO() {
        super(Brand.class);
    }

    /**
     * Get all brands with product count
     */
    public List<Brand> getAllBrands() {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT b FROM Brand b ORDER BY b.name";
            List<Brand> brands = em.createQuery(jpql, Brand.class).getResultList();
            
            // Calculate product count for each brand
            for (Brand b : brands) {
                String countJpql = "SELECT COUNT(p) FROM Product p WHERE p.brand.id = :brandId";
                Long count = em.createQuery(countJpql, Long.class)
                              .setParameter("brandId", b.getId())
                              .getSingleResult();
                b.setProductCount(count.intValue());
            }
            
            return brands;
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        } finally {
            em.close();
        }
    }

    /**
     * Get brand by ID
     */
    public Brand getBrandById(int id) {
        EntityManager em = getEntityManager();
        try {
            Brand brand = em.find(Brand.class, id);
            if (brand != null) {
                String countJpql = "SELECT COUNT(p) FROM Product p WHERE p.brand.id = :brandId";
                Long count = em.createQuery(countJpql, Long.class)
                              .setParameter("brandId", id)
                              .getSingleResult();
                brand.setProductCount(count.intValue());
            }
            return brand;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    /**
     * Add new brand
     */
    public int addBrand(Brand brand) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            em.persist(brand);
            tx.commit();
            return brand.getId();
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
     * Update existing brand
     */
    public boolean updateBrand(Brand brand) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            
            Brand existing = em.find(Brand.class, brand.getId());
            if (existing != null) {
                existing.setName(brand.getName());
                existing.setLogoUrl(brand.getLogoUrl());
                existing.setOrigin(brand.getOrigin());
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
     * Delete brand by ID
     */
    public boolean deleteBrand(int id) {
        return delete(id);
    }

    /**
     * Count total brands
     */
    public int getTotalBrands() {
        return (int) count();
    }

    /**
     * Check if brand name exists
     */
    public boolean isBrandNameExists(String name, int excludeId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT COUNT(b) FROM Brand b WHERE b.name = :name AND b.id != :excludeId";
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
