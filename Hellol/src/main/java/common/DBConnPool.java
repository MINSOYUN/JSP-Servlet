package common;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBConnPool {

	public DBConnPool() {
		// TODO Auto-generated constructor stub
	}
	
	public static Connection getConnection() {
		Connection conn = null;
		
		// 커넥션 풀 생성
		Context initContext;
		try {
			initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/myoracle");
			// 커넥션 풀을 통해 연결 하기
			conn = ds.getConnection();
		} catch (NamingException e) {
			e.printStackTrace();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		
		return conn;
	}
	
	public static void close(Connection conn) {
			try {
				if(conn != null && ! conn.isClosed()) conn.close();
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
	}
	
	
	public static void close(Connection conn, Statement stmt) {
		try {
			if(conn != null && ! conn.isClosed()) conn.close();
			if(stmt != null && ! stmt.isClosed()) stmt.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
}
	
	public static void close(Connection conn, Statement stmt, ResultSet rs) {
		try {
			if(conn != null && ! conn.isClosed()) conn.close();
			if(stmt != null && ! stmt.isClosed()) stmt.close();
			if(rs != null && ! rs.isClosed()) rs.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
}
	
}
