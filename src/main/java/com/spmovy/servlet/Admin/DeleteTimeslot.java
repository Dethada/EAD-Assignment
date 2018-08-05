package com.spmovy.servlet.Admin;

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

@WebServlet("/backend/admin/DeleteTimeslot")
public class DeleteTimeslot extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id;
        Date date;
        Time time;
        try {
            id = Integer.parseInt(request.getParameter("id"));
            date = Date.valueOf(request.getParameter("moviedate"));
            time = Time.valueOf(request.getParameter("movietime"));
        } catch (Exception e) { // catch all format exception
            response.sendRedirect("/errors/error.html");
            return;
        }
        DatabaseUtils db = Utils.getDatabaseUtils(response);
        if (db == null) return; // return if database connection failed
        try {
            int updateCount = db.executeUpdate("delete from timeslot where movietime=? and moviedate=? and movieID=?",
                    time,
                    date,
                    id);
            if (updateCount != 1) { // checks if delete is successful
                response.sendRedirect("/errors/error.html");
                return;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
            return;
        } finally {
            db.closeConnection();
        }
        response.sendRedirect("/admin/timeslots.jsp?id=" + id);
    }
}
