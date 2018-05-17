package com.spmovy.servlet;

import com.spmovy.DatabaseUtils;
import com.spmovy.Utils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;

@WebServlet("/backend/admin/AddTimeslot")
public class AddTimeslot extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id;
        Date date;
        Time time;
        try {
            id = Integer.parseInt(request.getParameter("id"));
            date = Date.valueOf(request.getParameter("date"));
            time = Time.valueOf(request.getParameter("time") + ":00");
        } catch (Exception e) { // catch all format exceptions
            response.sendRedirect("/errors/error.html");
            return;
        }
        DatabaseUtils db = Utils.getDatabaseUtils(response);
        if (db == null) return; // return if database connection failed
        try {
            int updateCount = db.executeUpdate("INSERT INTO timeslot VALUES (?, ?, ?)", time, date, id);
            if (updateCount != 1) { // checks if insert is successful
                response.sendRedirect("/errors/error.html");
                return;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
        } finally {
            db.closeConnection();
        }
        if (request.getHeader("referer") == null) {
            response.sendRedirect("/admin/timeslots.jsp?id=" + id);
        } else {
            response.sendRedirect(request.getHeader("referer"));
        }
    }
}
