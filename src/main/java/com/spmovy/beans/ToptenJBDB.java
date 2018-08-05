package com.spmovy.beans;

import com.spmovy.DatabaseUtils;


import java.sql.*;
import java.util.ArrayList;

public class ToptenJBDB {
    /**
     * Get top ten most sold movies for a specific month
     * (the showtime of the movie is taken instead of the purchase time)
     *
     * @param salesmonth month to retrieve data for
     * @param salesyear  year to retrieve data for
     * @return ArrayList with up to ten top selling movies for the specified month, can return null if
     * no tickets are sold in that month.
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
    public static ArrayList<ToptenJB> getcurrentMonthSales(int salesmonth, int salesyear) throws SQLException {
        ToptenJB toptenbean;
        ArrayList<ToptenJB> beanlist = new ArrayList<ToptenJB>();
        DatabaseUtils db = new DatabaseUtils();
        ResultSet rs = db.executeQuery("select count(movieID), movie.title, MONTH(moviedate), YEAR(moviedate) from bookseats inner join movie on bookseats.movieID = movie.ID where month(moviedate) = ? and year(moviedate) = ? group by movieid LIMIT 10", salesmonth, salesyear);
        while (rs.next()) {
            toptenbean = new ToptenJB();
            toptenbean.setMoviecount(rs.getInt(1));
            toptenbean.setMovietitle(rs.getString(2));
            toptenbean.setMonth(rs.getInt(3));
            toptenbean.setYear(rs.getString(4));
            beanlist.add(toptenbean);
        }
        db.closeConnection();
        return beanlist;
    }
}

