package com.epam.working;

import java.sql.*;

/**
 * Перед запуском нужно занести одну запись в таблицу с id = 1.
 */
public class App {
    private final static String username = "postgres";
    private final static String password = "zaks0462";
    private final static String url = "jdbc:postgresql://localhost:5432/M6_Databases";

    public static void main(String[] args) {

        String sql = "Update student Set name = 'Unknown' Where id = 1";

        try (Connection connection = DriverManager.getConnection(url, username, password);
             Statement statement = connection.createStatement()) {

            connection.setAutoCommit(false);
            connection.setTransactionIsolation(Connection.TRANSACTION_READ_UNCOMMITTED);

            //Обновляем имя пользователя на Unknown.
            statement.executeUpdate(sql);
            //Даем новой транзакции прочитать обновленные данные и вывести результат.
            new OtherTransaction().start();
            //Откатываем изменение имени.
            connection.rollback();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    static class OtherTransaction extends Thread {

        @Override
        public void run() {
            try (Connection connection = DriverManager.getConnection(url, username, password);
                 Statement statement = connection.createStatement()) {

                connection.setAutoCommit(false);
                connection.setTransactionIsolation(Connection.TRANSACTION_READ_UNCOMMITTED);
                ResultSet resultSet = statement.executeQuery("Select * From student");

                if (resultSet.next()) {
                    System.out.println(resultSet.getString("name") + " " +
                            resultSet.getString("surname"));
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
