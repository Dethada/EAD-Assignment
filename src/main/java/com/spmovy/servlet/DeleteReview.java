package com.spmovy.servlet;

import com.spmovy.DatabaseUtils;
import com.spmovy.Utils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/backend/admin/DeleteReview")
public class DeleteReview extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int movieid;
        int reviewid;
        try {
            movieid = Integer.parseInt(request.getParameter("movieid"));
            reviewid = Integer.parseInt(request.getParameter("reviewid"));
        } catch (NumberFormatException e) {
            response.sendRedirect("/errors/error.html");
            return;
        }
        DatabaseUtils db = Utils.getDatabaseUtils(response);
        if (db == null) return; // return if database connection failed

        try {
            int updateCount = db.executeUpdate("delete from reviews where movieID=? and reviewID=?", movieid, reviewid);
            if (updateCount != 1) { // checks if delete is successful
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

        response.sendRedirect("/admin/reviews.jsp?id=" + movieid);
    }
}
