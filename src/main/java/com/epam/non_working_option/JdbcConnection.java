package com.epam.non_working_option;

import java.sql.*;
import java.util.Optional;

/**
 * Подключение к базе.
 */
public class JdbcConnection {

    private static Optional<Connection> connection = Optional.empty();
    final static String username = "postgres";
    final static String password = "zaks0462";
    final static String url = "jdbc:postgresql://localhost:5432/M6_Databases";

    public static Optional<Connection> getConnection() {
        if (connection.isEmpty()) {
            try {
                connection = Optional.ofNullable(DriverManager.getConnection(url, username, password));
                System.out.println("Connection success!");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return connection;
    }
}
