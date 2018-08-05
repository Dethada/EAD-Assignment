package com.spmovy.servlet.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.spmovy.beans.UserJB;
import com.spmovy.beans.UserJBDB;
import com.spmovy.beans.UserTransactionJB;
import com.spmovy.beans.UserTransactionJBDB;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/user/Transactions")
public class UserTransactions extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            UserJB user = (UserJB) request.getSession().getAttribute("user");
            int userid = user.getID();
            request.setAttribute("userbean", UserJBDB.searchUserByID(userid));
            ArrayList<UserTransactionJB> transactionlist = UserTransactionJBDB.getUserTransactions(userid);
            request.setAttribute("transactionlist", transactionlist);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
            return;
        }
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/profile/transactions.jsp");
        rd.forward(request, response);
    }
}