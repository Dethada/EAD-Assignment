package com.spmovy.servlet;

import com.spmovy.DatabaseUtils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/backend/admin/UpdateMovieImagePath")
public class UpdateMovieImagePath extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String path = "https://cdn.spmovy.xyz/" + request.getParameter("path");
        DatabaseUtils db = new DatabaseUtils();
        db.executeUpdate("UPDATE movie SET imagepath=? WHERE ID=?", path, id);
        db.closeConnection();
        response.getWriter().write("Updated Path");
    }
}
