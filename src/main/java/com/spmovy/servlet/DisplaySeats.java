package com.spmovy.servlet;

import com.spmovy.beans.SeatPriceJB;
import com.spmovy.beans.SeatPriceJBDB;
import com.spmovy.beans.SeatsJB;
import com.spmovy.beans.SeatsJBDB;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

@WebServlet("/DisplaySeats")
public class DisplaySeats extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<SeatsJB> beanlist;
        try{
            int movieid = Integer.parseInt(request.getParameter("movieid"));
            String moviedate = request.getParameter("moviedate");
            String movietime = request.getParameter("movietime");
            Calendar c = Calendar.getInstance();
            c.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(moviedate));
            int dayOfWeek = c.get(Calendar.DAY_OF_WEEK);
            if (dayOfWeek < 6){
                String day = "weekday";
                SeatPriceJB pricebean = SeatPriceJBDB.getSeatPrice(day);
                request.setAttribute("seatpricebean",pricebean);
            } else{
                String day = "weekend";
                SeatPriceJB pricebean = SeatPriceJBDB.getSeatPrice(day);
                request.setAttribute("seatpricebean",pricebean);
            }

            beanlist = SeatsJBDB.getOccupiedSeats(movieid,moviedate,movietime);
            request.setAttribute("seatbeanlist",beanlist);
            RequestDispatcher rd = request.getRequestDispatcher("booking.jsp");
            rd.forward(request,response);

        } catch (SQLException | ParseException e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
