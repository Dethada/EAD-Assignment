package com.spmovy.beans;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.spmovy.DatabaseUtils;

public class MovieJBDB {
    /**
     * Get all movies in the database
     *
     * @return ArrayList of MovieJB of all movies in the database.
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
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
            movie.setRating(getMovieRating(movie.getID()));
            movielist.add(movie);
        }

        db.closeConnection();
        return movielist;
    }

    /**
     * Search for a movie via their Title
     *
     * @param title       Movie Title
     * @return ArrayList of MovieJB if matching movies are found, null if none is found
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
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
            movie.setRating(getMovieRating(movie.getID()));
            movielist.add(movie);
        }

        db.closeConnection();
        return movielist;
    }

    /**
     * Search for a movie via their Genres
     *
     * @param genre       Genre name
     * @return ArrayList of MovieJB if matching movies are found, null if none is found
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
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
            movie.setRating(getMovieRating(movie.getID()));
            movielist.add(movie);
        }

        db.closeConnection();
        return movielist;
    }

    /**
     * Search for a movie via their Actors
     *
     * @param actor       Actor name
     * @return ArrayList of MovieJB if matching movies are found, null if none is found
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
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
            movie.setRating(getMovieRating(movie.getID()));
            movielist.add(movie);
        }

        db.closeConnection();
        return movielist;
    }

    /**
     * Get the ratings of a movie based on reviews
     *
     * @param movieid       Movie ID of the target movie
     * @return The avgerage rating based on the reviews of the movie.
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
    public static float getMovieRating(int movieid) throws SQLException {
        DatabaseUtils db = new DatabaseUtils();
        ResultSet rs = db.executeQuery("SELECT avg(rating) as rating FROM spmovy.reviews where movieID=?", movieid);
        if (rs.next()) {
            float rating = rs.getFloat("rating");
            db.closeConnection();
            return rating;
        }
        db.closeConnection();
        return 0;
    }
}