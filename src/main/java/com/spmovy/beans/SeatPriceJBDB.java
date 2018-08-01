package com.spmovy.beans;

import com.spmovy.DatabaseUtils;

import java.sql.ResultSet;
import java.sql.SQLException;

public class SeatPriceJBDB {
    public static SeatPriceJB getSeatPrice(String day) throws SQLException {
        SeatPriceJB seatpricebean = null;
        DatabaseUtils db = new DatabaseUtils();

        ResultSet rs = db.executeQuery("SELECT price FROM price where day=?", day);

        if (rs.next()) {
            seatpricebean = new SeatPriceJB();
            seatpricebean.setPrice(rs.getDouble(1));
        }
        db.closeConnection();
        return seatpricebean;
    }
}
