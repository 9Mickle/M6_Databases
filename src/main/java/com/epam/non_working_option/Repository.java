package com.epam.non_working_option;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Optional;
import java.util.concurrent.*;

/**
 * Класс для взаимодействия с базой.
 */
public class Repository {

    private final Optional<Connection> connection;

    public Repository() {
        this.connection = JdbcConnection.getConnection();
    }

    public Optional<Boolean> addNewStudent(String name, String surname) {
        return connection.flatMap(conn -> {
            String sqlInsert = "Insert Into student(name, surname) Values(?, ?)";
            Optional<Boolean> status = Optional.of(false);
            try (PreparedStatement statement = conn.prepareStatement(sqlInsert)) {
                statement.setString(1, name);
                statement.setString(2, surname);
                statement.executeUpdate();
                status = Optional.of(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return status;
        });
    }

    /**
     * Метод, цель которого получить Dirty Read.
     *
     * Метод для проведения транзакции на получения не правильного имени пользователя.
     *
     * Сначала обновляем имя пользователя на Unknown, запускаем другую транзацию, которая сделает Select
     * пользовтеля по id и отдаст нам неверное имя пользователя (Unknown).
     *
     * И делаем RollBack() чтобы вернуть прежнее имя пользователя.
     *
     * Но это почему-то не работает(
     * @param id ид пользователя.
     * @return Dirty Read.
     */
    public Optional<String> getStudentById(int id) {
        ExecutorService executorService = Executors.newFixedThreadPool(1);
        return connection.flatMap(conn -> {
            Optional<String> result = Optional.empty();

            try (Statement statement = conn.createStatement()) {

                conn.setAutoCommit(false);
                conn.setTransactionIsolation(Connection.TRANSACTION_READ_UNCOMMITTED);

                statement.execute("Update student Set name = 'Unknown' Where id = " + id);

                Future<Optional<String>> future = executorService.submit(new OtherTransaction(id));
                result = future.get();
                conn.rollback();

                return result;
            } catch (SQLException | ExecutionException | InterruptedException e) {
                e.printStackTrace();
            } finally {
                executorService.shutdown();
            }
            return result;
        });
    }
}
