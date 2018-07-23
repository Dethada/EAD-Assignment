package com.spmovy.beans;

import com.spmovy.DatabaseUtils;

import java.sql.ResultSet;
import java.sql.SQLException;

import static com.spmovy.BCryptUtil.checkPassword;
import static com.spmovy.BCryptUtil.hashPassword;

public class UserJBDB {
    public static UserJB authenticate(String username, String password) throws SQLException {
        ResultSet rs;
        DatabaseUtils db = new DatabaseUtils();
        try {
            rs = db.executeQuery("SELECT * FROM users where username=?", username);
            if (rs.next()) {
                if (checkPassword(password, rs.getString("password"))) {
                    // auth sucessful
                    return new UserJB(rs.getInt("ID"), rs.getString("username"), rs.getString("role"),
                            rs.getString("name"), rs.getString("email"), rs.getString("contact"),
                            rs.getString("creditcard"), rs.getString("password"));
                } else {
                    return null;
                }
            } else {
                // auth failed
                return null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            db.closeConnection();
        }
    }

    public static boolean changePassword(int ID, String currentpass, String newpass) throws SQLException {
        if (currentpass == null || newpass == null) {
            return false;
        }
        DatabaseUtils db = new DatabaseUtils();
        ResultSet rs = db.executeQuery("select password from users where ID=?", ID);
        if (rs.next()) {
            if (checkPassword(currentpass, rs.getString("password"))) {
                // change password here
                int updateCount = db.executeUpdate("update users set password=? where ID=?", hashPassword(newpass), ID);
                if (updateCount == 1) {
                    db.closeConnection();
                    return true;
                }
            }
        }
        db.closeConnection();
        return false;
    }

    public static boolean register(String username, String role, String name, String email,
                                   String contact, String creditcard, String password) throws SQLException {
        DatabaseUtils db = new DatabaseUtils();
        int count = db.executeUpdate("INSERT INTO users(username, role, name, email, contact, creditcard, password) " +
                "VALUES (?,?,?,?,?,?,?)", username, role, name, email, contact, creditcard, hashPassword(password));
        db.closeConnection();
        return count == 1;
    }
}
