package com.spmovy.servlet;

import com.spmovy.DatabaseUtils;
import com.spmovy.Utils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

@WebServlet("/backend/AddReview")
public class AddReview extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String review = request.getParameter("review");
        int rating;
        int movieid;
        try {
            rating = Integer.parseInt(request.getParameter("rating"));
            movieid = Integer.parseInt(request.getParameter("movieid"));
        } catch (NumberFormatException e) {
            response.sendRedirect("/errors/error.html");
            return;
        }
        if (name == null || review == null || rating > 5 || rating < 1) {
            response.sendRedirect("/errors/error.html");
            return;
        }
        DatabaseUtils db = Utils.getDatabaseUtils(response);
        try {
            int updateCount = db.executeUpdate("INSERT INTO reviews(movieID,reviewSentence,name,rating,createdat,ip) VALUES (?,?,?,?,?,?)",
                    movieid,
                    review,
                    name,
                    rating,
                    new Timestamp(System.currentTimeMillis()),
                    request.getRemoteAddr());
            if (updateCount != 1) {
                response.sendRedirect("/errors/error.html");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
            return;
        } finally {
            db.closeConnection();
        }
        response.sendRedirect("/moviedetails.jsp?movieid=" + movieid);
    }
}
