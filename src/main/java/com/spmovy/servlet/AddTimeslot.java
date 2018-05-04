package com.spmovy.servlet;

import com.spmovy.DatabaseUtils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;

@WebServlet("/backend/admin/AddTimeslot")
public class AddTimeslot extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        DatabaseUtils db = new DatabaseUtils();
        int id = Integer.parseInt(request.getParameter("id"));
        String date = request.getParameter("date");
        String time = request.getParameter("time")+":00";
        db.executeUpdate("INSERT INTO timeslot VALUES (?, ?, ?)",
                Time.valueOf(time),
                Date.valueOf(date),
                id);
        db.closeConnection();
        response.sendRedirect(request.getHeader("referer"));
    }
}
