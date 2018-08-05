package com.spmovy.servlet.Admin;

import com.spmovy.DatabaseUtils;
import com.spmovy.Utils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/backend/admin/UpdateActor")
public class UpdateActor extends HttpServlet {

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
        if (db == null) return; // return if database connection failed
        try {
            int updateCount = db.executeUpdate("UPDATE actor SET Name=?, description=? WHERE ID=?",
                    name,
                    description,
                    id);
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
        response.sendRedirect(request.getHeader("referer"));
    }
}
