package com.spmovy.servlet;

import com.spmovy.DatabaseUtils;
import org.junit.After;
import org.junit.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mockito;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.SQLException;

import static org.junit.Assert.*;

public class AddMovieTest extends Mockito {

    @After
    public void tearDown() throws Exception {
        DatabaseUtils db = new DatabaseUtils();
        try {
            db.executeUpdate("DELETE FROM movie WHERE title=? AND duration=?", "TestMovie", 10);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void MissingParamDuration() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        new AddMovie().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("title");
        verify(request, atLeast(1)).getParameter("releasedate");
        verify(request, atLeast(1)).getParameter("synopsis");
        verify(request, atLeast(1)).getParameter("duration");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/errors/error.html", captor.getValue());
    }

    @Test
    public void MissingParams() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("duration")).thenReturn("10");

        new AddMovie().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("title");
        verify(request, atLeast(1)).getParameter("releasedate");
        verify(request, atLeast(1)).getParameter("synopsis");
        verify(request, atLeast(1)).getParameter("duration");
        verify(request, atLeast(1)).getParameter("imagepath");
        verify(request, atLeast(1)).getParameter("status");
        verify(request, atLeast(1)).getParameterValues("genre");
        verify(request, atLeast(1)).getParameterValues("actor");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/errors/error.html", captor.getValue());
    }

    @Test
    public void ValidParams() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("title")).thenReturn("TestMovie");
        when(request.getParameter("releasedate")).thenReturn("2018-05-11");
        when(request.getParameter("synopsis")).thenReturn("Test Movie Synopsis");
        when(request.getParameter("duration")).thenReturn("10");
        when(request.getParameter("imagepath")).thenReturn("/image/default.svg");
        when(request.getParameter("status")).thenReturn("Coming Soon");
        String[] genre = {"Action", "Romance"};
        String[] actor = {"Chris Pratt", "Chris Evans"};
        when(request.getParameterValues("genre")).thenReturn(genre);
        when(request.getParameterValues("actor")).thenReturn(actor);

        new AddMovie().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("title");
        verify(request, atLeast(1)).getParameter("releasedate");
        verify(request, atLeast(1)).getParameter("synopsis");
        verify(request, atLeast(1)).getParameter("duration");
        verify(request, atLeast(1)).getParameter("imagepath");
        verify(request, atLeast(1)).getParameter("status");
        verify(request, atLeast(1)).getParameterValues("genre");
        verify(request, atLeast(1)).getParameterValues("actor");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/admin/movies.jsp", captor.getValue());
    }
}