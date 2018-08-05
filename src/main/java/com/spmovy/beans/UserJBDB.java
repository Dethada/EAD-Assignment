package com.spmovy.beans;

import com.spmovy.DatabaseUtils;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import static com.spmovy.BCryptUtil.checkPassword;
import static com.spmovy.BCryptUtil.hashPassword;

public class UserJBDB {
    /**
     * Convinence method for initializing a user bean
     *
     * @param rs       resultset of users table
     * @return UserJB
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
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

    /**
     * Authenticates a user
     *
     * @param username      username of user
     * @param password      password of user
     * @return UserJB if valid credentials are provided.
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
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

    /**
     * Change password for a target user
     *
     * @param currentpass       user's current password
     * @param newpass           user's new password
     * @return true if password change is successful, else returns false.
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
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

    /**
     * Get all users in the database.
     *
     * @return ArrayList of User beans.
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
    public static ArrayList<UserJB> getAllUsers() throws SQLException {
        ArrayList<UserJB> userlist = new ArrayList<>();
        DatabaseUtils db = new DatabaseUtils();
        ResultSet rs = db.executeFixedQuery("select * from users");
        while (rs.next()) {
            userlist.add(initUser(rs));
        }
        db.closeConnection();
        return userlist;
    }

    /**
     * Search for a user via their UserID
     *
     * @param ID       UserID of the target user
     * @return UserJB if user is found, null if user is not found
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
    public static UserJB searchUserByID(int ID) throws SQLException {
        DatabaseUtils db = new DatabaseUtils();
        ResultSet rs = db.executeQuery("select * from users where ID=?", ID);
        if (rs.next()) {
            return initUser(rs);
        }
        db.closeConnection();
        return null;
    }

    /**
     * Search for a user via their username
     *
     * @param username       username of the target user
     * @return UserJB if user is found, null if user is not found
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
    public static UserJB searchUserByUsername(String username) throws SQLException {
        DatabaseUtils db = new DatabaseUtils();
        ResultSet rs = db.executeQuery("select * from users where username=?", username);
        if (rs.next()) {
            return initUser(rs);
        }
        db.closeConnection();
        return null;
    }

    /**
     * Search for a user via their email
     *
     * @param email       email of the target user
     * @return UserJB if user is found, null if user is not found
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
    public static UserJB searchUserByEmail(String email) throws SQLException {
        DatabaseUtils db = new DatabaseUtils();
        ResultSet rs = db.executeQuery("select * from users where email=?", email);
        if (rs.next()) {
            return initUser(rs);
        }
        db.closeConnection();
        return null;
    }

    /**
     * Search for a user via their contact number
     *
     * @param contact       contact number of the target user
     * @return UserJB if user is found, null if user is not found
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
    public static UserJB searchUserByContact(String contact) throws SQLException {
        DatabaseUtils db = new DatabaseUtils();
        ResultSet rs = db.executeQuery("select * from users where contact=?", contact);
        if (rs.next()) {
            return initUser(rs);
        }
        db.closeConnection();
        return null;
    }

    /**
     * Updates one column in target user's profile
     *
     * @param userid        userid of target user
     * @param column        the column that needs to be updated
     * @param newval        the new value of the column
     * @return boolean, true if update succeeded else returns false
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
    public static boolean updateProfile(int userid, String column, String newval) throws SQLException{
        DatabaseUtils db = new DatabaseUtils();
        int c = db.executeUpdate("update users set " + column + "=? where ID=?", newval, userid);
        db.closeConnection();
        return c == 1;
    }

    /**
     * Registers a new user
     *
     * @param username      username which will be used to login (must be unique)
     * @param name          name of user
     * @param email         email of user (must be unique)
     * @param contact       contact number of user (must be unique)
     * @param cardname      Full name on credit card
     * @param creditcard    credit card number of user
     * @param cvv           credit card's cvv
     * @param exp           credit card's expiry date in MM/YY format
     * @param password      User's password plaintext password, will be hashed using bcrypt
     *                      before inserting into database
     * @return boolean, true if registration succeeded else returns false
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
    public static boolean register(String username, String role, String name, String email, String contact,
                                   String cardname, String creditcard, String cvv, String exp, String password) throws SQLException {
        DatabaseUtils db = new DatabaseUtils();
        int count = db.executeUpdate("INSERT INTO users(username, role, name, email, contact, cardname, creditcard, cvv, exp, password) " +
                "VALUES (?,?,?,?,?,?,?,?,?,?)", username, role, name, email, contact, cardname, creditcard, cvv, exp, hashPassword(password));
        db.closeConnection();
        return count == 1;
    }
}
