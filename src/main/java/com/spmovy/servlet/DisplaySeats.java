package com.spmovy.servlet;

import com.spmovy.beans.BookingJB;
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
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

@WebServlet("/user/DisplaySeats")
public class DisplaySeats extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession bookingsession = request.getSession(false);
        // String seatarr = request.getParameter("seatarr");
        double seatprice = Double.parseDouble(request.getParameter("seatprice"));
        int seatqty = Integer.parseInt(request.getParameter("seatqty"));
        double grandtotal = seatprice * seatqty;
        bookingsession.setAttribute("grandtotal",grandtotal);
        // bookingsession.setAttribute("seatarr",seatarr);
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/user/checkout.jsp");
        rd.forward(request,response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession bookingsession = request.getSession(false);
        ArrayList<SeatsJB> beanlist;
        try{
            int qty = Integer.parseInt(request.getParameter("qty"));
            int movieid = Integer.parseInt(request.getParameter("movieid"));
            String movietitle = request.getParameter("movietitle");
            String moviedate = request.getParameter("moviedate");
            String movietime = request.getParameter("movietime");
            String id = movieid+moviedate+movietime;
            if (bookingsession.getAttribute(id) == null) {
                BookingJB book = new BookingJB();
                book.setMovieID(movieid);
                book.setMovietitle(movietitle);
                book.setSlotdate(moviedate);
                book.setSlottime(movietime);
                book.setQty(qty);
                bookingsession.setAttribute(id,book);
            }
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
            request.setAttribute("bookingid", id);
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/user/booking.jsp");
            rd.forward(request,response);

        } catch (SQLException | ParseException e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
        }

    }
}
