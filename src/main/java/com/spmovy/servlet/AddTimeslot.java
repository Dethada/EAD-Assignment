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
        int id = Integer.parseInt(request.getParameter("id"));
        String date = request.getParameter("date");
        String time = request.getParameter("time")+":00";
        DatabaseUtils db = Utils.getDatabaseUtils(response);
        if (db == null) return;
        try {
            db.executeUpdate("INSERT INTO timeslot VALUES (?, ?, ?)",
                    Time.valueOf(time),
                    Date.valueOf(date),
                    id);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/error.html");
        } finally {
            db.closeConnection();
        }
        response.sendRedirect(request.getHeader("referer"));
    }
}
