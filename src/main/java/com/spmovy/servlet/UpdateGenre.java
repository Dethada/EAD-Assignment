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
        DatabaseUtils db = Utils.getDatabaseUtils(response);
        if (db == null) return;

        try {
            db.executeUpdate("UPDATE Genre SET name=?, description=? WHERE ID=?",
                    request.getParameter("name"),
                    request.getParameter("description"),
                    Integer.parseInt(request.getParameter("id")));
            response.sendRedirect(request.getHeader("referer"));
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
        } finally {
            db.closeConnection();
        }
    }
}
