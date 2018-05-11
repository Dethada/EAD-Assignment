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
        int id = Integer.parseInt(request.getParameter("id"));
        String path = "https://cdn.spmovy.xyz/" + request.getParameter("path");
        DatabaseUtils db = Utils.getDatabaseUtils(response);
        if (db == null) return;
        try {
            db.executeUpdate("UPDATE movie SET imagepath=? WHERE ID=?", path, id);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeConnection();
        }
        response.getWriter().write("Updated Path");
    }
}
