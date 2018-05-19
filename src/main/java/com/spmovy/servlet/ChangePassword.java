package com.spmovy.servlet;

import com.spmovy.DatabaseUtils;
import com.spmovy.Utils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.io.IOException;
import java.sql.SQLException;

import static com.spmovy.BCryptUtil.hashPassword;
import static com.spmovy.BCryptUtil.checkPassword;

@WebServlet("/backend/admin/ChangePassword")
public class ChangePassword extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String currentpass = request.getParameter("currentpass");
        String newpass = request.getParameter("newpass");
        if (currentpass == null || newpass == null) {
            response.sendRedirect("/admin/changePassword.jsp?result=failed");
            return;
        }
        DatabaseUtils db = Utils.getDatabaseUtils(response);
        if (db == null) return; // return if database connection failed
        HttpSession session = request.getSession();
        int userid;
        try {
            userid = (int) session.getAttribute("userid");
        } catch(NumberFormatException | IllegalStateException | NullPointerException e) {
            response.sendRedirect("/errors/error.html");
            return;
        }
        try {
            ResultSet rs = db.executeQuery("select password from users where ID=?", userid);
            if (rs.next()) {
                if (checkPassword(currentpass, rs.getString("password"))) {
                    // change password here
                    int updateCount = db.executeUpdate("update users set password=? where ID=?", hashPassword(newpass), userid);
                    if (updateCount != 1) {
                        response.sendRedirect("/errors/error.html");
                        return;
                    } else {
                        response.sendRedirect("/admin/changePassword.jsp?result=success");
                        return;
                    }
                } else {
                    // current password not correct, abort
                    response.sendRedirect("/admin/changePassword.jsp?result=failed");
                    return;
                }
            } else {
                response.sendRedirect("/admin/changePassword.jsp?result=failed");
                return;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
            return;
        }
    }
}