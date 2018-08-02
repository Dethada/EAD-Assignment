package com.spmovy.beans;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class UserTransactionJB implements java.io.Serializable {
    private String ID;
    private Timestamp at;
    private String ticketID;
    private float price;
    private String hall_row;
    private String hall_column;
    private Date moviedate;
    private Time movietime;
    private String movietitle;

    public UserTransactionJB() {
    }

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public Timestamp getAt() {
        return at;
    }

    public void setAt(Timestamp at) {
        this.at = at;
    }

    public String getTicketID() {
        return ticketID;
    }

    public void setTicketID(String ticketID) {
        this.ticketID = ticketID;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getHall_row() {
        return hall_row;
    }

    public void setHall_row(String hall_row) {
        this.hall_row = hall_row;
    }

    public String getHall_column() {
        return hall_column;
    }

    public void setHall_column(String hall_column) {
        this.hall_column = hall_column;
    }

    public Date getMoviedate() {
        return moviedate;
    }

    public void setMoviedate(Date moviedate) {
        this.moviedate = moviedate;
    }

    public Time getMovietime() {
        return movietime;
    }

    public void setMovietime(Time movietime) {
        this.movietime = movietime;
    }

    public String getMovietitle() {
        return movietitle;
    }

    public void setMovietitle(String movietitle) {
        this.movietitle = movietitle;
    }
}