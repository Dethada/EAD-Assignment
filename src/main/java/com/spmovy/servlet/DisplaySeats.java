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
import java.util.Date;

@WebServlet("/user/DisplaySeats")
public class DisplaySeats extends HttpServlet {
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

                Calendar c = Calendar.getInstance();
                c.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(moviedate));
                SeatPriceJB pricebean = SeatPriceJBDB.getSeatPrice((c.get(Calendar.DAY_OF_WEEK) < 6) ? "weekday" : "weekend");
                float price = pricebean.getPrice();
                book.setPrice(price);
                book.setGrandtotal(price * qty);

                bookingsession.setAttribute(id,book);
                ArrayList<String> allbookingids = (ArrayList<String>) bookingsession.getAttribute("allbookingids");
                if (allbookingids == null) {
                    allbookingids = new ArrayList<>();
                    allbookingids.add(id);
                    bookingsession.setAttribute("allbookingids",allbookingids);
                } else {
                    allbookingids.add(id);
                }
            } else {
                BookingJB currentbook = (BookingJB) bookingsession.getAttribute(id);
                currentbook.setQty(qty);
                currentbook.setGrandtotal(currentbook.getPrice() * qty);
            }
            Date date = new SimpleDateFormat("h:mm a").parse(movietime);
            String formattedtime = new SimpleDateFormat("HH:mm:ss").format(date);
            beanlist = SeatsJBDB.getOccupiedSeats(movieid,moviedate,formattedtime);

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
