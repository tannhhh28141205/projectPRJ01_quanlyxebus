package model;

import java.sql.Timestamp;

public class Notification {
    private int notificationID;
    private int userID;
    private String title;
    private String message;
    private String notificationType;
    private boolean read;
    private Timestamp createdAt;

    public Notification() {}

    public Notification(int notificationID, int userID, String title, String message, String notificationType,
                        boolean read, Timestamp createdAt) {
        this.notificationID = notificationID;
        this.userID = userID;
        this.title = title;
        this.message = message;
        this.notificationType = notificationType;
        this.read = read;
        this.createdAt = createdAt;
    }

    public int getNotificationID() { return notificationID; }
    public void setNotificationID(int notificationID) { this.notificationID = notificationID; }

    public int getUserID() { return userID; }
    public void setUserID(int userID) { this.userID = userID; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getNotificationType() { return notificationType; }
    public void setNotificationType(String notificationType) { this.notificationType = notificationType; }

    public boolean isRead() { return read; }
    public void setRead(boolean read) { this.read = read; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
