package com.example.jdbc_example;

import javax.sql.DataSource;
import org.postgresql.ds.PGPoolingDataSource;

public class DataSourceConfig {

    private static DataSource dataSource;

    private DataSourceConfig() {

    }

    public static synchronized DataSource getDataSource() {

        if (dataSource == null) {
            dataSource = dataSource();
        }
        return dataSource;
    }

    public static synchronized DataSource dataSource() {

        if (dataSource == null) {
            PGPoolingDataSource dataSource1 = new PGPoolingDataSource();
            dataSource1.setDataSourceName("A Data Source");
            dataSource1.setServerNames(new String[]{"127.0.0.1"});
            dataSource1.setPortNumber(5433);
            dataSource1.setDatabaseName("online_store_db");
            dataSource1.setUser("postgres");
            dataSource1.setPassword("admin");
            dataSource1.setMaxConnections(10);

            dataSource = dataSource1;
        }

        return dataSource;
    }

}
