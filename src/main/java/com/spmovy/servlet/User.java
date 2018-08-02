package com.spmovy.servlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.spmovy.beans.UserJB;
import com.spmovy.beans.UserJBDB;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/admin/Users")
public class User extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String username = request.getParameter("username");
        try {
            if (username != null) {
                ArrayList<UserJB> userlist = new ArrayList<>();
                userlist.add(UserJBDB.searchUserByUsername(username));
                request.setAttribute("userlist", userlist);
            } else {
                request.setAttribute("userlist", UserJBDB.getAllUsers());
            }
        } catch(SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
            return;
        }
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/admin/users.jsp");
        rd.forward(request, response);
    }
}