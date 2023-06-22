package model2.mvcboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.DBConnPool;
import dao.Criteria;

public class MVCBoardDAO {

	public MVCBoardDAO() {
		// TODO Auto-generated constructor stub
	}
	
	MVCBoardDTO board = new MVCBoardDTO();
	
	// 게시판 조회
	public List<MVCBoardDTO> getList(){
		List<MVCBoardDTO> list = new ArrayList<MVCBoardDTO>();
		String sql = "select * from mvcboard order by idx desc";

		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				board.setIdx(rs.getString(1));
				board.setName(rs.getString(2));
				board.setTitle(rs.getString(3));
				board.setContent(rs.getString(4));
				board.setPostdate(rs.getString(5));
				board.setOfile(rs.getString(6));
				board.setSfile(rs.getString(7));
				board.setDowncount(rs.getInt(8));
				board.setPass(rs.getString(9));
				board.setVisitcount(rs.getInt(10));
				
				list.add(board);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	
	// 검색 조건에 맞는 게시판 갯수 조회
	public int totalCount() {
		int totalCnt = 0;
		String sql = "select * from mvcboard ";
			
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			totalCnt = rs.getInt(1);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return totalCnt;
	}
}
