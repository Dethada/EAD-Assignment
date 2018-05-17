package com.spmovy.servlet;

import com.spmovy.DatabaseUtils;
import com.spmovy.Utils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/backend/admin/UpdateMovieImagePath")
public class UpdateMovieImagePath extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendRedirect("/errors/error.html");
            return;
        }
        if (request.getParameter("path") == null) {
            response.sendRedirect("/errors/error.html");
            return;
        }
        String path = "https://cdn.spmovy.xyz/" + request.getParameter("path");
        DatabaseUtils db = Utils.getDatabaseUtils(response);
        if (db == null) return; // return if database connection failed
        try {
            int updateCount = db.executeUpdate("UPDATE movie SET imagepath=? WHERE ID=?", path, id);
            if (updateCount != 1) { // checks if update is successful
                response.sendRedirect("/errors/error.html");
                return;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
            return;
        } finally {
            db.closeConnection();
        }
        response.getWriter().write("Updated Movie Image Path");
    }
}
