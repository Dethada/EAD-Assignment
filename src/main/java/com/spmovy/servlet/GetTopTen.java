package com.spmovy.servlet;

import com.spmovy.beans.ToptenJB;
import com.spmovy.beans.ToptenJBDB;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

@WebServlet("/admin/adminPanel")
public class GetTopTen extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<ToptenJB> beanlist = null;
        try {
            int month = Integer.parseInt(request.getParameter("month"));
            int year = Integer.parseInt(request.getParameter("year"));
            ToptenJBDB beandb = new ToptenJBDB();
            beanlist = beandb.getcurrentMonthSales(month, year);
            if (beanlist.isEmpty()) {
                request.setAttribute("isempty", "true");
                request.setAttribute("month", month);
                request.setAttribute("year", year);
            } else {
                request.setAttribute("beanlist", beanlist);
            }
            RequestDispatcher rd = request.getRequestDispatcher("/admin/adminPanel.jsp");
            rd.forward(request, response);
            //catching for invalid inputs that are not integers
        } catch (NumberFormatException e) {
            request.setAttribute("inputformat", "false");
            RequestDispatcher rd = request.getRequestDispatcher("/admin/adminPanel.jsp");
            rd.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<ToptenJB> beanlist = null;
        try {
            Calendar cal = Calendar.getInstance();
            int currmonth = Integer.parseInt(new SimpleDateFormat("MM").format(cal.getTime()));
            int curryear = Integer.parseInt(new SimpleDateFormat("yyyy").format(cal.getTime()));

            ToptenJBDB beandb = new ToptenJBDB();
            beanlist = beandb.getcurrentMonthSales(currmonth, curryear);
            request.setAttribute("beanlist", beanlist);
            RequestDispatcher rd = request.getRequestDispatcher("/admin/adminPanel.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
        }
    }
}
