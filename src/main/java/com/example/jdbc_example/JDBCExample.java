package com.example.jdbc_example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;

/**
 * DriverManager, DataSource
 * <p>
 * Connection
 * <p>
 * Statement, PreparedStatement
 * <p>
 * Основная разница между Statement и PreparedStatement заключается в том, что PreparedStatement предварительно
 * компилирует запрос в базе данных и кэширует его, что позволяет повторно использовать запросы с разными значениями
 * параметров. Это может существенно улучшить производительность при многократном выполнении запроса с различными
 * параметрами. Кроме того, PreparedStatement защищает от SQL-инъекций, т.к. значения параметров не могут быть
 * интерпретированы как код SQL-запроса.
 * <p>
 * ResultSet
 * <p>
 * Connection pool - пул коннекшнов
 */
public class JDBCExample {


    public static void main(String[] args) {

        JDBCExample main = new JDBCExample();
//        main.selectExampleWithDriverManager();
//        main.selectExampleWithDriverManagerWithParams("Emil' OR name = 'Amir"); // sql injection
//        main.selectExampleWithDataSource();
//        main.updateExample();

//        main.selectExampleWithDataSourceAndPreparedStatement("Emil");

        main.transactionExampleV2();
    }

    public void selectExampleWithDriverManager() {

        try (Connection connection = getConnection();
            Statement statement = connection.createStatement()) {

            ResultSet resultSet = statement.executeQuery("SELECT id, name, balance FROM employee");

            List<Employee> employees = new ArrayList<>();

            while (resultSet.next()) {

                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                double balance = resultSet.getDouble("balance");

                Employee employee = new Employee(id, name, balance);

                employees.add(employee);
            }

            System.out.println(employees);

        } catch (SQLException e) {

        }
    }

    public void selectExampleWithDriverManagerWithParams(String userName) {

        try (Connection connection = getConnection();
            Statement statement = connection.createStatement()) {

            ResultSet resultSet = statement.executeQuery(
                "SELECT id, name, balance FROM employee WHERE name = '" + userName + "'");

            List<Employee> employees = new ArrayList<>();

            while (resultSet.next()) {

                int userId = resultSet.getInt("id");
                String name = resultSet.getString("name");
                double balance = resultSet.getDouble("balance");

                Employee employee = new Employee(userId, name, balance);

                employees.add(employee);
            }

            System.out.println(employees);

        } catch (SQLException e) {

        }
    }

    private static Connection getConnection() throws SQLException {

        return DriverManager.getConnection(
            "jdbc:postgresql://127.0.0.1:5433/online_store_db", "postgres", "admin");
    }

    public void selectExampleWithDataSource() {

        DataSource dataSource = DataSourceConfig.dataSource();
        try (Connection connection = dataSource.getConnection();
            Statement statement = connection.createStatement()) {

            ResultSet resultSet = statement.executeQuery("SELECT id, name, balance FROM employee");

            List<Employee> employees = new ArrayList<>();

            while (resultSet.next()) {

                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                double balance = resultSet.getDouble("balance");

                Employee employee = new Employee(id, name, balance);

                employees.add(employee);
            }

            System.out.println(employees);

        } catch (SQLException e) {

        }
    }

    public void updateExample() {

        DataSource dataSource = DataSourceConfig.dataSource();
        try (Connection connection = dataSource.getConnection();
            Statement statement = connection.createStatement()) {

            statement.executeUpdate("UPDATE employee SET balance = 50 WHERE id = 1");

        } catch (SQLException e) {

        }
    }

    public void selectExampleWithDataSourceAndPreparedStatement(String userName) {

        DataSource dataSource = DataSourceConfig.dataSource();
        try (Connection connection = dataSource.getConnection();
            PreparedStatement statement = connection.prepareStatement(
                "SELECT id, name, balance FROM employee WHERE name = ?")) {

            statement.setString(1, userName);
            ResultSet resultSet = statement.executeQuery();

            List<Employee> employees = new ArrayList<>();

            while (resultSet.next()) {

                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                double balance = resultSet.getDouble("balance");

                Employee employee = new Employee(id, name, balance);

                employees.add(employee);
            }

            System.out.println(employees);

        } catch (SQLException e) {

        }
    }

    public void transactionExampleV1() {

        DataSource dataSource = DataSourceConfig.dataSource();
        try (Connection connection = dataSource.getConnection();
            Statement statement = connection.createStatement()) {
            connection.setAutoCommit(false);

            statement.executeUpdate("UPDATE employee SET balance = balance - 50 WHERE name = 'Emil'");

            if (true) {
                throw new RuntimeException("error");
            }
            statement.executeUpdate("UPDATE employee SET balance = balance + 50 WHERE name = 'Amir'");

            connection.commit();
        } catch (SQLException e) {

        }
    }

    public void transactionExampleV2() {

        DataSource dataSource = DataSourceConfig.dataSource();
        try (Connection connection = dataSource.getConnection()) {
            connection.setAutoCommit(false);

            try (Statement statement = connection.createStatement()) {

                statement.executeUpdate("UPDATE employee SET balance = balance - 50 WHERE name = 'Emil'");
//
//                    if (true) {
//                        throw new RuntimeException("error");
//                    }
                statement.executeUpdate("UPDATE employee SET balance = balance + 50 WHERE name = 'Amir'");

                connection.commit();
            } catch (SQLException e) {
                connection.rollback();

            } finally {
                connection.setAutoCommit(true);
            }

        } catch (SQLException e) {

        }
    }


}
