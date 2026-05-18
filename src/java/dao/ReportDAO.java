package dao;

import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

public class ReportDAO {
    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    private void close() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public double getTotalRevenue() {
        String query = "SELECT COALESCE(SUM(price), 0) AS total FROM Tickets WHERE status <> 'CANCELLED'";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return 0;
    }

    public Map<String, Double> getRevenueByCategory() {
        Map<String, Double> map = new HashMap<>();
        String query = "SELECT passengerCategory, COALESCE(SUM(price), 0) AS total FROM Tickets WHERE status <> 'CANCELLED' GROUP BY passengerCategory";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                map.put(rs.getString("passengerCategory"), rs.getDouble("total"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return map;
    }

    public Map<String, Integer> getTripStats() {
        Map<String, Integer> map = new HashMap<>();
        String query = "SELECT status, COUNT(*) AS count FROM Trips GROUP BY status";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                String status = rs.getString("status");
                if (status != null) {
                    map.put(status, rs.getInt("count"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return map;
    }

    public Map<String, Integer> getPopularRoutes() {
        Map<String, Integer> map = new HashMap<>();
        String query = "SELECT TOP 5 r.routeNumber, COUNT(t.ticketID) AS count " +
                       "FROM Routes r LEFT JOIN Tickets t ON r.routeID = t.routeID " +
                       "GROUP BY r.routeNumber ORDER BY COUNT(t.ticketID) DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                map.put(rs.getString("routeNumber"), rs.getInt("count"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return map;
    }
}
