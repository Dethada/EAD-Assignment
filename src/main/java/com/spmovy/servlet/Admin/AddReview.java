package com.spmovy.servlet.Admin;

import com.spmovy.DatabaseUtils;
import com.spmovy.Utils;
import de.triology.recaptchav2java.ReCaptcha;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/moviedetails")
public class AddReview extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

        // get reCAPTCHA request param
        String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
        boolean verify = new ReCaptcha("6Ld5D1oUAAAAAIhYveA4_E8C0chpFH_52K7g_hLm").isValid(gRecaptchaResponse);
        if (!verify) { // captcha failed
            request.setAttribute("captcha", "failed");
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/moviedetails.jsp");
            rd.forward(request, response);
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

        Date date = new Date();
        String currdate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
        try {
            int updateCount = db.executeUpdate("INSERT INTO reviews(movieID,reviewSentence,name,rating,createdat,ip) VALUES (?,?,?,?,?,?)",
                    movieid,
                    review,
                    name,
                    rating,
                    currdate,
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/moviedetails.jsp");
        rd.forward(request, response);
    }
}
