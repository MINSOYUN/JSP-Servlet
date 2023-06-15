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
	
	Board board = new Board();
	
	
	/**
	 * 게시글을 조회합니다
	 * @param searchFiled : 검색조건
	 * @param searchWord : 검색어
	 * @return boardList
	 */
	public List<Board> getList(String searchFiled, String searchWord) {
		Board board = null;
		List<Board> boardList = new ArrayList<Board>();
		String sql= "select * from board ";   // 한번 끊기
		
		// 검색어가 입력 되었으면 검색 조건을 추가
		if(searchWord != null && !"".equals(searchWord)) {
			sql += "where " + searchFiled + " like '%" + searchWord + "%' ";
		}
			sql += "order by num desc";
			
		try (Connection conn =  DBConnPool.getConnection();
				Statement stmt = conn.createStatement();){
			ResultSet rs =stmt.executeQuery(sql);
			
			// 게시글의 수만큼 보드 객체를 생성해서 boardlist에 추가
			while(rs.next()) {
				// 게시물의 한 행을 DTO에 저장
				board = new Board();
				
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
	public int getToatlCnt(String searchFiled, String searchWord) {
		int totalCnt = 0;
		String sql= "select count(*) from board "; 
		
		if(searchWord != null && !"".equals(searchWord)) {
			sql += "where " + searchFiled + " like '%" + searchWord + "%' ";
		}
			
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
	
	
	/**
	 * 게시글을 등록 합니다
	 */
	public int insert(Board board) {
		int res = 0;
		String sql = "insert into board  (num, title, content, id, postdate, visitcount) "
				+ "	values (seq_board_num.nextval, ?, ?, ?, sysdate, 0)";
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			
			// insert, update, delete 실행 후 몇건이 처리되었는지 반환
			// request 도 아닌 " 도 아닌 baord.getTitle인 이유
			 	pstmt.setString(1, board.getTitle());
			 	pstmt.setString(2, board.getContent());
			 	pstmt.setString(3, board.getId());
			
			 	res = pstmt.executeUpdate();
			 	
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("게시글 등록 도중 오류가 발생하였습니다");
		}
		return res;
	}
	
	
	/**
	 * 게시글 1건 조회합니다
	 * @param num
	 * @return
	 */
	public Board selectOne(String num) {
		Board board = null; // 반환 예정 -> 위에서 생성
		String sql = "select * from  board where num = ?";
		
		if(num == null || "".equals(num)) {
			return null;
		}
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, num);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				board = new Board();
				board.setNum(rs.getString("num"));
				board.setTitle(rs.getString("title"));
				board.setContent(rs.getString("content"));
				board.setId(rs.getString("id"));
				board.setPostdate(rs.getString("postdate"));
				board.setVisitcount(rs.getString("visitcount"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("게시글 조회 도중 오류가 발생하였습니다");
		}
		return board;
	}
	
	
	/**
	 * 게시글의 조회수를 1 증가시킵니다
	 * @param num
	 * @return
	 */
	public int updateVisitCount(String num) {
		int res = 0;
		String sql = "update board set visitcount = visitcount+1 where num= ?"; 
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, num);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("게시글 불러오는 도중 조회수 에러가 발생하였습니다");
		}
		return res;
	}
	
	
	/**
	 * 게시글을 수정합니다
	 * @param board
	 * @return
	 */
	public int update(Board board) {
		int res = 0;
		String sql ="update board set title= ? , content =? where num=? ";
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getContent());
			pstmt.setString(3, board.getNum());
			
			res = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("게시글 수정 도중 오류가 발생하였습니다");
		}
		return res;
	}
	
	
	/**
	 * 게시글을 삭제합니다
	 * @param num
	 * @return
	 */
	public int delete(String num) {
		int res = 0;
		String sql = "delete from board where num=? ";
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, num);
			
			res = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}
	
	
}
