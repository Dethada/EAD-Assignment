package com.spmovy.servlet;

import com.spmovy.DatabaseUtils;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mockito;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;

import static org.junit.Assert.*;

public class DeleteTimeslotTest extends Mockito {

    private static int movieID = 1;
    private static Time movietime = Time.valueOf("12:00:00");
    private static Date moviedate = Date.valueOf("1990-01-01");


    @Before
    public void setUp() throws Exception {
        DatabaseUtils db = new DatabaseUtils();
        try {
            db.executeUpdate("INSERT INTO timeslot VALUES (?, ?, ?)",
                    movietime, moviedate, movieID);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        db.closeConnection();
    }

    @After
    public void tearDown() throws Exception {
        DatabaseUtils db = new DatabaseUtils();
        try {
            db.executeUpdate("DELETE FROM timeslot WHERE movietime=? and moviedate=? and movieID=?",
                    movietime, moviedate, movieID);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        db.closeConnection();
    }

    @Test
    public void MissingParams() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        new DeleteTimeslot().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("id");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/errors/error.html", captor.getValue());
    }

    @Test
    public void ValidParams() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("id")).thenReturn(String.valueOf(movieID));
        when(request.getParameter("moviedate")).thenReturn(String.valueOf(moviedate));
        when(request.getParameter("movietime")).thenReturn(String.valueOf(movietime));

        new DeleteTimeslot().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("id");
        verify(request, atLeast(1)).getParameter("moviedate");
        verify(request, atLeast(1)).getParameter("movietime");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/admin/timeslots.jsp?id="+movieID, captor.getValue());
    }
}