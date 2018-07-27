package com.spmovy.beans;

import com.spmovy.DatabaseUtils;


import java.sql.*;
import java.util.ArrayList;

public class ToptenJBDB {
    public static ArrayList<ToptenJB> getcurrentMonthSales(int salesmonth, int salesyear) throws SQLException {
        ToptenJB toptenbean;
        ArrayList<ToptenJB> beanlist = new ArrayList<ToptenJB>();
        DatabaseUtils db = new DatabaseUtils();
        ResultSet rs = db.executeQuery("select count(movieID), movie.title, MONTH(moviedate), YEAR(moviedate) from bookseats inner join movie on bookseats.movieID = movie.ID where month(moviedate) = ? and year(moviedate) = ? group by movieid LIMIT 10", salesmonth, salesyear);
        while (rs.next()) {
            toptenbean = new ToptenJB(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getString(4));
            beanlist.add(toptenbean);
        }

        return beanlist;
    }
}

