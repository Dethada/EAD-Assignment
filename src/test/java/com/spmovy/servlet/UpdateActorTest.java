package com.spmovy.servlet;

import com.spmovy.DatabaseUtils;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mockito;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.ResultSet;
import java.sql.SQLException;

import static org.junit.Assert.*;

public class UpdateActorTest extends Mockito {

    private static String name = "test";
    private static String description = "testing 1 2 3";
    private static int id;

    @Before
    public void setUp() throws Exception {
        DatabaseUtils db = new DatabaseUtils();
        try {
            db.executeUpdate("INSERT INTO actor(Name, description) VALUES(?, ?)", name, description);
            ResultSet rs = db.executeQuery("SELECT * FROM actor WHERE Name=? AND description=?", name, description);
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
            db.executeUpdate("DELETE FROM actor WHERE ID=?", id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void MissingParams() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("name")).thenReturn(null);
        when(request.getParameter("description")).thenReturn(null);

        new UpdateActor().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("name");
        verify(request, atLeast(1)).getParameter("description");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/errors/error.html", captor.getValue());
    }

    @Test
    public void ValidParams() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("name")).thenReturn(name);
        when(request.getParameter("description")).thenReturn(description);
        when(request.getParameter("id")).thenReturn(String.valueOf(id));

        new UpdateActor().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("name");
        verify(request, atLeast(1)).getParameter("description");
        verify(request, atLeast(1)).getParameter("id");
        verify(response).sendRedirect(captor.capture());
        assertEquals(null, captor.getValue());
    }
}