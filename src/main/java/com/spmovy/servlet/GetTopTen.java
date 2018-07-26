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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

@WebServlet("/admin/adminPanel")
public class GetTopTen extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<ToptenJB> beanlist = null;
        try {
            String month = request.getParameter("month");
            String year = request.getParameter("year");
            ToptenJBDB beandb = new ToptenJBDB();
            beanlist = beandb.getcurrentMonthSales(month,year);
            request.setAttribute("beanlist",beanlist);
            RequestDispatcher rd = request.getRequestDispatcher("/admin/adminPanel.jsp");
            rd.forward(request,response);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<ToptenJB> beanlist = null;
        try{
            Calendar cal = Calendar.getInstance();
            String currmonth = new SimpleDateFormat("MM").format(cal.getTime());
            String curryear = new SimpleDateFormat("yyyy").format(cal.getTime());

            ToptenJBDB beandb = new ToptenJBDB();
            beanlist = beandb.getcurrentMonthSales(currmonth,curryear);
            request.setAttribute("beanlist",beanlist);
            RequestDispatcher rd = request.getRequestDispatcher("/admin/adminPanel.jsp");
            rd.forward(request,response);

        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
