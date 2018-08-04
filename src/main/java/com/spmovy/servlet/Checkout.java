package com.spmovy.servlet;

import com.spmovy.beans.BookingJB;
import com.spmovy.beans.BookingJBDB;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet("/user/Checkout")
public class Checkout extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            int userid = Integer.parseInt(request.getParameter("userid"));
            String timeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
            String concat = timeStamp + userid;
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] transactionhash = digest.digest(concat.getBytes(StandardCharsets.UTF_8));
            String transactionID = 't' + asHex(transactionhash);

            SecureRandom random = new SecureRandom();
            byte[] salt = new byte[16];
            random.nextBytes(salt);
            String saltstring = asHex(salt);


            
            ArrayList<String> allbookingids = (ArrayList<String>) session.getAttribute("allbookingids");
                for(String bookingid: allbookingids){
                    String hall_row;
                    String hall_col;
                    BookingJB bookjb = (BookingJB) session.getAttribute(bookingid);
                    int movieid = bookjb.getMovieID();
                    float price = bookjb.getPrice();
                    String moviedate = bookjb.getSlotdate();
                    String movietime = bookjb.getSlottime();
                    Date date = new SimpleDateFormat("h:mm a").parse(movietime);
                    String formattedtime = new SimpleDateFormat("HH:mm:ss").format(date);
                    String datetime = moviedate + " " + formattedtime;
                    HashSet<String> seatset = bookjb.getSeatset();

                    for (String seatno: seatset){

                        hall_row = seatno.substring(0,1);
                        hall_col = seatno.substring(1);
                        String tickettext = saltstring+moviedate+movietime+hall_row+hall_col;
                        byte[] tickethash = digest.digest(tickettext.getBytes(StandardCharsets.UTF_8));
                        String ticketID = 'i' + asHex(tickethash);

                        BookingJBDB.insertseats(hall_col,hall_row);
                        BookingJBDB.inserttransaction(transactionID,datetime,userid);
                        BookingJBDB.insertbookseats(price,ticketID,hall_col,hall_row,transactionID,movietime,moviedate,movieid,saltstring);


                    }

                }
            



        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/user/checkout.jsp");
        rd.forward(request, response);
    }

    public static String asHex (byte buf[]) {
        //Obtain a StringBuffer object
        StringBuffer strbuf = new StringBuffer(buf.length * 2);
        int i;
        for (i = 0; i < buf.length; i++) {
            if (((int) buf[i] & 0xff) < 0x10)
                strbuf.append("0");
            strbuf.append(Long.toString((int) buf[i] & 0xff, 16));
        }
        // Return result string in Hexadecimal format
        return strbuf.toString();
    }
}