package com.spmovy.servlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.spmovy.beans.UserJBDB;
import com.spmovy.beans.UserTransactionJB;
import com.spmovy.beans.UserTransactionJBDB;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/admin/userdetail")
public class UserDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int userid;
        try {
            userid = Integer.parseInt(request.getParameter("id"));
        } catch(NumberFormatException e) {
            response.sendRedirect("/admin/Users");
            return;
        }
        try {
            request.setAttribute("userbean", UserJBDB.searchUserByID(userid));
            ArrayList<UserTransactionJB> transactionlist = UserTransactionJBDB.getUserTransactions(userid);
            request.setAttribute("transactionlist", transactionlist);
        } catch(SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
            return;
        }
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/admin/userdetail.jsp");
        rd.forward(request, response);
    }
}