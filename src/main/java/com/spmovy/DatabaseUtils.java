package com.spmovy;

import java.sql.*;

public class DatabaseUtils {

    private Connection connection;

    public DatabaseUtils() {
        String driverName = "com.mysql.jdbc.Driver";
        try {
            Class.forName(driverName);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        String url = "jdbc:mysql://52.74.214.114/spmovy?autoReconnect=true&verifyServerCertificate=false&useSSL=true";
        try {
            this.connection = DriverManager.getConnection(url, "spmovy", "15Pb6pc%$8!@P^NR$h@5rLM84gJvR2u1p72F^3");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    private PreparedStatement prepare(String sql, Object ... values) {
        try {
            PreparedStatement preparedStatement = this.connection.prepareStatement(sql);

            for (int i = 0; i < values.length; i++) {
                if (values[i] instanceof Integer) {
                    preparedStatement.setInt(i + 1, (Integer) values[i]);
                }
                else if (values[i] instanceof String) {
                    preparedStatement.setString(i + 1, (String) values[i]);
                }
                else if (values[i] instanceof Time) {
                    preparedStatement.setTime(i + 1, (Time) values[i]);
                }
                else if (values[i] instanceof Timestamp) {
                    preparedStatement.setTimestamp(i + 1, (Timestamp) values[i]);
                }
                else if (values[i] instanceof Date) {
                    preparedStatement.setDate(i + 1, (Date) values[i]);
                }
                else {
                    preparedStatement.setObject(i + 1, values[i]);
                }
            }
            return preparedStatement;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public ResultSet executeQuery(String sql, Object ... values) {
        try {
            return prepare(sql, values).executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int executeUpdate(String sql, Object ... values) {
        try {
            return prepare(sql, values).executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public ResultSet executeFixedQuery(String sql) {
        try {
            Statement stmt = this.connection.createStatement();
            return stmt.executeQuery(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void callDelete(String table, int id) {
        try {
            CallableStatement stmt = connection.prepareCall("{CALL deleteProcedure(?, ?)}");
            stmt.setString(1, table);
            stmt.setInt(2, id);
            stmt.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Connection getConnection() {
        return this.connection;
    }

    public void closeConnection() {
        try {
            this.connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
