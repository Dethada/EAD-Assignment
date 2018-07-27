package com.spmovy.beans;

public class ToptenJB {
    private int moviecount;
    private String movietitle;
    private int month;
    private String year;


    public ToptenJB() {

    }

    public ToptenJB(int moviecount, String movietitle, int month, String year) {
        this.moviecount = moviecount;
        this.movietitle = movietitle;
        this.month = month;
        this.year = year;
    }

    public int getMoviecount() {
        return moviecount;
    }


    public String getMovietitle() {
        return movietitle;
    }

    public int getMonth() {
        return month;
    }

    public String getYear() {
        return year;
    }

    public void setMoviecount(int moviecount) {
        this.moviecount = moviecount;
    }

    public void setMovietitle(String movietitle) {
        this.movietitle = movietitle;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public void setYear(String year) {
        this.year = year;
    }
}