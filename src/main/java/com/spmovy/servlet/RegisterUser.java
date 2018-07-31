package com.spmovy.servlet;

import com.spmovy.beans.UserJB;
import com.spmovy.beans.UserJBDB;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/RegisterUser")
public class RegisterUser extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
//        String cardname = request.getParameter("cardname");
        String creditcard = request.getParameter("creditcard");
        String cvv = request.getParameter("cvv");
        String exp = request.getParameter("exp");
        String password = request.getParameter("password");
        String role = "member";

        String message;
        try {
            if (UserJBDB.register(username, role, name, email, contact, creditcard, cvv, exp, password)) {
                message = "Successfully Registered!";
            } else {
                message = "Registration failed!";
            }
            request.setAttribute("message", message);
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/register/result.jsp");
            rd.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserJB user = (UserJB) request.getSession().getAttribute("user");
        if (user != null) {
            response.sendRedirect("/user/Profile");
        } else {
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/register/register.jsp");
            rd.forward(request, response);
        }
    }
}
