package com.spmovy.beans;

import com.spmovy.DatabaseUtils;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class SeatsJBDB {
    public static ArrayList<SeatsJB> getOccupiedSeats(int movieID, String moviedate, String movietime) throws SQLException {
        SeatsJB occupiedseatbean;
        ArrayList<SeatsJB> occupiedseatslist = new ArrayList<SeatsJB>();
        DatabaseUtils db = new DatabaseUtils();

        ResultSet rs = db.executeQuery("SELECT hall_row, hall_column FROM bookseats where movieID = ? AND moviedate = ? AND movietime = ?", movieID,moviedate,movietime);

        while (rs.next()){
            occupiedseatbean = new SeatsJB();
            occupiedseatbean.setRow(rs.getString(1));
            occupiedseatbean.setCol(rs.getString(2));
            occupiedseatslist.add(occupiedseatbean);
        }
        db.closeConnection();
        return occupiedseatslist;
    }
}
