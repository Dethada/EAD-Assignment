package com.spmovy.servlet;

import com.spmovy.DatabaseUtils;
import com.spmovy.Utils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/backend/admin/AddActor")
public class AddActor extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        DatabaseUtils db = Utils.getDatabaseUtils(response);
        if (db == null) return;
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        if (name == null || description == null) {
            response.sendRedirect("/errors/error.html");
            return;
        }
        try {
            db.executeUpdate("INSERT INTO actor(Name, description) VALUES (?, ?)", name, description);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
            return;
        } finally {
            db.closeConnection();
        }
        if (request.getHeader("referer") == null) {
            response.sendRedirect("/admin/actors.jsp");
        } else {
            response.sendRedirect(request.getHeader("referer"));
        }
    }
}
