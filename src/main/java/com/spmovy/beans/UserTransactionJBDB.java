package com.spmovy.beans;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.spmovy.DatabaseUtils;

public class UserTransactionJBDB {

    /**
     * Gets All transactions done by the target user
     *
     * @param userid userid of the target user
     * @return ArrayList<UserTransactionJB> - ArrayList of UserTransaction beans of the target user
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
    public static ArrayList<UserTransactionJB> getUserTransactions(int userid) throws SQLException {
        ArrayList<UserTransactionJB> transactionlist = new ArrayList<>();
        UserTransactionJB transaction;
        DatabaseUtils db = new DatabaseUtils();
        ResultSet rs = db.executeQuery("select t.ID, t.at, b.ticketID, b.price, b.hall_row, b.hall_column, b.moviedate, b.movietime, m.title from transaction t"
                + " left join bookseats b on b.transactionID = t.ID"
                + " left join movie m on m.ID = b.movieID where t.userid=?", userid);
        while (rs.next()) {
            transaction = new UserTransactionJB();
            transaction.setID(rs.getString("ID"));
            transaction.setAt(rs.getTimestamp("at"));
            transaction.setTicketID(rs.getString("ticketID"));
            transaction.setPrice(rs.getFloat("price"));
            transaction.setHall_row(rs.getString("hall_row"));
            transaction.setHall_column(rs.getString("hall_column"));
            transaction.setMoviedate(rs.getDate("moviedate"));
            transaction.setMovietime(rs.getTime("movietime"));
            transaction.setMovietitle(rs.getString("title"));
            transactionlist.add(transaction);
        }
        db.closeConnection();
        return transactionlist;
    }
}