package com.spmovy.servlet;

import com.spmovy.DatabaseUtils;
import com.spmovy.Utils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/backend/admin/UpdateGenre")
public class UpdateGenre extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        int id;
        if (name == null || description == null) {
            response.sendRedirect("/errors/error.html");
            return;
        }
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendRedirect("/errors/error.html");
            return;
        }
        DatabaseUtils db = Utils.getDatabaseUtils(response);
        if (db == null) return;

        try {
            int updateCount = db.executeUpdate("UPDATE Genre SET name=?, description=? WHERE ID=?",
                    name,
                    description,
                    id);
            if (updateCount != 1) {
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
        response.sendRedirect(request.getHeader("referer"));
    }
}
