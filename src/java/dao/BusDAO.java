package dao;

import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Bus;

public class BusDAO {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Bus> getAllBuses() {
        List<Bus> list = new ArrayList<>();
        String query = "SELECT * FROM Buses ORDER BY busID DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapBus(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return list;
    }

    public Bus getBusByID(int id) {
        String query = "SELECT * FROM Buses WHERE busID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return mapBus(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return null;
    }

    public void addBus(Bus b) {
        String query = "INSERT INTO Buses (licensePlate, fleetNumber, capacitySeats, capacityStanding, busType, brand, manufactureYear, lastMaintenanceDate, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, b.getLicensePlate());
            ps.setString(2, b.getFleetNumber());
            ps.setInt(3, b.getCapacitySeats());
            ps.setInt(4, b.getCapacityStanding());
            ps.setString(5, b.getBusType());
            ps.setString(6, b.getBrand());
            if (b.getManufactureYear() != null) ps.setInt(7, b.getManufactureYear()); else ps.setNull(7, java.sql.Types.INTEGER);
            ps.setDate(8, b.getLastMaintenanceDate());
            ps.setString(9, b.getStatus());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
    }

    public void updateBus(Bus b) {
        String query = "UPDATE Buses SET licensePlate = ?, fleetNumber = ?, capacitySeats = ?, capacityStanding = ?, busType = ?, brand = ?, manufactureYear = ?, lastMaintenanceDate = ?, status = ? WHERE busID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, b.getLicensePlate());
            ps.setString(2, b.getFleetNumber());
            ps.setInt(3, b.getCapacitySeats());
            ps.setInt(4, b.getCapacityStanding());
            ps.setString(5, b.getBusType());
            ps.setString(6, b.getBrand());
            if (b.getManufactureYear() != null) ps.setInt(7, b.getManufactureYear()); else ps.setNull(7, java.sql.Types.INTEGER);
            ps.setDate(8, b.getLastMaintenanceDate());
            ps.setString(9, b.getStatus());
            ps.setInt(10, b.getBusID());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
    }

    public void deleteBus(int id) {
        String query = "DELETE FROM Buses WHERE busID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
    }

    private Bus mapBus(ResultSet rs) throws Exception {
        return new Bus(
            rs.getInt("busID"),
            rs.getString("licensePlate"),
            rs.getString("fleetNumber"),
            rs.getInt("capacitySeats"),
            rs.getInt("capacityStanding"),
            rs.getString("busType"),
            rs.getString("brand"),
            rs.getObject("manufactureYear") != null ? rs.getInt("manufactureYear") : null,
            rs.getDate("lastMaintenanceDate"),
            rs.getString("status")
        );
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
