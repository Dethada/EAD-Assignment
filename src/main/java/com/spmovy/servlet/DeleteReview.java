package com.spmovy.servlet;

import com.spmovy.DatabaseUtils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/backend/admin/DeleteReview")
public class DeleteReview extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        DatabaseUtils db = new DatabaseUtils();
        int movieid = Integer.parseInt(request.getParameter("movieid"));
        int reviewid = Integer.parseInt(request.getParameter("reviewid"));
        db.executeUpdate("delete from reviews where movieID=? and reviewID=?", movieid, reviewid);
        db.closeConnection();
        response.sendRedirect(request.getHeader("referer"));
    }
}
