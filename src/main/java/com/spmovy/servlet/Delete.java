package com.spmovy.servlet;

import com.spmovy.DatabaseUtils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/backend/admin/Delete")
public class Delete extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        DatabaseUtils db = new DatabaseUtils();
        db.callDelete(request.getParameter("table"), Integer.parseInt(request.getParameter("id")));
        db.closeConnection();
        response.sendRedirect(request.getHeader("referer"));
    }
}
