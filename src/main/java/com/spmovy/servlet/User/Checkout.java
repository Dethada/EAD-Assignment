package com.spmovy.servlet.User;

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
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;

import com.spmovy.beans.UserJB;

@WebServlet("/user/Checkout")
public class Checkout extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        ArrayList<String> allbookingids = (ArrayList<String>) session.getAttribute("allbookingids");
        String message = "";

        // get user id
        UserJB user = (UserJB) session.getAttribute("user");
        int userid = user.getID();

        // get timestamp
        String timeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
        String concat = timeStamp + userid;
        int ticketcount = 0;
        try {
            // generate SHA256 hash for transaction ID
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            // prepend 't' for transaction IDs
            String transactionID = 't' + asHex(digest.digest(concat.getBytes(StandardCharsets.UTF_8)));

            // generate salt
            SecureRandom random = new SecureRandom();
            byte[] salt = new byte[16];
            random.nextBytes(salt);
            String saltstring = asHex(salt);

            boolean success = true;

            // try to create new transaction
            try {
                if (!BookingJBDB.inserttransaction(transactionID, timeStamp, userid)) {
                    request.setAttribute("message", "Transaction Failed");
                    clearBookings(session, allbookingids);
                    RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/user/transactionStatus.jsp");
                    rd.forward(request, response);
                    return;
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("/errors/error.html");
                return;
            }

            for (String bookingid : allbookingids) {
                BookingJB bookjb = (BookingJB) session.getAttribute(bookingid);
                int movieid = bookjb.getMovieID();
                float price = bookjb.getPrice();
                String moviedate = bookjb.getSlotdate();
                String movietime = bookjb.getSlottime();
                Date date = new SimpleDateFormat("h:mm a").parse(movietime);
                String formattedtime = new SimpleDateFormat("HH:mm:ss").format(date);
                HashSet<String> seatset = bookjb.getSeatset();

                for (String seatno : seatset) {

                    String hall_row = seatno.substring(0, 1);
                    String hall_col = seatno.substring(1);
                    String tickettext = saltstring + moviedate + movietime + hall_row + hall_col;
                    // prepend 'i' for ticket IDs
                    String ticketID = 'i' + asHex(digest.digest(tickettext.getBytes(StandardCharsets.UTF_8)));

                    try {
                        // check if ticket is already purchased by another user.
                        if (!BookingJBDB.ticketExist(hall_col, hall_row, formattedtime, moviedate, movieid)) {
                            if (!BookingJBDB.insertbookseats(price, ticketID, hall_col, hall_row, transactionID, formattedtime, moviedate, movieid, saltstring)) {
                                message += "Purchase for " + bookjb.getMovietitle() + " " + moviedate + " " + movietime + " " + seatno + " Failed<br>";
                                success = false;
                            } else ticketcount += 1;
                        } else {
                            message += "Purchase for " + bookjb.getMovietitle() + " " + moviedate + " " + movietime + " Seat " + seatno + " Failed (Seat booked by another customer.)<br>";
                            success = false;
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                        message += "Purchase for " + bookjb.getMovietitle() + " " + moviedate + " " + movietime + " " + seatno + " Failed<br>";
                        success = false;
                        request.setAttribute("status", "failed");
                    }
                }
                session.removeAttribute(bookingid);
            }
            session.removeAttribute("allbookingids");

            // if no tickets are successfully purchased, remove the transaction.
            if (ticketcount == 0) {
                try {
                    BookingJBDB.deleteTransaction(transactionID);
                } catch (SQLException e) {
                    e.printStackTrace();
                    response.sendRedirect("/errors/error.html");
                    return;
                }
            }

            // set messages to be displayed to the user
            if (success) {
                message = "Transcation completed";
                request.setAttribute("status", "success");
            } else {
                request.setAttribute("status", "failed");
            }
            request.setAttribute("message", message);
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/user/transactionStatus.jsp");
            rd.forward(request, response);
        } catch (NoSuchAlgorithmException | ParseException e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/user/checkout.jsp");
        rd.forward(request, response);
    }

    /**
     * Search for a user via their contact number
     *
     * @param session User's session
     * @param allbookingids ArrayList of all the booking IDs
     * @return UserJB if user is found, null if user is not found
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
    private static void clearBookings(HttpSession session, ArrayList<String> allbookingids) {
        for (String bookingid : allbookingids) {
            session.removeAttribute(bookingid);
        }
        session.removeAttribute("allbookingids");
    }

    /**
     * This method converts bytes to hex string
     *
     * @param buf The bytes to be converted to hex string
     * @return String - hex string of the bytes
     */
    private static String asHex(byte buf[]) {
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