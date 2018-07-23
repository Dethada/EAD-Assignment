package com.spmovy.servlet;

import com.spmovy.beans.UserJB;
import org.junit.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mockito;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import static org.junit.Assert.assertEquals;

public class ChangePasswordTest extends Mockito {

    @Test
    public void invalidSession() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        when(request.getParameter("currentpass")).thenReturn("abc");
        when(request.getParameter("newpass")).thenReturn("abc");
        when(request.getSession()).thenReturn(session);

        new ChangePassword().doPost(request, response);

        ArgumentCaptor<String> captor = ArgumentCaptor.forClass(String.class);
        verify(request, atLeast(1)).getParameter("currentpass");
        verify(request, atLeast(1)).getParameter("newpass");
        verify(response).sendRedirect(captor.capture());
        assertEquals("/errors/error.html", captor.getValue());
    }
}
