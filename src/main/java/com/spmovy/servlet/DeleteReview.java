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
        int movieid = Integer.parseInt(request.getParameter("movieid"));
        int reviewid = Integer.parseInt(request.getParameter("reviewid"));
        DatabaseUtils db = Utils.getDatabaseUtils(response);
        if (db == null) return;
        try {
            db.executeUpdate("delete from reviews where movieID=? and reviewID=?", movieid, reviewid);
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
