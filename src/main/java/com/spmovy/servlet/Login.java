package com.spmovy.servlet;

import com.spmovy.DatabaseUtils;
import com.spmovy.Utils;
import de.triology.recaptchav2java.ReCaptcha;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import static com.spmovy.BCryptUtil.checkPassword;

@WebServlet("/backend/Login")
public class Login extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // get reCAPTCHA request param
        String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
        boolean verify = new ReCaptcha("6Ld5D1oUAAAAAIhYveA4_E8C0chpFH_52K7g_hLm").isValid(gRecaptchaResponse);

        ResultSet rs;
        DatabaseUtils db = Utils.getDatabaseUtils(response);
        if (db == null) return;
        if (verify) {
            try {
                rs = db.executeQuery("SELECT * FROM users where username=?", username);
                if (rs.next()) {
                    if (checkPassword(password, rs.getString("password"))) {
                        // login sucessful
                        HttpSession session = request.getSession();
                        session.setAttribute("userid", rs.getInt("ID"));
                        session.setAttribute("role", rs.getString("role"));
                        response.sendRedirect("/admin/adminPanel.jsp");
                    } else {
                        response.sendRedirect("/admin.jsp?login=Failed");
                    }
                } else {
                    // login failed
                    response.sendRedirect("/admin.jsp?login=Failed");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("/errors/error.html");
                return;
            } finally {
                db.closeConnection();
            }
        } else {
            // recaptcha failed
            response.sendRedirect("/admin.jsp?login=captcha");
        }
    }
}
