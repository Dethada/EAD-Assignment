package com.spmovy;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class Utils {

    public static DatabaseUtils getDatabaseUtils(HttpServletResponse response) throws IOException {
        DatabaseUtils db;
        try {
            db = new DatabaseUtils();
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
            return null;
        }
        return db;
    }

    public static boolean deleteID(HttpServletRequest request, HttpServletResponse response, DatabaseUtils db) throws IOException {
        int id;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendRedirect("/errors/error.html");
            return false;
        }
        if (request.getParameter("table") == null) {
            response.sendRedirect("/errors/error.html");
            return false;
        }
        try {
            db.callDelete(request.getParameter("table"), id);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
            return false;
        } finally {
            db.closeConnection();
        }
        return true;
    }
}
