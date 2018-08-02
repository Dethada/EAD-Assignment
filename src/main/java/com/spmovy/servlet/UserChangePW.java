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

@WebServlet("/user/ChangePassword")
public class UserChangePW extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String currentpass = request.getParameter("currentpass");
        String newpass = request.getParameter("newpass");
        UserJB user = (UserJB) request.getSession().getAttribute("user");
        int userid = user.getID();
        if (!newpass.matches("^(\\d+[A-z]+|[A-z]+\\d+)[\\dA-z]*$") || newpass.length() < 8 || newpass.length() > 16) {
            request.setAttribute("result", "failed");
            request.setAttribute("message", "Password does not meet requirements");
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/profile/changepw.jsp");
            rd.forward(request, response);
            return;
        }
        try {
            if(UserJBDB.changePassword(userid, currentpass, newpass)) {
                request.setAttribute("result", "success");
                request.setAttribute("message", "Password changed");
                RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/profile/changepw.jsp");
                rd.forward(request, response);
            } else {
                request.setAttribute("result", "failed");
                request.setAttribute("message", "You have entered an invalid password");
                RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/profile/changepw.jsp");
                rd.forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/profile/changepw.jsp");
        rd.forward(request, response);
    }
}
