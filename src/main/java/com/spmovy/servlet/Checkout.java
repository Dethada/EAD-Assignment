package com.spmovy.servlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

@WebServlet("/user/Checkout")
public class Checkout extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int userid = Integer.parseInt(request.getParameter("userid"));
            String timeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
            String concat = timeStamp + userid;
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] transactionhash = digest.digest(concat.getBytes(StandardCharsets.UTF_8));
            String transactionID = asHex(transactionhash);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            response.sendRedirect("/errors/error.html");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/user/checkout.jsp");
        rd.forward(request, response);
    }

    public static String asHex (byte buf[]) {
        //Obtain a StringBuffer object
        StringBuffer strbuf = new StringBuffer(buf.length * 2);
        int i;
        for (i = 0; i < buf.length; i++) {
            if (((int) buf[i] & 0xff) < 0x10)
                strbuf.append("0");
            strbuf.append(Long.toString((int) buf[i] & 0xff, 16));
        }
        // Return result string in Hexadecimal format
        return strbuf.toString();
    }
}