package com.spmovy.beans;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.spmovy.DatabaseUtils;

public class MovieJBDB {
    public static ArrayList<MovieJB> getAllMovies() throws SQLException {
        ArrayList<MovieJB> movielist = new ArrayList<>();
        MovieJB movie;
        DatabaseUtils db = new DatabaseUtils();

        ResultSet rs = db.executeFixedQuery("SELECT * FROM movie ORDER BY releasedate DESC");
        while (rs.next()) {
            movie = new MovieJB();
            movie.setID(rs.getInt("ID"));
            movie.setTitle(rs.getString("title"));
            movie.setReleasedate(rs.getDate("releasedate"));
            movie.setSynopsis(rs.getString("synopsis"));
            movie.setDuration(rs.getInt("duration"));
            movie.setImagepath(rs.getString("imagepath"));
            movie.setStatus(rs.getString("status"));
            movielist.add(movie);
        }

        db.closeConnection();
        return movielist;
    }

    public static ArrayList<MovieJB> searchTitle(String title) throws SQLException {
        ArrayList<MovieJB> movielist = new ArrayList<>();
        MovieJB movie;
        DatabaseUtils db = new DatabaseUtils();

        ResultSet rs = db.executeQuery("SELECT * FROM movie WHERE title LIKE ? ORDER BY releasedate DESC", "%"+title+"%");
        while (rs.next()) {
            movie = new MovieJB();
            movie.setID(rs.getInt("ID"));
            movie.setTitle(rs.getString("title"));
            movie.setReleasedate(rs.getDate("releasedate"));
            movie.setSynopsis(rs.getString("synopsis"));
            movie.setDuration(rs.getInt("duration"));
            movie.setImagepath(rs.getString("imagepath"));
            movie.setStatus(rs.getString("status"));
            movielist.add(movie);
        }

        db.closeConnection();
        return movielist;
    }

    public static ArrayList<MovieJB> searchGenre(String genre) throws SQLException {
        ArrayList<MovieJB> movielist = new ArrayList<>();
        MovieJB movie;
        DatabaseUtils db = new DatabaseUtils();

        ResultSet rs = db.executeQuery("SELECT * FROM movie LEFT JOIN MovieGenre on movie.ID = MovieGenre.movieID LEFT JOIN Genre on MovieGenre.genreID = Genre.ID WHERE name LIKE ? ORDER BY releasedate DESC", "%"+genre+"%");
        while (rs.next()) {
            movie = new MovieJB();
            movie.setID(rs.getInt("movie.ID"));
            movie.setTitle(rs.getString("title"));
            movie.setReleasedate(rs.getDate("releasedate"));
            movie.setSynopsis(rs.getString("synopsis"));
            movie.setDuration(rs.getInt("duration"));
            movie.setImagepath(rs.getString("imagepath"));
            movie.setStatus(rs.getString("status"));
            movielist.add(movie);
        }

        db.closeConnection();
        return movielist;
    }

    public static ArrayList<MovieJB> searchActor(String actor) throws SQLException {
        ArrayList<MovieJB> movielist = new ArrayList<>();
        MovieJB movie;
        DatabaseUtils db = new DatabaseUtils();

        ResultSet rs = db.executeQuery("SELECT * FROM movie LEFT JOIN MovieActor on movie.ID = MovieActor.movieID LEFT JOIN actor on MovieActor.actorID = actor.ID WHERE Name LIKE ? ORDER BY releasedate DESC", "%"+actor+"%");
        while (rs.next()) {
            movie = new MovieJB();
            movie.setID(rs.getInt("movie.ID"));
            movie.setTitle(rs.getString("title"));
            movie.setReleasedate(rs.getDate("releasedate"));
            movie.setSynopsis(rs.getString("synopsis"));
            movie.setDuration(rs.getInt("duration"));
            movie.setImagepath(rs.getString("imagepath"));
            movie.setStatus(rs.getString("status"));
            movielist.add(movie);
        }

        db.closeConnection();
        return movielist;
    }
}