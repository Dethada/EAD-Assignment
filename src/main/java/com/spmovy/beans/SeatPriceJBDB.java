package com.spmovy.beans;

import com.spmovy.DatabaseUtils;

import java.sql.ResultSet;
import java.sql.SQLException;

public class SeatPriceJBDB {
    /**
     * Get the price of a movie ticket for weekday/weekend.
     *
     * @param day       weekday/weekend
     * @return price of the movie ticket.
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
    public static SeatPriceJB getSeatPrice(String day) throws SQLException {
        SeatPriceJB seatpricebean = null;
        DatabaseUtils db = new DatabaseUtils();

        ResultSet rs = db.executeQuery("SELECT price FROM price where day=?", day);

        if (rs.next()) {
            seatpricebean = new SeatPriceJB();
            seatpricebean.setPrice(rs.getFloat(1));
        }
        db.closeConnection();
        return seatpricebean;
    }
}
