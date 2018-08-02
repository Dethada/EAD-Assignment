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
public class UserRegister extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String cardname = request.getParameter("cardname");
        String creditcard = request.getParameter("creditcard");
        String cvv = request.getParameter("cvv");
        String exp = request.getParameter("exp");
        String password = request.getParameter("password");
        String role = "member";
        String message = "";
        boolean invalid = false;

        if (!username.matches("^[A-z\\d]{1,50}$")) {
            message += "Invalid username<br>";
            invalid = true;
        }
        if (!name.matches("^[A-z ]{1,255}$")) {
            message += "Invalid Name<br>";
            invalid = true;
        }
        // https://stackoverflow.com/questions/46155/how-to-validate-an-email-address-in-javascript
        if (!email.matches("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")) {
            message += "Invalid email<br>";
            invalid = true;
        }
        if (!contact.matches("^[89]\\d{7}$")) {
            message += "Invalid contact number<br>";
            invalid = true;
        }
        if (!cardname.matches("^[A-z ]{1,26}$")) {
            message += "Invalid Card Name<br>";
            invalid = true;
        }
        if (!creditcard.matches("^\\d{14,19}$") || !cvv.matches("^\\d{3}$") || !exp.matches("^\\d{2}/\\d{2}$")) {
            message += "Invalid card details<br>";
            invalid = true;
        }
        if (!password.matches("^(\\d+[A-z]+|[A-z]+\\d+)[\\dA-z]*$") || password.length() < 8 || password.length() > 16) {
            message += "Invalid password<br>";
            invalid = true;
        }
        if (invalid) {
            request.setAttribute("failed", "true");
            request.setAttribute("message", message);
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/register/register.jsp");
            rd.forward(request, response);
        } else {
            try {
                if (UserJBDB.searchUserByUsername(username) != null) {
                    message = "Username already taken.";
                    request.setAttribute("failed", "true");
                } else if (UserJBDB.searchUserByEmail(email) != null) {
                    message = "Email already taken.";
                    request.setAttribute("failed", "true");
                } else if (UserJBDB.searchUserByContact(contact) != null) {
                    message = "Contact number already taken.";
                    request.setAttribute("failed", "true");
                } else if (UserJBDB.register(username.trim(), role, name.trim(), email.trim(), contact, cardname.trim(), creditcard, cvv, exp, password)) {
                    request.setAttribute("failed", "false");
                    message = "Successfully Registered!";
                } else {
                    request.setAttribute("failed", "true");
                    message = "Registration failed!";
                }
                request.setAttribute("message", message);
                RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/register/register.jsp");
                rd.forward(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("/errors/error.html");
            }
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
