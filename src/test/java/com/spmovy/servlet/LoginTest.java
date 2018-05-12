package com.spmovy.servlet;

import org.junit.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mockito;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import static org.junit.Assert.*;

public class LoginTest extends Mockito {

    @Test
    public void LoginSuccess() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        when(request.getParameter("username")).thenReturn("admin");
        when(request.getParameter("password")).thenReturn("admin");
        when(request.getSession()).thenReturn(session);

        new Login().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        // verify get username and password is called
        verify(request, atLeast(1)).getParameter("username");
        verify(request, atLeast(1)).getParameter("password");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/admin/adminPanel.jsp", captor.getValue());
    }

    @Test
    public void LoginFail() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        when(request.getParameter("username")).thenReturn("admin");
        when(request.getParameter("password")).thenReturn("idk");
        when(request.getSession()).thenReturn(session);

        new Login().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        // verify get username and password is called
        verify(request, atLeast(1)).getParameter("username");
        verify(request, atLeast(1)).getParameter("password");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/admin/admin.jsp?login=Failed", captor.getValue());
    }

    @Test
    public void MissingParam() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        when(request.getParameter("username")).thenReturn(null);
        when(request.getParameter("password")).thenReturn(null);
        when(request.getSession()).thenReturn(session);

        new Login().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        // verify get username and password is called
        verify(request, atLeast(1)).getParameter("username");
        verify(request, atLeast(1)).getParameter("password");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/admin/admin.jsp?login=Failed", captor.getValue());
    }
}