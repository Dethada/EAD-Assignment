package com.spmovy.servlet;

import com.spmovy.DatabaseUtils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

@WebServlet("/backend/Login")
public class Login extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        DatabaseUtils db = new DatabaseUtils();
        ResultSet rs = db.executeQuery("SELECT * FROM users where username=? and password=?", username, password);
        try {
            if (rs.next()) {
                // login sucessful
                HttpSession session=request.getSession();
                session.setAttribute("userid", rs.getInt("ID"));
                session.setAttribute("role", rs.getString("role"));
                db.executeUpdate("UPDATE users SET lastloginip=?, lastlogintime=? WHERE username=?",
                        request.getRemoteAddr(),
                        new Timestamp(System.currentTimeMillis()),
                        username);
                response.sendRedirect("/admin/adminPanel.jsp");
            } else {
                // login failed
                response.sendRedirect("/admin/admin.jsp?login=Failed");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeConnection();
        }
    }
}
