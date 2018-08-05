package com.spmovy.servlet;

import com.spmovy.DatabaseUtils;
import com.spmovy.Utils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

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
        if (name.length() > 70 || review.length() > 65535) {
            response.sendRedirect("/errors/error.html");
            return;
        }
        DatabaseUtils db = Utils.getDatabaseUtils(response);
        if (db == null) return; // return if database connection failed
        String ip;
        if (request.getHeader("x-real-ip") != null) {
            ip = request.getHeader("x-real-ip");
        } else if (request.getHeader("x-forwarded-for") != null) {
            ip = request.getHeader("x-forwarded-for");
        } else {
            ip = request.getRemoteAddr();
        }
        try {
            int updateCount = db.executeUpdate("INSERT INTO reviews(movieID,reviewSentence,name,rating,createdat,ip) VALUES (?,?,?,?,NOW(),?)",
                    movieid,
                    review,
                    name,
                    rating,
                    ip);
            if (updateCount != 1) { // checks if insert is successful
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
