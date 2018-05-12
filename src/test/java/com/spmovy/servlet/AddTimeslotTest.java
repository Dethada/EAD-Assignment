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

public class AddTimeslotTest extends Mockito {

    private static int movieID = 1;
    private static String date = "1990-01-01";

    @After
    public void tearDown() throws Exception {
        DatabaseUtils db = new DatabaseUtils();
        try {
            db.executeUpdate("DELETE FROM timeslot WHERE movieID=? AND moviedate=?", movieID, date);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void MissingID() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("id")).thenReturn(null);
        when(request.getParameter("date")).thenReturn(null);
        when(request.getParameter("time")).thenReturn(null);

        new AddTimeslot().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("id");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/errors/error.html", captor.getValue());
    }

    @Test
    public void MissingDate() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("id")).thenReturn(String.valueOf(movieID));
        when(request.getParameter("date")).thenReturn(null);
        when(request.getParameter("time")).thenReturn(null);

        new AddTimeslot().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("id");
        verify(request, atLeast(1)).getParameter("date");
//        verify(request, atLeast(1)).getParameter("time");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/errors/error.html", captor.getValue());
    }

    @Test
    public void MissingTime() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("id")).thenReturn(String.valueOf(movieID));
        when(request.getParameter("date")).thenReturn(date);
        when(request.getParameter("time")).thenReturn(null);

        new AddTimeslot().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("id");
        verify(request, atLeast(1)).getParameter("date");
        verify(request, atLeast(1)).getParameter("time");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/errors/error.html", captor.getValue());
    }

    @Test
    public void ValidParams() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("id")).thenReturn(String.valueOf(movieID));
        when(request.getParameter("date")).thenReturn(date);
        when(request.getParameter("time")).thenReturn("12:00");

        new AddTimeslot().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("id");
        verify(request, atLeast(1)).getParameter("date");
        verify(request, atLeast(1)).getParameter("time");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/admin/timeslots.jsp?id="+movieID, captor.getValue());
    }
}