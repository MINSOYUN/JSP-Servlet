package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletContext;
import javax.servlet.jsp.tagext.TryCatchFinally;

public class ConnectionUtil {

	public ConnectionUtil() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * DB Connection을 반환 합니다
	 * 드라이버 테스트
	 * @return
	 */
	public static Connection getConnection() {
		// 접속정보
		// ip, port, sid
		String url ="jdbc:oracle:thin:@localhost:1521:orcl";
		String id = "jsp";
		String pw = "1234";
		
		Connection conn = null;
		
		// 커넥션 생성
		try {
			// 1. 드라이버 로딩
			Class.forName("oracle.jdbc.driver.OracleDriver");
			// 2. 커넥션 생성
			conn = DriverManager.getConnection(url, id, pw);  // try-catch
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			System.err.println("라이브러리 도중 오류 발생");
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return conn;
		
	}
	
	/**
	 * web.xml 파일의 컨텍스트 초기화 매개변수를 읽어서 DB 접속 정보를 설정 
	 * @param application
	 * @return
	 */
	// ServletContext는 웹 애플리케이션의 컨텍스트 정보를 담고 있는 객체
	public static Connection getConnection(ServletContext application) {
		Connection conn = null;
		// 초기화 매개변수 -> 필수 지정
		String driver = application.getInitParameter("OracleDriver");
		String url = application.getInitParameter("OracleUrl");
		String id = application.getInitParameter("OracleId");
		String pw = application.getInitParameter("OraclePw");
		
		System.out.println(driver);
		System.out.println(url);
		System.out.println(id);
		System.out.println(pw);
		
		try {
			Class.forName(driver);  // driver에 지정된 JDBC 드라이버를 동적으로 로드
			conn = DriverManager.getConnection(url, id, pw);  // 데이터 베이스 연결
			
		} catch (ClassNotFoundException e) {
			System.err.println("라이브러리 로드 실패");
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return conn;
	}
	
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		String sql = "select to_char(sysdate, 'yyyy-mm-dd') today from dual";
		
		// 커넥션생성
		try (Connection con = getConnection();
				PreparedStatement psmt = con.prepareStatement(sql);){
			
			ResultSet rs = psmt.executeQuery();   // ResultSet으로 반환
			
			rs.next();
			String today = rs.getString(1);   // 첫번째 열의 문자값을 가져온다
			// rs.getString("today");
			System.out.println("오늘 날짜: " + today);
			
			rs.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void close(Connection conn) {
		try {
			if(conn != null && ! conn.isClosed()) conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
}


		public static void close(Connection conn, Statement stmt) {
			try {
				if(conn != null && ! conn.isClosed()) conn.close();
				if(stmt != null && ! stmt.isClosed()) stmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		public static void close(Connection conn, Statement stmt, ResultSet rs) {
			try {
				if(conn != null && ! conn.isClosed()) conn.close();
				if(stmt != null && ! stmt.isClosed()) stmt.close();
				if(rs != null && ! rs.isClosed()) rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}


}


