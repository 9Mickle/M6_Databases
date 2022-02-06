package com.epam.non_working_option;

import java.sql.*;
import java.util.Optional;
import java.util.concurrent.Callable;

/**
 * Создаем новую транзакцию с новым подключение к базе.
 * Цель - прочесть изменненые данные и вернуть результат.
 */
public class OtherTransaction implements Callable<Optional<String>> {

    private final int studentId;

    public OtherTransaction(int studentId) {
        this.studentId = studentId;
    }

    @Override
    public Optional<String> call() {
        Optional<String> result = Optional.empty();
        try (Connection connection = DriverManager.getConnection(JdbcConnection.url, JdbcConnection.username, JdbcConnection.password);
             Statement statement = connection.createStatement()) {

            connection.setAutoCommit(false);
            connection.setTransactionIsolation(Connection.TRANSACTION_READ_UNCOMMITTED);

            ResultSet resultSet = statement.executeQuery("Select * From student Where id = " + studentId);
            if (resultSet.next()) {
                result = Optional.of(resultSet.getString("name") +
                        " " + resultSet.getString("surname"));
                return result;
            }
        } catch (
                SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
}
