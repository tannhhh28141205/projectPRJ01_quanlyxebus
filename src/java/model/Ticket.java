package model;

import java.sql.Date;
import java.sql.Timestamp;

public class Ticket {
    private int ticketID;
    private String ticketCode;
    private int customerID;
    private int routeID;
    private String ticketType;
    private String passengerCategory;
    private double price;
    private Timestamp validFrom;
    private Date validTo;
    private int transactionID;
    private String qrCodeString;
    private String status;
    private Timestamp createdAt;
    private String routeNumber;

    public Ticket() {}

    public Ticket(int ticketID, int customerID, int routeID, String ticketType, String category, double price, Timestamp issueDate, Date expiryDate, boolean isPaid) {
        this.ticketID = ticketID;
        this.ticketCode = null;
        this.customerID = customerID;
        this.routeID = routeID;
        this.ticketType = ticketType;
        this.passengerCategory = category;
        this.price = price;
        this.validFrom = issueDate;
        this.validTo = expiryDate;
        this.status = isPaid ? "ACTIVE" : "CANCELLED";
    }

    public Ticket(int ticketID, String ticketCode, int customerID, int routeID, int transactionID, String ticketType,
                  String passengerCategory, double price, Timestamp validFrom, Date validTo, String qrCodeString,
                  String status, Timestamp createdAt) {
        this.ticketID = ticketID;
        this.ticketCode = ticketCode;
        this.customerID = customerID;
        this.routeID = routeID;
        this.transactionID = transactionID;
        this.ticketType = ticketType;
        this.passengerCategory = passengerCategory;
        this.price = price;
        this.validFrom = validFrom;
        this.validTo = validTo;
        this.qrCodeString = qrCodeString;
        this.status = status;
        this.createdAt = createdAt;
    }

    public int getTicketID() { return ticketID; }
    public void setTicketID(int ticketID) { this.ticketID = ticketID; }

    public String getTicketCode() { return ticketCode; }
    public void setTicketCode(String ticketCode) { this.ticketCode = ticketCode; }

    public int getCustomerID() { return customerID; }
    public void setCustomerID(int customerID) { this.customerID = customerID; }

    public int getRouteID() { return routeID; }
    public void setRouteID(int routeID) { this.routeID = routeID; }

    public String getTicketType() { return ticketType; }
    public void setTicketType(String ticketType) { this.ticketType = ticketType; }

    public String getPassengerCategory() { return passengerCategory; }
    public void setPassengerCategory(String passengerCategory) { this.passengerCategory = passengerCategory; }

    public String getCategory() { return passengerCategory; }
    public void setCategory(String category) { this.passengerCategory = category; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public Timestamp getValidFrom() { return validFrom; }
    public void setValidFrom(Timestamp validFrom) { this.validFrom = validFrom; }

    public Timestamp getIssueDate() { return validFrom; }
    public void setIssueDate(Timestamp issueDate) { this.validFrom = issueDate; }

    public Date getValidTo() { return validTo; }
    public void setValidTo(Date validTo) { this.validTo = validTo; }

    public Date getExpiryDate() { return validTo; }
    public void setExpiryDate(Date expiryDate) { this.validTo = expiryDate; }

    public int getTransactionID() { return transactionID; }
    public void setTransactionID(int transactionID) { this.transactionID = transactionID; }

    public String getQrCodeString() { return qrCodeString; }
    public void setQrCodeString(String qrCodeString) { this.qrCodeString = qrCodeString; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public boolean isIsPaid() {
        return status == null || !"CANCELLED".equalsIgnoreCase(status);
    }
    public void setIsPaid(boolean isPaid) {
        this.status = isPaid ? "ACTIVE" : "CANCELLED";
    }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getRouteNumber() { return routeNumber; }
    public void setRouteNumber(String routeNumber) { this.routeNumber = routeNumber; }
}
