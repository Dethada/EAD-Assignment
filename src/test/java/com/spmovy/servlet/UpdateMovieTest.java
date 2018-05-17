package com.spmovy.servlet;

import com.spmovy.DatabaseUtils;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mockito;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

import static org.junit.Assert.*;

public class UpdateMovieTest extends Mockito {

    private static int id;
    private static String title = "test";
    private static String releasedate = "1990-05-11";
    private static String synopsis = "testing 1 2 3";
    private static int duration = 10;
    private static String imagepath = "test";
    private static String status = "Over";
    private static String[] genre = {"Action", "Romance"};
    private static String[] actor = {"Chris Pratt", "Chris Evans"};

    @Before
    public void setUp() throws Exception {
        DatabaseUtils db = new DatabaseUtils();
        try {
            db.executeUpdate("INSERT INTO movie(title, releasedate, synopsis, duration, imagepath, status) VALUES(?, ?, ?, ?, ?, ?)",
                    title,
                    java.sql.Date.valueOf(releasedate),
                    synopsis,
                    duration,
                    imagepath,
                    status);
            ResultSet rs = db.executeQuery("SELECT * FROM movie WHERE title=? AND releasedate=? AND synopsis=? AND imagepath=?",
                    title,
                    java.sql.Date.valueOf(releasedate),
                    synopsis,
                    imagepath);
            if (rs.next()) {
                id = rs.getInt("ID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @After
    public void tearDown() throws Exception {
        DatabaseUtils db = new DatabaseUtils();
        try {
            db.executeUpdate("DELETE FROM movie WHERE ID=?", id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void MissingParams() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);
//        ID, title, releasedate, synopsis, duration, imagepath, status
        when(request.getParameter("id")).thenReturn(String.valueOf(id));
        when(request.getParameter("duration")).thenReturn(String.valueOf(duration));
        when(request.getParameter("title")).thenReturn(null);
        when(request.getParameter("releasedate")).thenReturn(null);
        when(request.getParameter("synopsis")).thenReturn(null);
        when(request.getParameter("imagepath")).thenReturn(null);
        when(request.getParameter("status")).thenReturn(null);

        new UpdateMovie().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("id");
        verify(request, atLeast(1)).getParameter("duration");
        verify(request, atLeast(1)).getParameter("title");
        verify(request, atLeast(1)).getParameter("releasedate");
        verify(request, atLeast(1)).getParameter("synopsis");
        verify(request, atLeast(1)).getParameter("imagepath");
        verify(request, atLeast(1)).getParameter("status");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/errors/error.html", captor.getValue());
    }

    @Test
    public void MissingID() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("id")).thenReturn(String.valueOf(id));

        new UpdateMovie().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("id");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/errors/error.html", captor.getValue());
    }

    @Test
    public void MissingDuration() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("id")).thenReturn(String.valueOf(id));
        when(request.getParameter("duration")).thenReturn(null);

        new UpdateMovie().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("id");
        verify(request, atLeast(1)).getParameter("duration");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/errors/error.html", captor.getValue());
    }

    @Test
    public void ValidParams() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);
//        ID, title, releasedate, synopsis, duration, imagepath, status
        when(request.getParameter("id")).thenReturn(String.valueOf(id));
        when(request.getParameter("duration")).thenReturn(String.valueOf(duration));
        when(request.getParameter("title")).thenReturn(title);
        when(request.getParameter("releasedate")).thenReturn(releasedate);
        when(request.getParameter("synopsis")).thenReturn(synopsis);
        when(request.getParameter("imagepath")).thenReturn(imagepath);
        when(request.getParameter("status")).thenReturn(status);
        when(request.getParameterValues("genre")).thenReturn(genre);
        when(request.getParameterValues("actor")).thenReturn(actor);

        new UpdateMovie().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("id");
        verify(request, atLeast(1)).getParameter("duration");
        verify(request, atLeast(1)).getParameter("title");
        verify(request, atLeast(1)).getParameter("releasedate");
        verify(request, atLeast(1)).getParameter("synopsis");
        verify(request, atLeast(1)).getParameter("imagepath");
        verify(request, atLeast(1)).getParameter("status");
        verify(request, atLeast(1)).getParameterValues("genre");
        verify(request, atLeast(1)).getParameterValues("actor");
        verify(response).sendRedirect(captor.capture());
        assertEquals(null, captor.getValue());
    }

    @Test
    public void UpdateImagePathInvalidID() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("id")).thenReturn(null);

        new UpdateMovieImagePath().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("id");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/errors/error.html", captor.getValue());
    }

    @Test
    public void UpdateImagePathInvalidPath() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("id")).thenReturn(String.valueOf(id));
        when(request.getParameter("path")).thenReturn(null);

        new UpdateMovieImagePath().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("id");
        verify(request, atLeast(1)).getParameter("path");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/errors/error.html", captor.getValue());
    }

    @Test
    public void UpdateImagePathValid() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("id")).thenReturn(String.valueOf(id));
        when(request.getParameter("path")).thenReturn("/testworked");
        StringWriter stringWriter = new StringWriter();
        PrintWriter writer = new PrintWriter(stringWriter);
        when(response.getWriter()).thenReturn(writer);

        new UpdateMovieImagePath().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("id");
        verify(request, atLeast(1)).getParameter("path");
        writer.flush(); // it may not have been flushed yet...
        assertTrue(stringWriter.toString().equals("Updated Movie Image Path"));
    }

    @Test
    public void DeleteMovieMissingTable() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("table")).thenReturn(null);

        new DeleteMovie().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("table");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/errors/error.html", captor.getValue());
    }

    @Test
    public void DeleteMovieMissingID() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("table")).thenReturn("movie");
        when(request.getParameter("id")).thenReturn(null);

        new DeleteMovie().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("table");
        verify(request, atLeast(1)).getParameter("id");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/errors/error.html", captor.getValue());
    }

    @Test
    public void DeleteMovie() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("id")).thenReturn(String.valueOf(id));
        when(request.getParameter("table")).thenReturn("movie");

        new DeleteMovie().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("id");
        verify(request, atLeast(1)).getParameter("table");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/admin/movies.jsp", captor.getValue());
    }
}