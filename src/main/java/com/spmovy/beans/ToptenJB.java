package com.spmovy.beans;

public class ToptenJB {
    private int moviecount;
    private String movietitle;


    public ToptenJB() {

    }

    public ToptenJB(int moviecount, String movietitle) {
        this.moviecount = moviecount;
        this.movietitle = movietitle;
    }

    public int getMoviecount(){
        return moviecount;
    }


    public String getMovietitle() {
        return movietitle;
    }

    public void setMoviecount(int moviecount) {
        this.moviecount = moviecount;
    }

    public void setMovietitle(String movietitle) {
        this.movietitle = movietitle;
    }
}