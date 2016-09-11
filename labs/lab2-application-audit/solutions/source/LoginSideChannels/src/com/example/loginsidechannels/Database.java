package com.example.loginsidechannels;

import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class Database {

	private static final String url = "jdbc:mysql://localhost:3306";
	private static final String dbuser = "root";
	private static final String dbpass = "badpass";
	
	private Connection connection;

	private Database(Connection connection) throws SQLException {
		this.connection = connection;
	}
	
	private void init() throws SQLException, NoSuchAlgorithmException {
		String createDatabaseSQL = "CREATE DATABASE webdb;";
		Statement statement = connection.createStatement();
		statement.execute(createDatabaseSQL);
		statement.close();

		String createTableSQL = "CREATE TABLE webdb.users (Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, Email VARCHAR(50) NOT NULL, Role VARCHAR(10) NOT NULL, Password CHAR(128) NOT NULL, Salt CHAR(128) NOT NULL, UNIQUE(Email));";
		statement = connection.createStatement();
		statement.execute(createTableSQL);
		statement.close();
		
		String salt = AuthUtils.generateSalt();
		String password = AuthUtils.hash("badpass", salt);
		String insertAdminSQL = "INSERT INTO webdb.users (Email, Role, Password, Salt) values ('admin@example.com', 'admin', '" + password + "', '" + salt + "');";
		statement = connection.createStatement();
		statement.execute(insertAdminSQL);
		statement.close();
	}
	
	public Connection getConnection() {
		return connection;
	}
	
	public void close() throws SQLException{
		connection.close();
	}
	
	public static Database getInstance() throws ClassNotFoundException, SQLException, NoSuchAlgorithmException {
		Class.forName("com.mysql.jdbc.Driver");
		try {
			return new Database(DriverManager.getConnection(url + "/webdb", dbuser, dbpass));
		} catch (Exception e){
			// database may not be initialized yet
			Database database =  new Database(DriverManager.getConnection(url + "/", dbuser, dbpass));
			database.init();
			return database;
		}
	}
	
}
