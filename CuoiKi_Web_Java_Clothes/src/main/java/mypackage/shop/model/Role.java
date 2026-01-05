/*
 * Role - Định nghĩa các quyền: Admin, Staff, Customer
 */
package mypackage.shop.model;

/**
 * Role constants matching ENUM in database
 * @author PC
 */
public class Role {
    public static final String ADMIN = "ADMIN";
    public static final String STAFF = "STAFF";
    public static final String CUSTOMER = "CUSTOMER";
    
    // Không cần instantiate
    private Role() {}
}
