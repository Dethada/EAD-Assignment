package com.spmovy.servlet.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.spmovy.beans.BookingJB;

import java.util.HashSet;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/user/SelectSeat")
public class SelectSeat extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String action = request.getParameter("action");
        String seat = request.getParameter("seat");
        String bookingid = request.getParameter("bookingid");
        String msg;
        boolean success = true;
        if (action == null || seat == null || bookingid == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        } else if (!action.equals("add") && !action.equals("del")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        HttpSession session = request.getSession();
        BookingJB bookjb = (BookingJB) session.getAttribute(bookingid);
        HashSet<String> seatset = bookjb.getSeatset();
        if (seatset == null) {
            seatset = new HashSet<>();
            bookjb.setSeatset(seatset);
        }
        if (action.equals("add")) {
            if (seatset.add(seat)) {
                msg = "Added seat " + seat;
            } else {
                msg = "Failed to add seat";
                success = false;
            }
        } else {
            if (seatset.remove(seat)) {
                msg = "Removed seat " + seat;
            } else {
                msg = "Failed to remove seat";
                success = false;
            }
        }
        if (success) {
            response.setStatus(HttpServletResponse.SC_CREATED);
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
        response.setContentType("text/plain");
        PrintWriter writer = response.getWriter();
        writer.append(msg);
        writer.flush();
    }
}
