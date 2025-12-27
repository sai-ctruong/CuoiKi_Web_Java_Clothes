/*
 * ProductDAO sử dụng JPA EntityManager
 */
package mypackage.shop.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import mypackage.shop.model.Product;
import mypackage.shop.model.ProductImage;
import mypackage.shop.model.Category;
import mypackage.shop.model.Brand;

import java.util.List;

/**
 * ProductDAO - CRUD operations for Product using JPA
 * @author PC
 */
public class ProductDAO extends GenericDAO<Product> {

    public ProductDAO() {
        super(Product.class);
    }

    /**
     * Get all products with category and brand info (random order for homepage)
     */
    public List<Product> getAllProducts() {
        EntityManager em = getEntityManager();
        try {
            // Get all products without ordering - we'll shuffle in Java
            String jpql = "SELECT DISTINCT p FROM Product p " +
                         "LEFT JOIN FETCH p.category " +
                         "LEFT JOIN FETCH p.brand " +
                         "LEFT JOIN FETCH p.images";
            List<Product> products = em.createQuery(jpql, Product.class).getResultList();
            // Shuffle for random display
            java.util.Collections.shuffle(products);
            return products;
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        } finally {
            em.close();
        }
    }

    /**
     * Get product by ID with all related data
     */
    public Product getProductById(int id) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT p FROM Product p " +
                         "LEFT JOIN FETCH p.category " +
                         "LEFT JOIN FETCH p.brand " +
                         "LEFT JOIN FETCH p.images " +
                         "WHERE p.id = :id";
            TypedQuery<Product> query = em.createQuery(jpql, Product.class);
            query.setParameter("id", id);
            List<Product> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    /**
     * Add new product
     */
    public int addProduct(Product product) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            
            // Set category and brand relationships
            if (product.getCategoryId() > 0) {
                Category category = em.find(Category.class, product.getCategoryId());
                product.setCategory(category);
            }
            if (product.getBrandId() > 0) {
                Brand brand = em.find(Brand.class, product.getBrandId());
                product.setBrand(brand);
            }
            
            em.persist(product);
            tx.commit();
            return product.getId();
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
     * Update existing product
     */
    public boolean updateProduct(Product product) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            
            Product existing = em.find(Product.class, product.getId());
            if (existing != null) {
                existing.setName(product.getName());
                existing.setDescription(product.getDescription());
                existing.setPrice(product.getPrice());
                existing.setSize(product.getSize());
                existing.setColor(product.getColor());
                
                // Update relationships
                if (product.getCategoryId() > 0) {
                    Category category = em.find(Category.class, product.getCategoryId());
                    existing.setCategory(category);
                } else {
                    existing.setCategory(null);
                }
                
                if (product.getBrandId() > 0) {
                    Brand brand = em.find(Brand.class, product.getBrandId());
                    existing.setBrand(brand);
                } else {
                    existing.setBrand(null);
                }
                
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
     * Delete product by ID
     */
    public boolean deleteProduct(int id) {
        return delete(id);
    }

    /**
     * Search products by name
     */
    public List<Product> searchProducts(String keyword) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT DISTINCT p FROM Product p " +
                         "LEFT JOIN FETCH p.category " +
                         "LEFT JOIN FETCH p.brand " +
                         "LEFT JOIN FETCH p.images " +
                         "WHERE LOWER(p.name) LIKE LOWER(:keyword) " +
                         "ORDER BY p.createdAt DESC";
            return em.createQuery(jpql, Product.class)
                    .setParameter("keyword", "%" + keyword + "%")
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        } finally {
            em.close();
        }
    }

    /**
     * Get products by category
     */
    public List<Product> getProductsByCategory(int categoryId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT DISTINCT p FROM Product p " +
                         "LEFT JOIN FETCH p.category " +
                         "LEFT JOIN FETCH p.brand " +
                         "LEFT JOIN FETCH p.images " +
                         "WHERE p.category.id = :categoryId " +
                         "ORDER BY p.createdAt DESC";
            return em.createQuery(jpql, Product.class)
                    .setParameter("categoryId", categoryId)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        } finally {
            em.close();
        }
    }

    /**
     * Get products by brand
     */
    public List<Product> getProductsByBrand(int brandId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT DISTINCT p FROM Product p " +
                         "LEFT JOIN FETCH p.category " +
                         "LEFT JOIN FETCH p.brand " +
                         "LEFT JOIN FETCH p.images " +
                         "WHERE p.brand.id = :brandId " +
                         "ORDER BY p.createdAt DESC";
            return em.createQuery(jpql, Product.class)
                    .setParameter("brandId", brandId)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        } finally {
            em.close();
        }
    }

    /**
     * Count total products
     */
    public int getTotalProducts() {
        return (int) count();
    }

    /**
     * Add product image
     */
    public boolean addProductImage(int productId, String imageUrl, boolean isThumbnail) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            
            Product product = em.find(Product.class, productId);
            if (product != null) {
                ProductImage image = new ProductImage(product, imageUrl, isThumbnail);
                em.persist(image);
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
     * Delete all images for a product
     */
    public boolean deleteProductImages(int productId) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            
            String jpql = "DELETE FROM ProductImage pi WHERE pi.product.id = :productId";
            em.createQuery(jpql)
              .setParameter("productId", productId)
              .executeUpdate();
            
            tx.commit();
            return true;
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
}
