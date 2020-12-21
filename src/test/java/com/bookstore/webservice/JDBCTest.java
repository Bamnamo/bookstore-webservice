package com.bookstore.webservice;


import org.junit.jupiter.api.Test;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

public class JDBCTest {
    static {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void testConnection() {
        try (Connection con = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:XE",
                "shiva",
                "ship"
        )) {
            System.out.println(con);
        } catch (Exception e) {
            fail(e.getMessage());
        }
    }
}
