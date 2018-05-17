package com.spmovy.servlet;

import com.spmovy.DatabaseUtils;
import com.spmovy.Utils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

@WebServlet("/backend/admin/AddMovie")
public class AddMovie extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // get parameters
        String title = request.getParameter("title");
        String releasedate = request.getParameter("releasedate");
        String synopsis = request.getParameter("synopsis");
        int duration;
        try {
            duration = Integer.parseInt(request.getParameter("duration"));
        } catch (NumberFormatException e) {
            response.sendRedirect("/errors/error.html");
            return;
        }
        String imagepath = request.getParameter("imagepath");
        String status = request.getParameter("status");
        String[] genres = request.getParameterValues("genre");
        String[] actors = request.getParameterValues("actor");
        // redirect if no genre or actor is provided
        if (genres == null || actors == null) {
            if (request.getHeader("referer") == null) {
                response.sendRedirect("/errors/error.html");
            } else {
                response.sendRedirect(request.getHeader("referer"));
            }
            return;
        }
        DatabaseUtils db = Utils.getDatabaseUtils(response);
        if (db == null) return;
        try {
            int updateCount = db.executeUpdate("INSERT INTO movie(title,releasedate,synopsis,duration,imagepath,status) VALUES (?, ?, ?, ?, ?, ?)",
                    title,
                    java.sql.Date.valueOf(releasedate),
                    synopsis,
                    duration,
                    imagepath,
                    status);
            if (updateCount != 1) {
                response.sendRedirect("/errors/error.html");
                return;
            }

            Connection connection = db.getConnection();

            ResultSet movieIDResult = db.executeQuery("SELECT * FROM movie WHERE title=? and releasedate=?",
                    title,
                    java.sql.Date.valueOf(releasedate));
            movieIDResult.next();
            int movieid = movieIDResult.getInt("ID");
            PreparedStatement getGenreID = connection.prepareStatement("SELECT * FROM Genre WHERE name=?");
            PreparedStatement getActorID = connection.prepareStatement("SELECT * FROM actor WHERE name=?");
            PreparedStatement insertGenre = connection.prepareStatement("insert into MovieGenre values (?, ?)");
            PreparedStatement insertActor = connection.prepareStatement("insert into MovieActor values (?, ?)");
            insertGenre.setInt(1, movieid);
            insertActor.setInt(1, movieid);
            addManytoMany(genres, getGenreID, insertGenre); // add genres for movie
            addManytoMany(actors, getActorID, insertActor); // add actors for movie
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
            return;
        } finally {
            db.closeConnection();
        }
        response.sendRedirect("/admin/movies.jsp");
    }

    private void addManytoMany(String[] list, PreparedStatement getID, PreparedStatement insertStmt) throws SQLException {
        for (String item : list) {
            getID.setString(1, item);
            ResultSet rs = getID.executeQuery();
            if (rs.next()) {
                insertStmt.setInt(2, rs.getInt("ID"));
                insertStmt.executeUpdate();
            }
        }
    }
}
