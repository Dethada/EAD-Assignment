package com.spmovy.beans;

import com.spmovy.DatabaseUtils;

import java.sql.ResultSet;
import java.sql.SQLException;

import static com.spmovy.BCryptUtil.checkPassword;
import static com.spmovy.BCryptUtil.hashPassword;

public class UserJBDB {
    private static UserJB initUser(ResultSet rs) throws SQLException {
        UserJB user = new UserJB();
        user.setID(rs.getInt("ID"));
        user.setUsername(rs.getString("username"));
        user.setRole(rs.getString("role"));
        user.setName(rs.getString("name"));
        user.setEmail(rs.getString("email"));
        user.setContact(rs.getString("contact"));
        user.setCardname(rs.getString("cardname"));
        user.setCreditcard(rs.getString("creditcard"));
        user.setCvv(rs.getString("cvv"));
        user.setExp(rs.getString("exp"));
        user.setPassword(rs.getString("password"));
        return user;
    }

    public static UserJB authenticate(String username, String password) throws SQLException {
        ResultSet rs;
        DatabaseUtils db = new DatabaseUtils();
        try {
            rs = db.executeQuery("SELECT * FROM users where username=?", username);
            if (rs.next()) {
                if (checkPassword(password, rs.getString("password"))) {
                    // auth sucessful
                    return initUser(rs);
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

    public static UserJB searchUserByUsername(String username) throws SQLException {
        DatabaseUtils db = new DatabaseUtils();
        ResultSet rs = db.executeQuery("select * from users where username=?", username);
        if (rs.next()) {
            return initUser(rs);
        }
        db.closeConnection();
        return null;
    }

    public static UserJB searchUserByEmail(String email) throws SQLException {
        DatabaseUtils db = new DatabaseUtils();
        ResultSet rs = db.executeQuery("select * from users where email=?", email);
        if (rs.next()) {
            return initUser(rs);
        }
        db.closeConnection();
        return null;
    }

    public static UserJB searchUserByContact(String contact) throws SQLException {
        DatabaseUtils db = new DatabaseUtils();
        ResultSet rs = db.executeQuery("select * from users where contact=?", contact);
        if (rs.next()) {
            return initUser(rs);
        }
        db.closeConnection();
        return null;
    }

    public static boolean updateProfile(int userid, String column, String newval) throws SQLException{
        DatabaseUtils db = new DatabaseUtils();
        int c = db.executeUpdate("update users set " + column + "=? where ID=?", newval, userid);
        db.closeConnection();
        return c == 1;
    }

    public static boolean register(String username, String role, String name, String email, String contact,
                                   String cardname, String creditcard, String cvv, String exp, String password) throws SQLException {
        DatabaseUtils db = new DatabaseUtils();
        int count = db.executeUpdate("INSERT INTO users(username, role, name, email, contact, cardname, creditcard, cvv, exp, password) " +
                "VALUES (?,?,?,?,?,?,?,?,?,?)", username, role, name, email, contact, cardname, creditcard, cvv, exp, hashPassword(password));
        db.closeConnection();
        return count == 1;
    }
}
