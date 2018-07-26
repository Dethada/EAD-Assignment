package com.spmovy.beans;
import com.spmovy.DatabaseUtils;


import java.sql.*;
import java.util.ArrayList;

public class ToptenJBDB {
    public static ArrayList <ToptenJB> getcurrentMonthSales(String salesmonth, String salesyear) throws SQLException{
        ToptenJB toptenbean;
        ArrayList <ToptenJB> beanlist = new ArrayList<ToptenJB>();
        DatabaseUtils db = new DatabaseUtils();
        ResultSet rs;
        try {
            rs = db.executeQuery("select count(movieID), movie.title from bookseats inner join movie on bookseats.movieID = movie.ID where month(moviedate) = ? and year(moviedate) = ? group by movieid LIMIT 10", salesmonth, salesyear);
            while (rs.next()){
                toptenbean = new ToptenJB(rs.getInt(1),rs.getString(2));
                beanlist.add(toptenbean);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeConnection();
    }

        return beanlist;
    }
}
