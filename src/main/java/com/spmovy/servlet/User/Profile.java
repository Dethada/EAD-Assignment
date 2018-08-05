package com.spmovy.servlet.User;

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
        String message = "";
        boolean failed = false;

        try {
            if (username != null && !username.equals(user.getUsername())) {
                if (UserJBDB.searchUserByUsername(username) == null) {
                    if (UserJBDB.updateProfile(userid, "username", username)) {
                        user.setUsername(username);
                    } else {
                        failed = true;
                        message += "Username update failed<br>";
                    }
                } else {
                    failed = true;
                    message += "Username taken<br>";
                }
            }
            if (name != null && !name.equals(user.getName())) {
                if (UserJBDB.updateProfile(userid, "name", name)) {
                    user.setName(name);
                } else {
                    failed = true;
                    message += "Name update failed<br>";
                }
            }
            if (email != null && !email.equals(user.getEmail())) {
                if (UserJBDB.searchUserByEmail(email) == null) {
                    if (UserJBDB.updateProfile(userid, "email", email)) {
                        user.setEmail(email);
                    } else {
                        failed = true;
                        message += "Email update failed<br>";
                    }
                } else {
                    failed = true;
                    message += "Email taken<br>";
                }
            }
            if (contact != null && !contact.equals(user.getContact())) {
                if (UserJBDB.searchUserByContact(contact) == null) {
                    if (UserJBDB.updateProfile(userid, "contact", contact)) {
                        user.setContact(contact);
                    } else {
                        failed = true;
                        message += "Contact update failed<br>";
                    }
                } else {
                    failed = true;
                    message += "Contact number taken<br>";
                }
            }
            if (cardname != null && !cardname.equals(user.getCardname())) {
                if (UserJBDB.updateProfile(userid, "cardname", cardname)) {
                    user.setCardname(cardname);
                } else {
                    failed = true;
                    message += "Credit Card update failed<br>";
                }
            }
            if (creditcard != null && !creditcard.equals(user.getCreditcard())) {
                if (UserJBDB.updateProfile(userid, "creditcard", creditcard)) {
                    user.setCreditcard(creditcard);
                } else {
                    failed = true;
                    message += "Credit Card update failed<br>";
                }
            }
            if (cvv != null && !cvv.equals(user.getCvv())) {
                if (UserJBDB.updateProfile(userid, "cvv", cvv)) {
                    user.setCvv(cvv);
                } else {
                    failed = true;
                    message += "Credit Card update failed<br>";
                }
            }
            if (exp != null && !exp.equals(user.getExp())) {
                if (UserJBDB.updateProfile(userid, "exp", exp)) {
                    user.setExp(exp);
                } else {
                    failed = true;
                    message += "Credit Card update failed<br>";
                }
            }
            if (failed) {
                request.setAttribute("failed", "true");
            } else {
                request.setAttribute("failed", "false");
                message = "Profile updated.";
            }
            request.setAttribute("message", message);
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/profile/profile.jsp");
            rd.forward(request, response);
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
