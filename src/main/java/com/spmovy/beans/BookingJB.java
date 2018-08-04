package com.spmovy.beans;

import java.util.HashSet;

public class BookingJB implements java.io.Serializable {
    private int movieID;
    private String slotdate;
    private String slottime;
    private HashSet<String> seatset;
    private float price;
    private int qty;
    private String movietitle;
    private float grandtotal;

    public BookingJB() {
    }

    public int getMovieID() {
        return movieID;
    }

    public void setMovieID(int movieID) {
        this.movieID = movieID;
    }

    public String getSlotdate() {
        return slotdate;
    }

    public void setSlotdate(String slotdate) {
        this.slotdate = slotdate;
    }

    public String getSlottime() {
        return slottime;
    }

    public void setSlottime(String slottime) {
        this.slottime = slottime;
    }

    public HashSet<String> getSeatset() {
        return seatset;
    }

    public void setSeatset(HashSet<String> seatset) {
        this.seatset = seatset;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

    public String getMovietitle() {
        return movietitle;
    }

    public void setMovietitle(String movietitle) {
        this.movietitle = movietitle;
    }

    public float getGrandtotal() {
        return grandtotal;
    }

    public void setGrandtotal(float grandtotal) {
        this.grandtotal = grandtotal;
    }
}