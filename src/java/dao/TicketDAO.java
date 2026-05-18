package dao;

import context.DBContext;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import model.Ticket;

public class TicketDAO {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public void addTicket(Ticket t) {
        String query = "INSERT INTO Tickets (ticketCode, customerID, routeID, transactionID, ticketType, passengerCategory, price, validFrom, validTo, qrCodeString, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            String ticketCode = t.getTicketCode() != null ? t.getTicketCode() : "TK-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            ps.setString(1, ticketCode);
            ps.setInt(2, t.getCustomerID());
            if (t.getRouteID() <= 0) ps.setNull(3, java.sql.Types.INTEGER); else ps.setInt(3, t.getRouteID());
            if (t.getTransactionID() <= 0) ps.setNull(4, java.sql.Types.INTEGER); else ps.setInt(4, t.getTransactionID());
            ps.setString(5, t.getTicketType());
            ps.setString(6, t.getPassengerCategory());
            ps.setDouble(7, t.getPrice());
            ps.setTimestamp(8, t.getValidFrom() != null ? t.getValidFrom() : new Timestamp(System.currentTimeMillis()));
            ps.setDate(9, t.getValidTo() != null ? t.getValidTo() : new Date(System.currentTimeMillis()));
            ps.setString(10, t.getQrCodeString() != null ? t.getQrCodeString() : ticketCode);
            ps.setString(11, t.getStatus() != null ? t.getStatus() : "ACTIVE");
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
    }

    public Ticket getTicketByID(int id) {
        String query = "SELECT t.*, r.routeNumber FROM Tickets t LEFT JOIN Routes r ON t.routeID = r.routeID WHERE t.ticketID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                Ticket t = mapTicket(rs);
                return t;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return null;
    }

    public List<Ticket> getTicketsByCustomerID(int customerID) {
        List<Ticket> list = new ArrayList<>();
        String query = "SELECT t.*, r.routeNumber FROM Tickets t LEFT JOIN Routes r ON t.routeID = r.routeID WHERE t.customerID = ? ORDER BY t.createdAt DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, customerID);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapTicket(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return list;
    }

    private Ticket mapTicket(ResultSet rs) throws Exception {
        Ticket t = new Ticket(
            rs.getInt("ticketID"),
            rs.getString("ticketCode"),
            rs.getInt("customerID"),
            rs.getInt("routeID"),
            rs.getObject("transactionID") != null ? rs.getInt("transactionID") : 0,
            rs.getString("ticketType"),
            rs.getString("passengerCategory"),
            rs.getDouble("price"),
            rs.getTimestamp("validFrom"),
            rs.getDate("validTo"),
            rs.getString("qrCodeString"),
            rs.getString("status"),
            rs.getTimestamp("createdAt")
        );
        t.setRouteNumber(rs.getString("routeNumber"));
        return t;
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
