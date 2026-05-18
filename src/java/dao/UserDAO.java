package dao;

import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.User;

public class UserDAO {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public User login(String user, String pass) {
        String query = "SELECT u.*, r.roleCode, r.roleName FROM Users u " +
                       "JOIN Roles r ON u.roleID = r.roleID " +
                       "WHERE u.username = ? AND u.passwordHash = ? AND u.isActive = 1";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, pass); // Note: In production use actual hashing
            rs = ps.executeQuery();
            if (rs.next()) {
                User u = new User(
                    rs.getInt("userID"),
                    rs.getInt("roleID"),
                    rs.getString("username"),
                    rs.getString("passwordHash"),
                    rs.getString("fullName"),
                    rs.getString("email"),
                    rs.getString("phoneNumber"),
                    rs.getDate("dateOfBirth"),
                    rs.getString("gender"),
                    rs.getString("address"),
                    rs.getString("avatarUrl"),
                    rs.getTimestamp("lastLogin"),
                    rs.getBoolean("isActive"),
                    rs.getTimestamp("createdAt")
                );
                u.setRoleCode(rs.getString("roleCode"));
                u.setRoleName(rs.getString("roleName"));
                return u;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return null;
    }

    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String query = "SELECT u.*, r.roleCode, r.roleName FROM Users u " +
                       "JOIN Roles r ON u.roleID = r.roleID";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                User u = new User(
                    rs.getInt("userID"),
                    rs.getInt("roleID"),
                    rs.getString("username"),
                    rs.getString("passwordHash"),
                    rs.getString("fullName"),
                    rs.getString("email"),
                    rs.getString("phoneNumber"),
                    rs.getDate("dateOfBirth"),
                    rs.getString("gender"),
                    rs.getString("address"),
                    rs.getString("avatarUrl"),
                    rs.getTimestamp("lastLogin"),
                    rs.getBoolean("isActive"),
                    rs.getTimestamp("createdAt")
                );
                u.setRoleCode(rs.getString("roleCode"));
                u.setRoleName(rs.getString("roleName"));
                list.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return list;
    }

    public List<User> getUsersByRole(String roleCode) {
        List<User> list = new ArrayList<>();
        String query = "SELECT u.*, r.roleCode, r.roleName FROM Users u " +
                       "JOIN Roles r ON u.roleID = r.roleID " +
                       "WHERE r.roleCode = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, roleCode);
            rs = ps.executeQuery();
            while (rs.next()) {
                User u = new User(
                    rs.getInt("userID"),
                    rs.getInt("roleID"),
                    rs.getString("username"),
                    rs.getString("passwordHash"),
                    rs.getString("fullName"),
                    rs.getString("email"),
                    rs.getString("phoneNumber"),
                    rs.getDate("dateOfBirth"),
                    rs.getString("gender"),
                    rs.getString("address"),
                    rs.getString("avatarUrl"),
                    rs.getTimestamp("lastLogin"),
                    rs.getBoolean("isActive"),
                    rs.getTimestamp("createdAt")
                );
                u.setRoleCode(rs.getString("roleCode"));
                u.setRoleName(rs.getString("roleName"));
                list.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return list;
    }

    public void addUser(User u) {
        String query = "INSERT INTO Users (roleID, username, passwordHash, fullName, email, phoneNumber, isActive) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, u.getRoleID());
            ps.setString(2, u.getUsername());
            ps.setString(3, u.getPasswordHash());
            ps.setString(4, u.getFullName());
            ps.setString(5, u.getEmail());
            ps.setString(6, u.getPhoneNumber());
            ps.setBoolean(7, u.isActive());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
    }

    private void close() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
