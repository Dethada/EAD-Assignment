package com.spmovy;

import org.junit.Test;

import static com.spmovy.BCryptUtil.checkPassword;
import static com.spmovy.BCryptUtil.hashPassword;
import static org.junit.Assert.*;

public class BCryptUtilTest {

    @Test
    public void hashPasswordTest() {
        assertEquals(hashPassword("password").length(), 60);
    }

    @Test
    public void checkPasswordTest() {
        String test_passwd = "password";
        String test_hash = "$2a$12$foOKatsp1GmqxmcvigiQuezyM4vZjmJ4atvjNCnyYZFJWsKYU7XkC";

        assertTrue(checkPassword(test_passwd, test_hash));
    }

    @Test
    public void GeneralTest() {
        String test_passwd = "password";
        assertTrue(checkPassword(test_passwd, hashPassword(test_passwd)));
    }
}