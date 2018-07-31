package com.spmovy.servlet;

import com.spmovy.beans.UserJB;
import com.spmovy.beans.UserJBDB;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/user/Profile")
public class Profile extends HttpServlet {
    /*
    Non tested
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        UserJB user = (UserJB) request.getSession().getAttribute("user");
        int userid = user.getID();
        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String cardname = request.getParameter("cardname");
        String creditcard = request.getParameter("creditcard");
        String cvv = request.getParameter("cvv");
        String exp = request.getParameter("exp");
        try {
            if (username != null && !username.equals(user.getUsername())) {
                if (!UserJBDB.updateProfile(userid, "username", username)) {
                    // update failed
                    response.sendRedirect("/errors/error.html");
                }
            }
            if (name != null && !name.equals(user.getName())) {
                if (!UserJBDB.updateProfile(userid, "name", name)) {
                    // update failed
                    response.sendRedirect("/errors/error.html");
                }
            }
            if (email != null && !email.equals(user.getEmail())) {
                if (!UserJBDB.updateProfile(userid, "email", email)) {
                    // update failed
                    response.sendRedirect("/errors/error.html");
                }
            }
            if (contact != null && !contact.equals(user.getContact())) {
                if (!UserJBDB.updateProfile(userid, "contact", contact)) {
                    // update failed
                    response.sendRedirect("/errors/error.html");
                }
            }
            if (cardname != null) {
                if (!UserJBDB.updateProfile(userid, "cardname", cardname)) {
                    // update failed
                    response.sendRedirect("/errors/error.html");
                }
            }
            if (creditcard != null && !creditcard.equals(user.getCreditcard())) {
                if (!UserJBDB.updateProfile(userid, "creditcard", creditcard)) {
                    // update failed
                    response.sendRedirect("/errors/error.html");
                }
            }
            if (cvv != null && !cvv.equals(user.getCvv())) {
                if (!UserJBDB.updateProfile(userid, "cvv", cvv)) {
                    // update failed
                    response.sendRedirect("/errors/error.html");
                }
            }
            if (exp != null && !exp.equals(user.getExp())) {
                if (!UserJBDB.updateProfile(userid, "exp", exp)) {
                    // update failed
                    response.sendRedirect("/errors/error.html");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/profile/profile.jsp");
        rd.forward(request, response);
    }
}
