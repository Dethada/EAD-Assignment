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

public class DeleteTest extends Mockito {

    private static String table = "actor";
    private static int id = 11;
    private static String name = "TestActor";
    private static String description = "TestActor Description";

    @Before
    public void setUp() throws Exception {
        DatabaseUtils db = new DatabaseUtils();
        try {
            db.executeUpdate("INSERT INTO actor VALUES (?, ?, ?)", id, name, description);
        } catch (SQLException e) {
        }
    }

    @Test
    public void MissingID() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("table")).thenReturn(null);
        when(request.getParameter("id")).thenReturn(null);

        new Delete().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("id");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/errors/error.html", captor.getValue());
    }

    @Test
    public void MissingTable() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("table")).thenReturn(null);
        when(request.getParameter("id")).thenReturn("912387");

        new Delete().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("id");
        verify(request, atLeast(1)).getParameter("table");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/errors/error.html", captor.getValue());
    }

    @Test
    public void ValidParams() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("table")).thenReturn(table);
        when(request.getParameter("id")).thenReturn(String.valueOf(id));

        new Delete().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("table");
        verify(request, atLeast(1)).getParameter("id");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/admin/adminPanel.jsp", captor.getValue());
    }
}