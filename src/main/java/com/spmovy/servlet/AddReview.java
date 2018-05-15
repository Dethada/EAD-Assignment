package com.spmovy.servlet;

import com.spmovy.DatabaseUtils;

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
        String rating = request.getParameter("rating");
        String movieid = request.getParameter("movieid");
        DatabaseUtils db = new DatabaseUtils();
//        ResultSet rs = db.executeQuery("SELECT * FROM reviews WHERE name=? and movieid = ?",name,movieid);
        try {
//            if(rs.next()){
//                response.sendRedirect("/moviedetails.jsp?movieid=" + movieid + "&review=failed");
//            }
//            else {
                db.executeUpdate("INSERT INTO reviews(movieID,reviewSentence,name,rating,createdat,ip) VALUES (?,?,?,?,?,?)",
                        movieid,
                        review,
                        name,
                        rating,
                        new Timestamp(System.currentTimeMillis()),
                        request.getRemoteAddr());
                response.sendRedirect("/moviedetails.jsp?movieid=" + movieid);
//            }
        }catch (Exception e) {
            e.printStackTrace();
        } finally {
            db.closeConnection();
        }

    }
}
