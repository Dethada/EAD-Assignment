package com.spmovy;

import org.junit.Test;
import org.mockito.Mockito;

import javax.servlet.http.HttpServletResponse;

import static org.junit.Assert.*;

public class UtilsTest extends Mockito {

    @Test
    public void getDatabaseUtils() throws Exception {
        HttpServletResponse response = mock(HttpServletResponse.class);
        assertNotNull(Utils.getDatabaseUtils(response));
    }
}