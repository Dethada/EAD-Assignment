package com.spmovy;

import java.sql.*;

/**
 * This class is a helper class for database connections and executing sql queries and updates.
 *
 * @Author David
 */

public class DatabaseUtils {

    private Connection connection;

    /**
     * Attempts to initiate database connection
     *
     * @throws SQLException if connection failed
     */
    public DatabaseUtils() throws SQLException {
        String driverName = "com.mysql.jdbc.Driver";
        try {
            Class.forName(driverName);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        String url = "jdbc:mysql://<mysqlserver>/<dbname>?autoReconnect=true&verifyServerCertificate=false&useSSL=true&useUnicode=true&characterEncoding=UTF-8";
        this.connection = DriverManager.getConnection(url, "<username>", "<password>");
    }

    /**
     * Prepares the prepared statement by setting values automatically.
     *
     * @param sql    The sql string for the prepared statement
     * @param values The values to be inserted into the prepared statement.
     * @return PreparedStatement - Prepared statement with values inserted.
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
    private PreparedStatement prepare(String sql, Object... values) throws SQLException {
        PreparedStatement preparedStatement = this.connection.prepareStatement(sql);

        for (int i = 0; i < values.length; i++) {
            if (values[i] instanceof Integer) {
                preparedStatement.setInt(i + 1, (Integer) values[i]);
            } else if (values[i] instanceof String) {
                preparedStatement.setString(i + 1, (String) values[i]);
            } else if (values[i] instanceof Time) {
                preparedStatement.setTime(i + 1, (Time) values[i]);
            } else if (values[i] instanceof Timestamp) {
                preparedStatement.setTimestamp(i + 1, (Timestamp) values[i]);
            } else if (values[i] instanceof Date) {
                preparedStatement.setDate(i + 1, (Date) values[i]);
            } else {
                preparedStatement.setObject(i + 1, values[i]);
            }
        }
        return preparedStatement;
    }

    /**
     * Executes a sql query using prepared statements.
     *
     * @param sql    The sql string for the prepared statement
     * @param values The values to be inserted into the prepared statement.
     * @return ResultSet - ResultSet of the query
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
    public ResultSet executeQuery(String sql, Object... values) throws SQLException {
        return prepare(sql, values).executeQuery();
    }

    /**
     * Executes a sql update using prepared statements.
     *
     * @param sql    The sql string for the prepared statement
     * @param values The values to be inserted into the prepared statement.
     * @return int - Number of rows updated
     * @throws SQLException if invalid sql string/values are provided or database connection is down
     */
    public int executeUpdate(String sql, Object... values) throws SQLException {
        return prepare(sql, values).executeUpdate();
    }

    /**
     * Executes a sql query using raw sql string, only to be used when no variable is being used in the sql string.
     *
     * @param sql The sql query string to be executed
     * @return ResultSet - ResultSet of the query
     * @throws SQLException if invalid sql string is provided or database connection is down
     */
    public ResultSet executeFixedQuery(String sql) throws SQLException {
        Statement stmt = this.connection.createStatement();
        return stmt.executeQuery(sql);
    }

    /**
     * Deletes an object by calling a delete procedure.
     *
     * @param table The table to delete the object from
     * @param id    The ID of the object to be deleted
     * @return ResultSet - ResultSet of the query
     * @throws SQLException if invalid id or table is provided or database connection is down
     */
    public void callDelete(String table, int id) throws SQLException {
        CallableStatement stmt = connection.prepareCall("{CALL deleteProcedure(?, ?)}");
        stmt.setString(1, table);
        stmt.setInt(2, id);
        stmt.execute();
    }

    /**
     * Returns the current database connection
     *
     * @return Connection - The current database connection
     */
    public Connection getConnection() {
        return this.connection;
    }

    /**
     * Closes the database connection.
     */
    public void closeConnection() {
        try {
            this.connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
