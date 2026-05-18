package dao;

import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Schedule;

public class ScheduleDAO {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Schedule> getAllSchedules() {
        List<Schedule> list = new ArrayList<>();
        String query = "SELECT t.*, r.routeNumber, b.licensePlate FROM Trips t " +
                       "JOIN Routes r ON t.routeID = r.routeID " +
                       "JOIN Buses b ON t.busID = b.busID " +
                       "ORDER BY t.tripDate DESC, t.plannedStartTime DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Schedule s = mapSchedule(rs);
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return list;
    }

    public List<Schedule> getSchedulesByUser(int userID) {
        List<Schedule> list = new ArrayList<>();
        String query = "SELECT t.*, r.routeNumber, b.licensePlate FROM Trips t " +
                       "JOIN Routes r ON t.routeID = r.routeID " +
                       "JOIN Buses b ON t.busID = b.busID " +
                       "WHERE t.driverID = ? OR t.assistantID = ? " +
                       "ORDER BY t.tripDate DESC, t.plannedStartTime DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, userID);
            ps.setInt(2, userID);
            rs = ps.executeQuery();
            while (rs.next()) {
                Schedule s = mapSchedule(rs);
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return list;
    }

    public void addSchedule(Schedule s) {
        String query = "INSERT INTO Trips (routeID, busID, driverID, assistantID, direction, tripDate, plannedStartTime, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, s.getRouteID());
            ps.setInt(2, s.getBusID());
            ps.setInt(3, s.getDriverID());
            ps.setInt(4, s.getAssistantID());
            ps.setString(5, s.getDirection());
            ps.setString(6, s.getTripDate());
            ps.setTimestamp(7, s.getPlannedStartTime());
            ps.setString(8, s.getStatus());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
    }

    public void updateStatus(int tripID, String status) {
        String query = "UPDATE Trips SET status = ? WHERE tripID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, status);
            ps.setInt(2, tripID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
    }

    private Schedule mapSchedule(ResultSet rs) throws Exception {
        Schedule s = new Schedule(
            rs.getInt("tripID"),
            rs.getInt("busID"),
            rs.getInt("routeID"),
            rs.getInt("driverID"),
            rs.getInt("assistantID"),
            rs.getString("tripDate"),
            rs.getString("direction"),
            rs.getTimestamp("plannedStartTime"),
            rs.getTimestamp("plannedEndTime"),
            rs.getTimestamp("actualStartTime"),
            rs.getTimestamp("actualEndTime"),
            rs.getString("status")
        );
        s.setRouteNumber(rs.getString("routeNumber"));
        s.setLicensePlate(rs.getString("licensePlate"));
        return s;
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
