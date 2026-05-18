package model;

import java.math.BigDecimal;

public class Station {
    private int stationID;
    private String stationCode;
    private String stationName;
    private String address;
    private String ward;
    private String district;
    private BigDecimal latitude;
    private BigDecimal longitude;
    private boolean hasShelter;
    private boolean hasLedBoard;
    private boolean active = true;

    public Station() {}

    public Station(int stationID, String stationName, String address) {
        this.stationID = stationID;
        this.stationName = stationName;
        this.address = address;
    }

    public Station(int stationID, String stationCode, String stationName, String address, String ward,
                   String district, BigDecimal latitude, BigDecimal longitude, boolean hasShelter,
                   boolean hasLedBoard, boolean active) {
        this.stationID = stationID;
        this.stationCode = stationCode;
        this.stationName = stationName;
        this.address = address;
        this.ward = ward;
        this.district = district;
        this.latitude = latitude;
        this.longitude = longitude;
        this.hasShelter = hasShelter;
        this.hasLedBoard = hasLedBoard;
        this.active = active;
    }

    public int getStationID() { return stationID; }
    public void setStationID(int stationID) { this.stationID = stationID; }

    public String getStationCode() { return stationCode; }
    public void setStationCode(String stationCode) { this.stationCode = stationCode; }

    public String getStationName() { return stationName; }
    public void setStationName(String stationName) { this.stationName = stationName; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getWard() { return ward; }
    public void setWard(String ward) { this.ward = ward; }

    public String getDistrict() { return district; }
    public void setDistrict(String district) { this.district = district; }

    public BigDecimal getLatitude() { return latitude; }
    public void setLatitude(BigDecimal latitude) { this.latitude = latitude; }

    public BigDecimal getLongitude() { return longitude; }
    public void setLongitude(BigDecimal longitude) { this.longitude = longitude; }

    public boolean isHasShelter() { return hasShelter; }
    public void setHasShelter(boolean hasShelter) { this.hasShelter = hasShelter; }

    public boolean isHasLedBoard() { return hasLedBoard; }
    public void setHasLedBoard(boolean hasLedBoard) { this.hasLedBoard = hasLedBoard; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }
}
