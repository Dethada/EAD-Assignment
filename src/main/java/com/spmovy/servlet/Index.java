package com.spmovy.servlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.spmovy.beans.MovieJBDB;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/")
public class Index extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String target = request.getParameter("target");
        String query = request.getParameter("query");
        try {
            if ((target == null || query == null)
                    || (!target.equals("title") && !target.equals("genre") && !target.equals("actor"))) {
                request.setAttribute("movielist", MovieJBDB.getAllMovies());
            } else if (target.equals("title")) {
                request.setAttribute("movielist", MovieJBDB.searchTitle(query));
            } else if (target.equals("genre")) {
                request.setAttribute("movielist", MovieJBDB.searchGenre(query));
            } else {
                request.setAttribute("movielist", MovieJBDB.searchActor(query));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
            return;
        }
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/index.jsp");
        rd.forward(request, response);
    }
}
