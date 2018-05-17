package com.spmovy;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

/**
 * This class is a wrapper for DatabaseUtils.
 *
 * @Author David
 */
public class Utils {

    /**
     * This method is a wrapper to get DatabaseUtils object, handles Exceptions and redirects on error
     *
     * @param response HttpServletResponse for redirects
     * @return DatabaseUtils if connection is successful
     * @throws IOException
     */
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

    /**
     * This method is a wrapper for DatabaseUtils.callDelete, it handles Exceptions and redirects on error.
     *
     * @param request  HttpServletRequest by the user
     * @param response HttpServletResponse for redirects
     * @param db       database connection
     * @param table    table to delete the object from
     * @return true if delete is successful, false if it failed.
     * @throws IOException
     */
    public static boolean deleteID(HttpServletRequest request, HttpServletResponse response, DatabaseUtils db, String table) throws IOException {
        int id;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendRedirect("/errors/error.html");
            return false;
        }
        try {
            db.callDelete(table, id);
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
