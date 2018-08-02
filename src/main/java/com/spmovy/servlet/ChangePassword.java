package com.spmovy.servlet;

import com.spmovy.beans.UserJB;
import com.spmovy.beans.UserJBDB;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/backend/admin/ChangePassword")
public class ChangePassword extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String currentpass = request.getParameter("currentpass");
        String newpass = request.getParameter("newpass");
        UserJB user = (UserJB) request.getSession().getAttribute("user");
        int userid = user.getID();
        try {
            if(UserJBDB.changePassword(userid, currentpass, newpass)) {
                response.sendRedirect("/admin/changePassword.jsp?result=success");
            } else {
                response.sendRedirect("/admin/changePassword.jsp?result=failed");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
        }
    }
}