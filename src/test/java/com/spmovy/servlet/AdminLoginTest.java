package com.spmovy.servlet;

import org.junit.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mockito;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import static org.junit.Assert.*;

public class AdminLoginTest extends Mockito {

    @Test
    public void CaptchaFail() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        when(request.getParameter("username")).thenReturn(null);
        when(request.getParameter("password")).thenReturn(null);
        when(request.getSession()).thenReturn(session);

        new AdminLogin().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        // verify get username and password is called
        verify(request, atLeast(1)).getParameter("username");
        verify(request, atLeast(1)).getParameter("password");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/admin.jsp?login=captcha", captor.getValue());
    }
}