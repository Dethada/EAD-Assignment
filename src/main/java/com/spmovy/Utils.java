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
        try {
            db.callDelete(request.getParameter("table"), Integer.parseInt(request.getParameter("id")));
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
