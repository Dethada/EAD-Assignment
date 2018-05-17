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

public class AddReviewTest extends Mockito {

    private static String name = "tester";
    private static String review = "nice one";
    private static int rating = 4;
    private static int movieid = 1;

    @After
    public void tearDown() throws Exception {
        DatabaseUtils db = new DatabaseUtils();
        try {
            db.executeUpdate("DELETE FROM reviews WHERE name=? AND reviewSentence=? AND rating=? AND movieID=?", name, review, rating, movieid);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void MissingParams() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("name")).thenReturn(null);
        when(request.getParameter("review")).thenReturn(null);
        when(request.getParameter("rating")).thenReturn(null);

        new AddReview().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("name");
        verify(request, atLeast(1)).getParameter("review");
        verify(request, atLeast(1)).getParameter("rating");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/errors/error.html", captor.getValue());
    }

    @Test
    public void InvalidRatingHigh() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("name")).thenReturn(name);
        when(request.getParameter("review")).thenReturn(review);
        when(request.getParameter("rating")).thenReturn(String.valueOf(6));
        when(request.getParameter("movieid")).thenReturn(String.valueOf(movieid));
        when(request.getRemoteAddr()).thenReturn("127.0.0.1");

        new AddReview().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("name");
        verify(request, atLeast(1)).getParameter("review");
        verify(request, atLeast(1)).getParameter("rating");
        verify(request, atLeast(1)).getParameter("movieid");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/errors/error.html", captor.getValue());
    }

    @Test
    public void InvalidRatingLow() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("name")).thenReturn(name);
        when(request.getParameter("review")).thenReturn(review);
        when(request.getParameter("rating")).thenReturn(String.valueOf(0));
        when(request.getParameter("movieid")).thenReturn(String.valueOf(movieid));
        when(request.getRemoteAddr()).thenReturn("127.0.0.1");

        new AddReview().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("name");
        verify(request, atLeast(1)).getParameter("review");
        verify(request, atLeast(1)).getParameter("rating");
        verify(request, atLeast(1)).getParameter("movieid");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/errors/error.html", captor.getValue());
    }

    @Test
    public void ValidParams() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("name")).thenReturn(name);
        when(request.getParameter("review")).thenReturn(review);
        when(request.getParameter("rating")).thenReturn(String.valueOf(rating));
        when(request.getParameter("movieid")).thenReturn(String.valueOf(movieid));
        when(request.getRemoteAddr()).thenReturn("127.0.0.1");

        new AddReview().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("name");
        verify(request, atLeast(1)).getParameter("review");
        verify(request, atLeast(1)).getParameter("rating");
        verify(request, atLeast(1)).getParameter("movieid");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/moviedetails.jsp?movieid="+movieid, captor.getValue());
    }
}