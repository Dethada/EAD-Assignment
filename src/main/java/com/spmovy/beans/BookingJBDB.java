package com.spmovy.beans;

import com.spmovy.DatabaseUtils;
import java.sql.ResultSet;
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

    public static boolean ticketExist(String hall_column, String hall_row, String movietime, String moviedate, int movieid) throws SQLException {
        DatabaseUtils db = new DatabaseUtils();
        ResultSet rs = db.executeQuery("select * from bookseats where hall_column=? and hall_row=? and movietime=? and moviedate=? and movieID=?", hall_column, hall_row, movietime, moviedate, movieid);
        if (rs.next()) {
            db.closeConnection();
            return true;
        }
        db.closeConnection();
        return false;
    }

    public static boolean deleteTransaction(String ID) throws SQLException {
        DatabaseUtils db = new DatabaseUtils();
        int count = db.executeUpdate("DELETE FROM transaction WHERE ID=?",ID);
        db.closeConnection();
        return count == 1;
    }
}