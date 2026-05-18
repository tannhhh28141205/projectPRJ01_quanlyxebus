package model;

import java.sql.Timestamp;
import java.sql.Date;

public class User {
    private int userID;
    private int roleID;
    private String username;
    private String passwordHash;
    private String fullName;
    private String email;
    private String phoneNumber;
    private Date dateOfBirth;
    private String gender;
    private String address;
    private String avatarUrl;
    private Timestamp lastLogin;
    private boolean active = true;
    private Timestamp createdAt;
    
    // Joined fields
    private String roleCode;
    private String roleName;

    public User() {}

    public User(int userID, int roleID, String username, String passwordHash, String fullName, String email, String phoneNumber, boolean active) {
        this.userID = userID;
        this.roleID = roleID;
        this.username = username;
        this.passwordHash = passwordHash;
        this.fullName = fullName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.active = active;
    }

    public User(int userID, int roleID, String username, String passwordHash, String fullName, String email, String phoneNumber, Date dateOfBirth, String gender, String address, String avatarUrl, Timestamp lastLogin, boolean active, Timestamp createdAt) {
        this.userID = userID;
        this.roleID = roleID;
        this.username = username;
        this.passwordHash = passwordHash;
        this.fullName = fullName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
        this.address = address;
        this.avatarUrl = avatarUrl;
        this.lastLogin = lastLogin;
        this.active = active;
        this.createdAt = createdAt;
    }

    public int getUserID() { return userID; }
    public void setUserID(int userID) { this.userID = userID; }

    public int getRoleID() { return roleID; }
    public void setRoleID(int roleID) { this.roleID = roleID; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public Date getDateOfBirth() { return dateOfBirth; }
    public void setDateOfBirth(Date dateOfBirth) { this.dateOfBirth = dateOfBirth; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getAvatarUrl() { return avatarUrl; }
    public void setAvatarUrl(String avatarUrl) { this.avatarUrl = avatarUrl; }

    public Timestamp getLastLogin() { return lastLogin; }
    public void setLastLogin(Timestamp lastLogin) { this.lastLogin = lastLogin; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getRoleCode() { return roleCode; }
    public void setRoleCode(String roleCode) { this.roleCode = roleCode; }

    public String getRoleName() { return roleName; }
    public void setRoleName(String roleName) { this.roleName = roleName; }
    
    // Compatibility methods for old code
    public String getRole() { return roleCode; }
    public void setRole(String role) { this.roleCode = role; }
}
