package dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.DBConnPool;
import dto.Board;

public class NewBoardDao {

	public NewBoardDao() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * 게시글을 얻어옵니다
	 * @return
	 */
	public List<Board> getList(Criteria criteria){
		Board board = null;
		List<Board> list = new ArrayList<>();
		String sql = "select num,title, content, id, decode(trunc(sysdate), trunc(postdate), to_char(postdate, 'hh24:mi:ss'), to_char(postdate,'yyyy-mm-dd')) postdate, visitcount from board ";
		
		// 검색어가 입력된 경우 검색 조건을 추가합니다
		if(criteria.getSearchWord() != null && !"".equals(criteria.getSearchWord())) {
			sql += " where "+ criteria.getSearchField()+ " like '%"+criteria.getSearchWord() +"%' ";
		}
		sql += "order by num desc";
		System.out.println(sql);

		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt =  conn.prepareStatement(sql);){
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				board = new Board();
				board.setNum(rs.getString("num"));
				board.setTitle(rs.getString("title"));
				board.setContent(rs.getString("content"));
				board.setId(rs.getString("id"));
				board.setPostdate(rs.getString("postdate"));
				board.setVisitcount(rs.getString("visitcount"));
				
				list.add(board);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	
	/**
	 * 페이징된 게시글 조회
	 */
	// 페이징된 게시판 sql 문장이 앞 뒤로 실행된다
	// 검색어가 입력된 경우 검색 조건을 추가합니다
	public List<Board> getListPage(Criteria criteria){
		Board board = null;
		List<Board> list = new ArrayList<>();
		String sql = "select * from( "
				+ " select rownum rn, t.* "
			    + " from( "
			    + " select num, title, content, id, "
			    + " decode(trunc(sysdate), trunc(postdate), to_char(postdate, 'hh24:mi:ss'), to_char(postdate,'yyyy-mm-dd')) postdate, "
			    +  " visitcount "
			    +    " from board ";
		if(criteria.getSearchWord() != null && !"".equals(criteria.getSearchWord())) {
			sql += " where "+ criteria.getSearchField()+ " like '%"+criteria.getSearchWord() +"%' ";
		}
		sql += " order by num desc "
				+ "     ) t "
				+ " ) "
				+ " where rn between "+ criteria.getStartNo() + " and "+criteria.getEndNo();

		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt =  conn.prepareStatement(sql);){
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				board = new Board();
				board.setNum(rs.getString("num"));
				board.setTitle(rs.getString("title"));
				board.setContent(rs.getString("content"));
				board.setId(rs.getString("id"));
				board.setPostdate(rs.getString("postdate"));
				board.setVisitcount(rs.getString("visitcount"));
				
				list.add(board);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	
	/**
	 * 게시글 1건 조회 합니다
	 * @param num
	 * @return
	 */
	public Board selectOne(String num) {
		Board board = null;
		String sql = "select * from board where num= ?";
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			
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
			System.out.println("게시글 1건 조회 도중 오류가 발생하였습니다");
		}
		return board;
	}
	
	
	/**
	 * 게시글을 등록합니다
	 * @param board
	 * @return
	 */
	public int insert(Board board) {
		int res = 0;
		String sql = "insert into board values(seq_board_num.nextval, ?, ?, ?, sysdate, 0)";
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getContent());
			pstmt.setString(3, board.getId());
			
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("게시글 등록 도중 오류가 발생하였습니다");
			e.printStackTrace();
		}
		return res;
	}
	
	
	/**
	 * 게시글의 총 갯수를 반환합니다
	 * @return
	 */
	public int getTotalCnt(Criteria criteria) {
		int totalCnt = 0;
		String sql = "select count(*) from board ";
		
		if(criteria.getSearchWord() != null && !"".equals(criteria.getSearchWord())) {
			sql += "where " + criteria.getSearchField()+ " like '%" + criteria.getSearchWord() + "%'";
		}
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			ResultSet rs = pstmt.executeQuery();
			
			rs.next();
			totalCnt = rs.getInt(1);
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("게시글 개수를 조회하던 중 오류가 발생하였습니다");
		}
		return totalCnt;
	}
	
	
	/**
	 * 게시글을 수정합니다
	 * @param num
	 * @return
	 */
	public int update(Board board) {
		int res = 0;
		String sql = "update board set title=?, content=? where num= ?";
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getContent());
			pstmt.setString(3, board.getNum());
			
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
		String sql = "delete from board where num = ? ";
		
		try(Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, num);
			res = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("게시글 삭제 도중 오류가 발생하였습니다");
		}
		
		return res;
	}
	
	
	/**
	 * 조회수 1 상승
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
			System.out.println("조회수 오류가 발생했습니다");
		}
		return res;
	}
	
}
