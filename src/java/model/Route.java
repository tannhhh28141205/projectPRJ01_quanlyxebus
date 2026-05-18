package model;

import java.sql.Time;
import java.math.BigDecimal;

public class Route {
    private int routeID;
    private String routeNumber;
    private String routeName;
    private String routeType;
    private Time startTime;
    private Time endTime;
    private int frequency;
    private BigDecimal distanceKM;
    private Integer durationMin;
    private BigDecimal baseFare;
    private String colorCode;
    private String polylinePoints;
    private boolean active = true;

    public Route() {}

    public Route(int routeID, String routeNumber, String routeName, Time startTime, Time endTime, int frequency) {
        this.routeID = routeID;
        this.routeNumber = routeNumber;
        this.routeName = routeName;
        this.startTime = startTime;
        this.endTime = endTime;
        this.frequency = frequency;
    }

    public Route(int routeID, String routeNumber, String routeName, String routeType, Time startTime, Time endTime,
                 int frequency, BigDecimal distanceKM, Integer durationMin, BigDecimal baseFare, String colorCode,
                 String polylinePoints, boolean active) {
        this.routeID = routeID;
        this.routeNumber = routeNumber;
        this.routeName = routeName;
        this.routeType = routeType;
        this.startTime = startTime;
        this.endTime = endTime;
        this.frequency = frequency;
        this.distanceKM = distanceKM;
        this.durationMin = durationMin;
        this.baseFare = baseFare;
        this.colorCode = colorCode;
        this.polylinePoints = polylinePoints;
        this.active = active;
    }

    public int getRouteID() { return routeID; }
    public void setRouteID(int routeID) { this.routeID = routeID; }

    public String getRouteNumber() { return routeNumber; }
    public void setRouteNumber(String routeNumber) { this.routeNumber = routeNumber; }

    public String getRouteName() { return routeName; }
    public void setRouteName(String routeName) { this.routeName = routeName; }

    public String getRouteType() { return routeType; }
    public void setRouteType(String routeType) { this.routeType = routeType; }

    public Time getStartTime() { return startTime; }
    public void setStartTime(Time startTime) { this.startTime = startTime; }

    public Time getEndTime() { return endTime; }
    public void setEndTime(Time endTime) { this.endTime = endTime; }

    public int getFrequency() { return frequency; }
    public void setFrequency(int frequency) { this.frequency = frequency; }

    public BigDecimal getDistanceKM() { return distanceKM; }
    public void setDistanceKM(BigDecimal distanceKM) { this.distanceKM = distanceKM; }

    public Integer getDurationMin() { return durationMin; }
    public void setDurationMin(Integer durationMin) { this.durationMin = durationMin; }

    public BigDecimal getBaseFare() { return baseFare; }
    public void setBaseFare(BigDecimal baseFare) { this.baseFare = baseFare; }

    public String getColorCode() { return colorCode; }
    public void setColorCode(String colorCode) { this.colorCode = colorCode; }

    public String getPolylinePoints() { return polylinePoints; }
    public void setPolylinePoints(String polylinePoints) { this.polylinePoints = polylinePoints; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }
}
