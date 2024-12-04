package com.group5.project.Model;

import java.util.Date;

public class Booking {
	    private String bookingId;
	    private String roomType;
	    private Date checkInDate;
	    private Date checkOutDate;
	    private double totalPrice;
	    private String status;
	    
		public String getStatus() {
			return status;
		}
		public void setStatus(String status) {
			this.status = status;
		}
		public String getBookingId() {
			return bookingId;
		}
		public void setBookingId(String bookingId) {
			this.bookingId = bookingId;
		}
		public String getRoomType() {
			return roomType;
		}
		public void setRoomType(String roomType) {
			this.roomType = roomType;
		}
		public Date getCheckInDate() {
			return checkInDate;
		}
		public void setCheckInDate(Date checkInDate) {
			this.checkInDate = checkInDate;
		}
		public Date getCheckOutDate() {
			return checkOutDate;
		}
		public void setCheckOutDate(Date checkOutDate) {
			this.checkOutDate = checkOutDate;
		}
		public double getTotalPrice() {
			return totalPrice;
		}
		public void setTotalPrice(double totalPrice) {
			this.totalPrice = totalPrice;
		}

}
