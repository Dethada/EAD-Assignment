package com.spmovy.servlet.Admin;

import com.spmovy.beans.UserJB;
import com.spmovy.beans.UserJBDB;
import de.triology.recaptchav2java.ReCaptcha;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // get reCAPTCHA request param
        String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
        boolean verify = new ReCaptcha("6Ld5D1oUAAAAAIhYveA4_E8C0chpFH_52K7g_hLm").isValid(gRecaptchaResponse);

        if (verify) {
            try {
                UserJB user = UserJBDB.authenticate(username, password);
                if (user != null && user.getRole().equals("admin")) {
                    // login success
                    HttpSession session = request.getSession();
                    session.setAttribute("admin", user);
                    response.sendRedirect("/admin/adminPanel");
                } else {
                    // login failed
                    request.setAttribute("login", "Failed");
                    RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/adminlogin.jsp");
                    rd.forward(request, response);
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("/errors/error.html");
            }
        } else {
            // recaptcha failed
            request.setAttribute("login", "captcha");
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/adminlogin.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/adminlogin.jsp");
        rd.forward(request, response);
    }
}
