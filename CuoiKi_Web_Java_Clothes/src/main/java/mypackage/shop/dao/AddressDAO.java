/*
 * AddressDAO sử dụng JPA EntityManager
 */
package mypackage.shop.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import mypackage.shop.model.Address;
import mypackage.shop.model.User;

import java.util.List;

/**
 * Data Access Object for Address operations using JPA
 * @author PC
 */
public class AddressDAO extends GenericDAO<Address> {
    
    public AddressDAO() {
        super(Address.class);
    }
    
    /**
     * Get all addresses for a user
     * @param userId User ID
     * @return List of addresses
     */
    public List<Address> getAddressesByUserId(int userId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT a FROM Address a WHERE a.user.id = :userId ORDER BY a.isDefault DESC, a.id DESC";
            return em.createQuery(jpql, Address.class)
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
     * Get address by ID
     * @param addressId Address ID
     * @return Address object or null
     */
    public Address getAddressById(int addressId) {
        return findById(addressId);
    }
    
    /**
     * Get default address for a user
     * @param userId User ID
     * @return Default address or null
     */
    public Address getDefaultAddress(int userId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT a FROM Address a WHERE a.user.id = :userId AND a.isDefault = true";
            List<Address> results = em.createQuery(jpql, Address.class)
                                      .setParameter("userId", userId)
                                      .setMaxResults(1)
                                      .getResultList();
            return results.isEmpty() ? null : results.get(0);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }
    
    /**
     * Add new address
     * @param address Address object
     * @return true if successful
     */
    public boolean addAddress(Address address) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            
            // If this is the first address or marked as default, clear other defaults first
            if (address.isDefault()) {
                clearDefaultAddress(em, address.getUserId());
            }
            
            // Get user entity and set relationship
            User user = em.find(User.class, address.getUserId());
            address.setUser(user);
            
            em.persist(address);
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
    
    /**
     * Update address
     * @param address Address object with updated info
     * @return true if successful
     */
    public boolean updateAddress(Address address) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            
            // If setting as default, clear other defaults first
            if (address.isDefault()) {
                clearDefaultAddress(em, address.getUserId());
            }
            
            Address existing = em.find(Address.class, address.getId());
            if (existing != null) {
                existing.setRecipientName(address.getRecipientName());
                existing.setPhone(address.getPhone());
                existing.setStreet(address.getStreet());
                existing.setCity(address.getCity());
                existing.setDefault(address.isDefault());
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
     * Delete address
     * @param addressId Address ID
     * @return true if successful
     */
    public boolean deleteAddress(int addressId) {
        return delete(addressId);
    }
    
    /**
     * Set address as default
     * @param addressId Address ID
     * @param userId User ID
     * @return true if successful
     */
    public boolean setDefaultAddress(int addressId, int userId) {
        EntityManager em = getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            
            // Clear current default
            clearDefaultAddress(em, userId);
            
            // Set new default
            Address address = em.find(Address.class, addressId);
            if (address != null && address.getUserId() == userId) {
                address.setDefault(true);
                em.merge(address);
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
     * Clear default flag for all addresses of a user
     */
    private void clearDefaultAddress(EntityManager em, int userId) {
        String jpql = "UPDATE Address a SET a.isDefault = false WHERE a.user.id = :userId";
        em.createQuery(jpql)
          .setParameter("userId", userId)
          .executeUpdate();
    }
    
    /**
     * Count addresses for a user
     * @param userId User ID
     * @return Number of addresses
     */
    public int countAddresses(int userId) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT COUNT(a) FROM Address a WHERE a.user.id = :userId";
            Long count = em.createQuery(jpql, Long.class)
                          .setParameter("userId", userId)
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
