package com.spmovy.beans;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.spmovy.DatabaseUtils;

public class MovieJBDB {
    /**
     * Convenience method for Movie bean initialization
     *
     * @param rs        Result Set of a movie query
     * @return ArrayList of MovieJB.
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
    private static ArrayList<MovieJB> initMovie(ResultSet rs) throws SQLException {
        ArrayList<MovieJB> movielist = new ArrayList<>();
        MovieJB movie;
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
        return movielist;
    }

    /**
     * Get all movies in the database
     *
     * @return ArrayList of MovieJB of all movies in the database.
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
    public static ArrayList<MovieJB> getAllMovies() throws SQLException {
        ArrayList<MovieJB> movielist;
        DatabaseUtils db = new DatabaseUtils();

        ResultSet rs = db.executeFixedQuery("SELECT * FROM movie ORDER BY releasedate DESC");
        movielist = initMovie(rs);

        db.closeConnection();
        return movielist;
    }

    /**
     * Search for a movie via their Title
     *
     * @param title Movie Title
     * @return ArrayList of MovieJB if matching movies are found, null if none is found
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
    public static ArrayList<MovieJB> searchTitle(String title) throws SQLException {
        ArrayList<MovieJB> movielist;
        DatabaseUtils db = new DatabaseUtils();

        ResultSet rs = db.executeQuery("SELECT * FROM movie WHERE title LIKE ? ORDER BY releasedate DESC", "%" + title + "%");
        movielist = initMovie(rs);

        db.closeConnection();
        return movielist;
    }

    /**
     * Search for a movie via their Genres
     *
     * @param genre Genre name
     * @return ArrayList of MovieJB if matching movies are found, null if none is found
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
    public static ArrayList<MovieJB> searchGenre(String genre) throws SQLException {
        ArrayList<MovieJB> movielist;
        DatabaseUtils db = new DatabaseUtils();

        ResultSet rs = db.executeQuery("SELECT m.ID, m.title, m.releasedate, m.synopsis, m.duration, " +
                "m.imagepath, m.status FROM movie m LEFT JOIN MovieGenre on m.ID = MovieGenre.movieID " +
                "LEFT JOIN Genre on MovieGenre.genreID = Genre.ID WHERE name LIKE ? ORDER BY releasedate DESC;", "%" + genre + "%");
        movielist = initMovie(rs);

        db.closeConnection();
        return movielist;
    }

    /**
     * Search for a movie via their Actors
     *
     * @param actor Actor name
     * @return ArrayList of MovieJB if matching movies are found, null if none is found
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
    public static ArrayList<MovieJB> searchActor(String actor) throws SQLException {
        ArrayList<MovieJB> movielist;
        DatabaseUtils db = new DatabaseUtils();

        ResultSet rs = db.executeQuery("SELECT m.ID, m.title, m.releasedate, m.synopsis, m.duration, " +
                "m.imagepath, m.status FROM movie m LEFT JOIN MovieActor on m.ID = MovieActor.movieID " +
                "LEFT JOIN actor on MovieActor.actorID = actor.ID WHERE Name LIKE ? ORDER BY releasedate DESC;", "%" + actor + "%");
        movielist = initMovie(rs);

        db.closeConnection();
        return movielist;
    }

    /**
     * Get the ratings of a movie based on reviews
     *
     * @param movieid Movie ID of the target movie
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