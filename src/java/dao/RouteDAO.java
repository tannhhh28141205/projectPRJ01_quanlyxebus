package dao;

import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Route;
import model.Station;

public class RouteDAO {
    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public List<Route> getAllRoutes() {
        List<Route> list = new ArrayList<>();
        String query = "SELECT routeID, routeNumber, routeName, routeType, startTime, endTime, frequencyMin, distanceKM, durationMin, baseFare, colorCode, polylinePoints, isActive " +
                       "FROM Routes WHERE isActive = 1 ORDER BY routeNumber";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRoute(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return list;
    }

    public Route getRouteByID(int routeID) {
        String query = "SELECT routeID, routeNumber, routeName, routeType, startTime, endTime, frequencyMin, distanceKM, durationMin, baseFare, colorCode, polylinePoints, isActive " +
                       "FROM Routes WHERE routeID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, routeID);
            rs = ps.executeQuery();
            if (rs.next()) {
                return mapRoute(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return null;
    }

    public List<Route> getRoutesByStations(int startId, int endId) {
        List<Route> list = new ArrayList<>();
        String query = "SELECT DISTINCT r.routeID, r.routeNumber, r.routeName, r.routeType, r.startTime, r.endTime, r.frequencyMin, r.distanceKM, r.durationMin, r.baseFare, r.colorCode, r.polylinePoints, r.isActive " +
                       "FROM Routes r " +
                       "JOIN Route_Stations rs1 ON r.routeID = rs1.routeID " +
                       "JOIN Route_Stations rs2 ON r.routeID = rs2.routeID AND rs1.direction = rs2.direction " +
                       "WHERE rs1.stationID = ? AND rs2.stationID = ? AND rs1.stopOrder < rs2.stopOrder AND r.isActive = 1";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, startId);
            ps.setInt(2, endId);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRoute(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return list;
    }

    public List<Station> getStationsByRoute(int routeID) {
        List<Station> list = new ArrayList<>();
        String query = "SELECT s.* FROM Stations s " +
                       "JOIN Route_Stations rs ON s.stationID = rs.stationID " +
                       "WHERE rs.routeID = ? AND rs.direction = 'OUTBOUND' " +
                       "ORDER BY rs.stopOrder";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, routeID);
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

    public void addRoute(Route r) {
        String query = "INSERT INTO Routes (routeNumber, routeName, routeType, startTime, endTime, frequencyMin, distanceKM, durationMin, baseFare, colorCode, polylinePoints, isActive) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, r.getRouteNumber());
            ps.setString(2, r.getRouteName());
            ps.setString(3, r.getRouteType());
            ps.setTime(4, r.getStartTime());
            ps.setTime(5, r.getEndTime());
            ps.setInt(6, r.getFrequency());
            ps.setBigDecimal(7, r.getDistanceKM());
            if (r.getDurationMin() != null) ps.setInt(8, r.getDurationMin()); else ps.setNull(8, java.sql.Types.INTEGER);
            ps.setBigDecimal(9, r.getBaseFare());
            ps.setString(10, r.getColorCode());
            ps.setString(11, r.getPolylinePoints());
            ps.setBoolean(12, r.isActive());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
    }

    public void updateRoute(Route r) {
        String query = "UPDATE Routes SET routeNumber = ?, routeName = ?, routeType = ?, startTime = ?, endTime = ?, frequencyMin = ?, distanceKM = ?, durationMin = ?, baseFare = ?, colorCode = ?, polylinePoints = ?, isActive = ? WHERE routeID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, r.getRouteNumber());
            ps.setString(2, r.getRouteName());
            ps.setString(3, r.getRouteType());
            ps.setTime(4, r.getStartTime());
            ps.setTime(5, r.getEndTime());
            ps.setInt(6, r.getFrequency());
            ps.setBigDecimal(7, r.getDistanceKM());
            if (r.getDurationMin() != null) ps.setInt(8, r.getDurationMin()); else ps.setNull(8, java.sql.Types.INTEGER);
            ps.setBigDecimal(9, r.getBaseFare());
            ps.setString(10, r.getColorCode());
            ps.setString(11, r.getPolylinePoints());
            ps.setBoolean(12, r.isActive());
            ps.setInt(13, r.getRouteID());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
    }

    public void deleteRoute(int id) {
        String query = "UPDATE Routes SET isActive = 0 WHERE routeID = ?";
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

    private Route mapRoute(ResultSet rs) throws Exception {
        return new Route(
            rs.getInt("routeID"),
            rs.getString("routeNumber"),
            rs.getString("routeName"),
            rs.getString("routeType"),
            rs.getTime("startTime"),
            rs.getTime("endTime"),
            rs.getInt("frequencyMin"),
            rs.getBigDecimal("distanceKM"),
            rs.getObject("durationMin") != null ? rs.getInt("durationMin") : null,
            rs.getBigDecimal("baseFare"),
            rs.getString("colorCode"),
            rs.getString("polylinePoints"),
            rs.getBoolean("isActive")
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
