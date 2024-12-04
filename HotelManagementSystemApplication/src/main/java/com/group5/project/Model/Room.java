package com.group5.project.Model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class Room {
    private String roomId;           
    private String roomName;         
    private BigDecimal actualPrice;  
    private BigDecimal discountedPrice; 
    private String features;        
    private LocalDate startDate;    
    private LocalDate endDate;       
    private int maxAdults;          
    private int maxChildren; 
    private LocalDateTime sysTime;       

    private String logId;            

 
    public Room(String roomId, String roomName, BigDecimal actualPrice, BigDecimal discountedPrice, String features,
			LocalDate startDate, LocalDate endDate, int maxAdults, int maxChildren) {
		super();
		this.roomId = roomId;
		this.roomName = roomName;
		this.actualPrice = actualPrice;
		this.discountedPrice = discountedPrice;
		this.features = features;
		this.startDate = startDate;
		this.endDate = endDate;
		this.maxAdults = maxAdults;
		this.maxChildren = maxChildren;
	}

	public Room(String roomName, String description, BigDecimal actualPrice, BigDecimal discountedPrice,
            String features, LocalDate startDate, LocalDate endDate, int maxAdults, int maxChildren,
            LocalDateTime sysTime, String logId) {
    this.roomName = roomName;
    this.actualPrice = actualPrice;
    this.discountedPrice = discountedPrice;
    this.features = features;
    this.startDate = startDate;
    this.endDate = endDate;
    this.maxAdults = maxAdults;
    this.maxChildren = maxChildren;
    this.sysTime = sysTime;
    this.logId = logId;
}

	// Getters and setters
    public String getRoomId() {
        return roomId;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public BigDecimal getActualPrice() {
        return actualPrice;
    }

    public void setActualPrice(BigDecimal actualPrice) {
        this.actualPrice = actualPrice;
    }

    public BigDecimal getDiscountedPrice() {
        return discountedPrice;
    }

    public void setDiscountedPrice(BigDecimal discountedPrice) {
        this.discountedPrice = discountedPrice;
    }

    public String getFeatures() {
        return features;
    }

    public void setFeatures(String features) {
        this.features = features;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public int getMaxAdults() {
        return maxAdults;
    }

    public void setMaxAdults(int maxAdults) {
        this.maxAdults = maxAdults;
    }

    public int getMaxChildren() {
        return maxChildren;
    }

    public void setMaxChildren(int maxChildren) {
        this.maxChildren = maxChildren;
    }

    public String getLogId() {
        return logId;
    }

    public void setLogId(String logId) {
        this.logId = logId;
    }
}
