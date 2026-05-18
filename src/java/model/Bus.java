package model;

import java.sql.Date;

public class Bus {
    private int busID;
    private String licensePlate;
    private String fleetNumber;
    private int capacitySeats;
    private int capacityStanding;
    private String busType;
    private String brand;
    private Integer manufactureYear;
    private Date lastMaintenanceDate;
    private String status;

    public Bus() {}

    public Bus(int busID, String licensePlate, int capacity) {
        this.busID = busID;
        this.licensePlate = licensePlate;
        this.capacitySeats = capacity;
        this.capacityStanding = 0;
        this.status = "ACTIVE";
    }

    public Bus(int busID, String licensePlate, String fleetNumber, int capacitySeats, int capacityStanding,
               String busType, String brand, Integer manufactureYear, Date lastMaintenanceDate, String status) {
        this.busID = busID;
        this.licensePlate = licensePlate;
        this.fleetNumber = fleetNumber;
        this.capacitySeats = capacitySeats;
        this.capacityStanding = capacityStanding;
        this.busType = busType;
        this.brand = brand;
        this.manufactureYear = manufactureYear;
        this.lastMaintenanceDate = lastMaintenanceDate;
        this.status = status;
    }

    public int getBusID() { return busID; }
    public void setBusID(int busID) { this.busID = busID; }

    public String getLicensePlate() { return licensePlate; }
    public void setLicensePlate(String licensePlate) { this.licensePlate = licensePlate; }

    public String getFleetNumber() { return fleetNumber; }
    public void setFleetNumber(String fleetNumber) { this.fleetNumber = fleetNumber; }

    public int getCapacitySeats() { return capacitySeats; }
    public void setCapacitySeats(int capacitySeats) { this.capacitySeats = capacitySeats; }

    public int getCapacityStanding() { return capacityStanding; }
    public void setCapacityStanding(int capacityStanding) { this.capacityStanding = capacityStanding; }

    public String getBusType() { return busType; }
    public void setBusType(String busType) { this.busType = busType; }

    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }

    public Integer getManufactureYear() { return manufactureYear; }
    public void setManufactureYear(Integer manufactureYear) { this.manufactureYear = manufactureYear; }

    public Date getLastMaintenanceDate() { return lastMaintenanceDate; }
    public void setLastMaintenanceDate(Date lastMaintenanceDate) { this.lastMaintenanceDate = lastMaintenanceDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public int getCapacity() { return capacitySeats + capacityStanding; }
    public void setCapacity(int capacity) {
        this.capacitySeats = capacity;
        this.capacityStanding = 0;
    }
}
