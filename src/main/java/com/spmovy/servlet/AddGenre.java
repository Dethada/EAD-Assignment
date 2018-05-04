package com.spmovy.servlet;

import com.spmovy.DatabaseUtils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/backend/admin/AddGenre")
public class AddGenre extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        DatabaseUtils db = new DatabaseUtils();
        db.executeUpdate("INSERT INTO Genre(name, description) VALUES (?, ?)",
                request.getParameter("name"),
                request.getParameter("description"));
        db.closeConnection();
        response.sendRedirect(request.getHeader("referer"));
    }
}
