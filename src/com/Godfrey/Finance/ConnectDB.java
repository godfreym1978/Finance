package com.Godfrey.Finance;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;

public class ConnectDB {

	/* For Oracle 
	private static final String DB_DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String DB_CONNECTION = "jdbc:oracle:thin:@localhost:1521:XE";
	private static final String DB_USER = "system";
	private static final String DB_PASSWORD = "passw1rd";
	*/

	/* For mysql */ 
	private static final String DB_DRIVER = "com.mysql.jdbc.Driver";
	private static final String DB_CONNECTION = "jdbc:mysql://localhost:3306/finance?useSSL=false";
	private static final String DB_USER = "root";
	private static final String DB_PASSWORD = "passw0rd";
	
	
	public Connection getDBConnection() {

		Connection dbConnection = null;

		try {

			Class.forName(DB_DRIVER);

		} catch (ClassNotFoundException e) {

			System.out.println(e.getMessage());

		}

		try {

			dbConnection = DriverManager.getConnection(DB_CONNECTION, DB_USER, DB_PASSWORD);
			return dbConnection;

		} catch (SQLException e) {

			System.out.println(e.getMessage());

		}

		return dbConnection;

	}
}
