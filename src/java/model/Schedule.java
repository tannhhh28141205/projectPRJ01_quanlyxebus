package model;

import java.sql.Timestamp;
import java.sql.Date;

public class Schedule {
    private int scheduleID;
    private int tripID;
    private int busID;
    private int routeID;
    private int driverID;
    private int assistantID;
    private String tripDate;
    private String direction;
    private Timestamp plannedStartTime;
    private Timestamp plannedEndTime;
    private Timestamp actualStartTime;
    private Timestamp actualEndTime;
    private String status;

    private String routeNumber;
    private String licensePlate;

    public Schedule() {}

    public Schedule(int scheduleID, int busID, int routeID, int driverID, int assistantID, String tripDate, Timestamp actualStartTime, Timestamp actualEndTime, String status) {
        this.scheduleID = scheduleID;
        this.tripID = scheduleID;
        this.busID = busID;
        this.routeID = routeID;
        this.driverID = driverID;
        this.assistantID = assistantID;
        this.tripDate = tripDate;
        this.actualStartTime = actualStartTime;
        this.actualEndTime = actualEndTime;
        this.status = status;
    }

    public Schedule(int scheduleID, int busID, int routeID, int driverID, int assistantID, String tripDate,
                    String direction, Timestamp plannedStartTime, Timestamp plannedEndTime,
                    Timestamp actualStartTime, Timestamp actualEndTime, String status) {
        this.scheduleID = scheduleID;
        this.tripID = scheduleID;
        this.busID = busID;
        this.routeID = routeID;
        this.driverID = driverID;
        this.assistantID = assistantID;
        this.tripDate = tripDate;
        this.direction = direction;
        this.plannedStartTime = plannedStartTime;
        this.plannedEndTime = plannedEndTime;
        this.actualStartTime = actualStartTime;
        this.actualEndTime = actualEndTime;
        this.status = status;
    }

    public int getScheduleID() { return scheduleID; }
    public void setScheduleID(int scheduleID) { this.scheduleID = scheduleID; }
    public int getTripID() { return tripID; }
    public void setTripID(int tripID) { this.tripID = tripID; this.scheduleID = tripID; }
    public int getBusID() { return busID; }
    public void setBusID(int busID) { this.busID = busID; }
    public int getRouteID() { return routeID; }
    public void setRouteID(int routeID) { this.routeID = routeID; }
    public int getDriverID() { return driverID; }
    public void setDriverID(int driverID) { this.driverID = driverID; }
    public int getAssistantID() { return assistantID; }
    public void setAssistantID(int assistantID) { this.assistantID = assistantID; }
    public String getTripDate() { return tripDate; }
    public void setTripDate(String tripDate) { this.tripDate = tripDate; }

    public String getDirection() { return direction; }
    public void setDirection(String direction) { this.direction = direction; }

    public Timestamp getPlannedStartTime() { return plannedStartTime; }
    public void setPlannedStartTime(Timestamp plannedStartTime) { this.plannedStartTime = plannedStartTime; }

    public Timestamp getPlannedEndTime() { return plannedEndTime; }
    public void setPlannedEndTime(Timestamp plannedEndTime) { this.plannedEndTime = plannedEndTime; }

    public Timestamp getActualStartTime() { return actualStartTime; }
    public void setActualStartTime(Timestamp actualStartTime) { this.actualStartTime = actualStartTime; }
    public Timestamp getActualEndTime() { return actualEndTime; }
    public void setActualEndTime(Timestamp actualEndTime) { this.actualEndTime = actualEndTime; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getRouteNumber() { return routeNumber; }
    public void setRouteNumber(String routeNumber) { this.routeNumber = routeNumber; }
    public String getLicensePlate() { return licensePlate; }
    public void setLicensePlate(String licensePlate) { this.licensePlate = licensePlate; }
}
