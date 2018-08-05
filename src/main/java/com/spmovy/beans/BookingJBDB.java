package com.spmovy.beans;

import com.spmovy.DatabaseUtils;
import java.sql.ResultSet;
import java.sql.SQLException;

public class BookingJBDB {
    /**
     * Create a new transaction for a user
     *
     * @param ID        transcation ID
     * @param at        Timestamp of when the transaction occurred
     * @param userID    User ID of the target user.
     * @return true if transaction is successfully created, else return false
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
    public static boolean inserttransaction(String ID,String at,int userID) throws SQLException {
        DatabaseUtils db = new DatabaseUtils();
        int count = db.executeUpdate("INSERT INTO transaction VALUES (?,?,?)",ID,at,userID);
        db.closeConnection();
        return count == 1;
    }

    /**
     * Store the purchase of a ticket into the database
     *
     * @param price         price of the ticket
     * @param ticketID      Ticket ID
     * @param hall_column   Column of the ticket
     * @param hall_row      Row of the ticket
     * @param transactionID Transaction ID
     * @param movietime     Time of the movie screening
     * @param moviedate     Date of the movie screening
     * @param movieID       Movie ID of the movie
     * @param salt          Salt used in the generation of ticket ID
     * @return true if ticket is successfully inserted, else return false
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
    public static boolean insertbookseats(float price, String ticketID, String hall_column, String hall_row, String transactionID,
                                          String movietime, String moviedate, int movieID, String salt) throws SQLException{
        DatabaseUtils db = new DatabaseUtils();
        int count = db.executeUpdate("INSERT INTO bookseats VALUES (?,?,?,?,?,?,?,?,?)",price,ticketID,hall_column,hall_row,transactionID
                ,movietime,moviedate,movieID,salt);
        db.closeConnection();
        return count == 1;
    }

    /**
     * Check if a ticket exist in the database, used for checking if a ticket is
     * already purchased by another customer.
     *
     * @param hall_column   Column of the ticket
     * @param hall_row      Row of the ticket
     * @param movietime     Time of the movie screening
     * @param moviedate     Date of the movie screening
     * @return true if ticket exists, else return false
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
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

    /**
     * Delete a transaction
     *
     * @param ID        transcation ID
     * @return true if transaction is successfully deleted, else return false
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
    public static boolean deleteTransaction(String ID) throws SQLException {
        DatabaseUtils db = new DatabaseUtils();
        int count = db.executeUpdate("DELETE FROM transaction WHERE ID=?",ID);
        db.closeConnection();
        return count == 1;
    }
}