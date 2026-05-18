package dao;

import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Station;

public class StationDAO {
    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public List<Station> getAllStations() {
        List<Station> list = new ArrayList<>();
        String query = "SELECT * FROM Stations WHERE isActive = 1 ORDER BY stationName";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Station(
                    rs.getInt("stationID"),
                    rs.getString("stationCode"),
                    rs.getString("stationName"),
                    rs.getString("address"),
                    rs.getString("ward"),
                    rs.getString("district"),
                    rs.getBigDecimal("latitude"),
                    rs.getBigDecimal("longitude"),
                    rs.getBoolean("hasShelter"),
                    rs.getBoolean("hasLedBoard"),
                    rs.getBoolean("isActive")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return list;
    }

    public void addStation(Station s) {
        String query = "INSERT INTO Stations (stationCode, stationName, address, ward, district, latitude, longitude, hasShelter, hasLedBoard, isActive) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, s.getStationCode());
            ps.setString(2, s.getStationName());
            ps.setString(3, s.getAddress());
            ps.setString(4, s.getWard());
            ps.setString(5, s.getDistrict());
            ps.setBigDecimal(6, s.getLatitude());
            ps.setBigDecimal(7, s.getLongitude());
            ps.setBoolean(8, s.isHasShelter());
            ps.setBoolean(9, s.isHasLedBoard());
            ps.setBoolean(10, s.isActive());
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
