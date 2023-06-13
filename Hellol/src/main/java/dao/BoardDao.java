package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import common.DBConnPool;
import dto.Board;

public class BoardDao {
	
	public BoardDao() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * 게시글을 조회합니다
	 * @return boardList
	 */
	public List<Board> getList() {
		List<Board> boardList = new ArrayList<Board>();
		String sql= "select * from board order by num desc";
		
		try (Connection conn =  DBConnPool.getConnection();
				Statement stmt = conn.createStatement();){
			ResultSet rs =stmt.executeQuery(sql);
			
			// 게시글의 수만큼 보드 객체를 생성해서 boardlist에 추가
			while(rs.next()) {
				// 게시물의 한 행을 DTO에 저장
				Board board = new Board();
				
				board.setNum(rs.getString("num"));
				board.setTitle(rs.getString("title"));
				board.setContent(rs.getString("content"));
				board.setId(rs.getString("id"));
				board.setPostdate(rs.getString("postdate"));
				board.setVisitcount(rs.getString("visitcount"));
				
				boardList.add(board);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("게시물 조회 중 예외 발생");
		}
		return boardList;
	}
	
	/**
	 * 게시물의 총 갯수를 반환
	 * @return totalCnt
	 */
	public int getToatlCnt() {
		int totalCnt = 0;
		String sql = "select count(*) from board order by num desc";
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			ResultSet rs = pstmt.executeQuery();
			
			rs.next();
			totalCnt = rs.getInt(1); // 첫번째 컬럼의 값을 반환
			rs.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("총 게시물의 수를 조회하던 중 예외가 발생하였습니다");
		}
		return totalCnt;
	}
	
}
