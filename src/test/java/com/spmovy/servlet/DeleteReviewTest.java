package com.spmovy.servlet;

import com.spmovy.DatabaseUtils;
import org.junit.Before;
import org.junit.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mockito;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

import static org.junit.Assert.*;

public class DeleteReviewTest extends Mockito {

    private static int reviewID = 100;
    private static int movieID = 1;

    @Before
    public void setUp() throws Exception {
        DatabaseUtils db = new DatabaseUtils();
        // reviewID, movieID, reviewSentence, name, rating, createdat, ip
        try {
            db.executeUpdate("INSERT INTO movie VALUES (?, ?, ?, ?, ?, ?, ?)",
                    reviewID, movieID, "Hi nice movie", "test", 5, "1990-01-01", "127.0.0.1");
        } catch (SQLException e) {
        }
    }

    @Test
    public void MissingParams() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        new DeleteReview().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("movieid");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/errors/error.html", captor.getValue());
    }

    @Test
    public void ValidParams() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("movieid")).thenReturn(String.valueOf(movieID));
        when(request.getParameter("reviewid")).thenReturn(String.valueOf(reviewID));

        new DeleteReview().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("movieid");
        verify(request, atLeast(1)).getParameter("reviewid");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/admin/reviews.jsp?id="+movieID, captor.getValue());
    }
}