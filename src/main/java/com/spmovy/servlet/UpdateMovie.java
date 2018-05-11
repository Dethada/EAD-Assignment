package com.spmovy.servlet;

import com.spmovy.DatabaseUtils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

@WebServlet("/backend/admin/UpdateMovie")
public class UpdateMovie extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String releasedate = request.getParameter("releasedate");
        String synopsis = request.getParameter("synopsis");
        int duration = Integer.parseInt(request.getParameter("duration"));
        String imagepath = request.getParameter("imagepath");
        String status = request.getParameter("status");
        String[] genres = request.getParameterValues("genre");
        String[] actors = request.getParameterValues("actor");
        // redirect if no genre or actor is provided
        if (genres == null || actors == null) {
            response.sendRedirect(request.getHeader("referer"));
            return;
        }
        DatabaseUtils db = new DatabaseUtils();
        db.executeUpdate("UPDATE movie SET title=?, releasedate=?, synopsis=?, duration=?, imagepath=?, status=? WHERE ID=?",
                title,
                Date.valueOf(releasedate),
                synopsis,
                duration,
                imagepath,
                status,
                id);
        Connection connection = db.getConnection();
        ResultSet tmpRS;
        try {
            // get movie id
            ResultSet movieIDResult = db.executeQuery("SELECT * FROM movie WHERE title=? and releasedate=?",
                    title,
                    java.sql.Date.valueOf(releasedate));
            movieIDResult.next();
            int movieid = movieIDResult.getInt("ID");
            // get list of current genres/actors
            ArrayList<Integer> currentGenres = getcList(db.executeQuery("SELECT * FROM MovieGenre WHERE movieID=?", movieid));
            ArrayList<Integer> currentActors = getcList(db.executeQuery("SELECT * FROM MovieActor WHERE movieID=?", movieid));
            // prepare prepared statements
            PreparedStatement getGenreID = connection.prepareStatement("SELECT * FROM Genre WHERE name=?");
            PreparedStatement getActorID = connection.prepareStatement("SELECT * FROM actor WHERE name=?");
            PreparedStatement insertGenre = connection.prepareStatement("insert into MovieGenre values (?, ?)");
            PreparedStatement insertActor = connection.prepareStatement("insert into MovieActor values (?, ?)");
            PreparedStatement deleteGenre = connection.prepareStatement("DELETE FROM MovieGenre WHERE movieID=? AND genreID=?");
            PreparedStatement deleteActor = connection.prepareStatement("DELETE FROM MovieActor WHERE movieID=? AND actorID=?");
            insertGenre.setInt(1, movieid);
            insertActor.setInt(1, movieid);
            deleteGenre.setInt(1, movieid);
            deleteActor.setInt(1, movieid);
            updateManytoMany(genres, currentGenres, getGenreID, insertGenre, deleteGenre);
            updateManytoMany(actors, currentActors, getActorID, insertActor, deleteActor);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeConnection();
        }
        response.sendRedirect(request.getHeader("referer"));
    }

    private void updateManytoMany(String[] list, ArrayList<Integer> cList, PreparedStatement getID, PreparedStatement insertStmt, PreparedStatement deleteStmt) throws SQLException {
        // add actors/genres for movie
        for(String actor : list) {
            getID.setString(1, actor);
            ResultSet rs = getID.executeQuery();
            if (rs.next()) {
                int tmpID = rs.getInt("ID");
                if (cList.contains(tmpID)) {
                    cList.remove(Integer.valueOf(tmpID));
                } else {
                    insertStmt.setInt(2, tmpID);
                    try {
                        insertStmt.executeUpdate();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        // delete actors/genres for movie
        for(int deleteid : cList) {
            deleteStmt.setInt(2, deleteid);
            deleteStmt.executeUpdate();
        }
    }

    private ArrayList<Integer> getcList(ResultSet rs) throws SQLException {
        // get list of current actors
        ArrayList<Integer> cList = new ArrayList();
        ArrayList<Integer> currentActors = new ArrayList();
        while (rs.next()) {
            cList.add(rs.getInt(2));
        }
        return cList;
    }
}
