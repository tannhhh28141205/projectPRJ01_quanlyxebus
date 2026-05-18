package dao;

import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Notification;

public class NotificationDAO {
    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public List<Notification> getNotificationsByUserID(int userID) {
        List<Notification> list = new ArrayList<>();
        String query = "SELECT notificationID, userID, title, message, notificationType, isRead, createdAt " +
                       "FROM Notifications WHERE userID = ? ORDER BY createdAt DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, userID);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Notification(
                    rs.getInt("notificationID"),
                    rs.getInt("userID"),
                    rs.getString("title"),
                    rs.getString("message"),
                    rs.getString("notificationType"),
                    rs.getBoolean("isRead"),
                    rs.getTimestamp("createdAt")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
