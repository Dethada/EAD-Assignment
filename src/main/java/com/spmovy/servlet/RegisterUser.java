package com.spmovy.servlet;

import com.spmovy.beans.UserJBDB;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/backend/RegisterUser")
public class RegisterUser extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String creditcard = request.getParameter("creditcard");
        String password = request.getParameter("password");
        String role = "member";

        String message;
        try {
            if (UserJBDB.register(username, role, name, email, contact, creditcard, password)) {
                message = "Successfully Registered!";
            } else {
                message = "Registration failed!";
            }
            request.setAttribute("message", message);
            RequestDispatcher rd = request.getRequestDispatcher("/register/result.jsp");
            try {
                rd.forward(request, response);
            } catch (ServletException e) {
                e.printStackTrace();
                response.sendRedirect("/errors/error.html");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
        }
    }
}
