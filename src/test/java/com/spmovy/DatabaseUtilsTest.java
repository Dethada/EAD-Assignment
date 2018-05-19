package com.spmovy;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.sql.ResultSet;

import static org.junit.Assert.*;

public class DatabaseUtilsTest {
    DatabaseUtils db;
    int id;
    @Before
    public void setUp() throws Exception {
        this.db = new DatabaseUtils();
    }

    @Test
    public void executeQuery() throws Exception {
        ResultSet rs = this.db.executeQuery("SELECT * FROM Genre WHERE name=?", "Action");
        assertTrue(rs.next());
    }

    @Test
    public void executeUpdate() throws Exception {
        assertEquals(this.db.executeUpdate("INSERT INTO Genre(name, description) VALUES(?,?)", "unittesting", "unittesting"), 1);
        assertEquals(this.db.executeUpdate("DELETE FROM Genre WHERE name=? AND description=?", "unittesting", "unittesting"), 1);
    }

    @Test
    public void executeFixedQuery()throws Exception {
        ResultSet rs = this.db.executeFixedQuery("SELECT ID FROM Genre where name=\'Action\'");
        assertTrue(rs.next());
        this.id = rs.getInt("ID");
    }

    @Test
    public void getConnection() {
        assertNotNull(this.db.getConnection());
    }

    @After
    public void tearDown() {
        this.db.closeConnection();
    }
}