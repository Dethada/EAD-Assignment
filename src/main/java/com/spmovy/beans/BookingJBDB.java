package com.spmovy.beans;

import com.spmovy.DatabaseUtils;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

public class BookingJBDB {
    public static boolean inserttransaction(String ID,String at,int userID) throws SQLException {
        DatabaseUtils db = new DatabaseUtils();
        int count = db.executeUpdate("INSERT INTO transaction VALUES (?,?,?)",ID,at,userID);
        db.closeConnection();
        return count == 1;
    }
 
    public static boolean insertbookseats(float price, String ticketID, String hall_column, String hall_row, String transactionID,
                                          String movietime, String moviedate, int movieID, String salt) throws SQLException{
        DatabaseUtils db = new DatabaseUtils();
        int count = db.executeUpdate("INSERT INTO bookseats VALUES (?,?,?,?,?,?,?,?,?)",price,ticketID,hall_column,hall_row,transactionID
                ,movietime,moviedate,movieID,salt);
        db.closeConnection();
        return count == 1;
    }
}