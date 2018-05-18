package com.spmovy.servlet;

import com.spmovy.DatabaseUtils;
import com.spmovy.Utils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import static com.spmovy.BCryptUtil.checkPassword;

@WebServlet("/backend/Login")
public class Login extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        ResultSet rs;
        DatabaseUtils db = Utils.getDatabaseUtils(response);
        if (db == null) return;
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
                    response.sendRedirect("/admin/admin.jsp?login=Failed");
                }
            } else {
                // login failed
                response.sendRedirect("/admin/admin.jsp?login=Failed");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
            return;
        } finally {
            db.closeConnection();
        }
    }
}
