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
	
	/**
	 * 게시글 조회
	 * @return
	 */
	public List<MVCBoardDTO> getList(Criteria cri){
		List<MVCBoardDTO> list = new ArrayList<MVCBoardDTO>();
		MVCBoardDTO board = null;
		String sql = "select * from mvcboard ";
		
		if(cri.getSearchWord() != null && !"".equals(cri.getSearchWord())) {
			sql += " where "+ cri.getSearchField()+ " like '%"+cri.getSearchWord() +"%' ";
		}
		sql += " order by idx desc";

		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				board = new MVCBoardDTO();
				
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
	
	
	/**
	 * 페이징 된 게시글 조회
	 * @param cri
	 * @return
	 */
	public List<MVCBoardDTO> getListPage(Criteria cri){
		List<MVCBoardDTO> list = new ArrayList<MVCBoardDTO>();
		MVCBoardDTO board = null;
		
		String sql = "select * "
				+ "from( "
				+ "    select tb.*,  rownum rn "
				+ "    from( "
				+ "        select * "
				+ "        from mvcboard ";
		
		if(cri.getSearchWord() != null && !"".equals(cri.getSearchWord())) {
			sql += " where "+ cri.getSearchField()+ " like '%"+cri.getSearchWord() +"%' ";
		}
		sql += " order by idx desc "
				+ "    ) tb "
				+ " ) "
				+ " where rn between "+ cri.getStartNo()+" and "+ cri.getEndNo();

		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				board = new MVCBoardDTO();
				
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
	
	
	/**
	 * 게시글 갯수 조회
	 * @return
	 */
	public int getToatlCnt(Criteria criteria) {
		int totalCnt = 0;
		String sql= "select count(*) from mvcboard "; 
		
		if(criteria.getSearchWord() != null && !"".equals(criteria.getSearchWord())) {
			sql += "where " + criteria.getSearchField() + " like '%" + criteria.getSearchWord() + "%' ";
		}
		
		sql+=" order by idx desc";
			
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
	 * 목록 하나만 조회
	 * @param idx
	 * @return
	 */
	public MVCBoardDTO selectOne(String idx){
		MVCBoardDTO dto = new MVCBoardDTO();
		String sql = "select * from mvcboard where idx=?";
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, idx);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()){
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getString(5));
				dto.setOfile(rs.getString(6));
				dto.setSfile(rs.getString(7));
				dto.setDowncount(rs.getInt(8));
				dto.setPass(rs.getString(9));
				dto.setVisitcount(rs.getInt(10));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("선택한 게시글 조회 도중 오류가 발생하였습니다");
		}
		return dto;
	}
	
	

	/**
	 * 게시글 등록
	 * @param board
	 * @return
	 */
	public int insert(MVCBoardDTO board) {
		int res = 0;
		String sql ="insert into mvcboard (idx, name, title, content, ofile, sfile, pass) values (seq_board_num.nextval, ?, ?, ?, ?, ?, ?)";
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, board.getName());
			pstmt.setString(2, board.getTitle());
			pstmt.setString(3, board.getContent());
			pstmt.setString(4, board.getOfile());
			pstmt.setString(5, board.getSfile());
			pstmt.setString(6, board.getPass());
			
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("게시글 등록 중 오류 발생");
			e.printStackTrace();
		}
		return res;
	}
	
	
	/**
	 * 비밀번호 검증
	 * @param pass
	 * @param idx
	 * @return
	 */
	public boolean comfirmPassword(String pass, String idx) {
		boolean res = false;
		String sql = "select * from mvcboard where idx = ? and pass = ?";
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, idx);
			pstmt.setString(2, pass);
			
			ResultSet rs = pstmt.executeQuery();
			res = rs.next();  //있으면 true
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}

	
	/**
	 * 게시글 수정
	 * @param board
	 * @return
	 */
	public int update(MVCBoardDTO dto) {
		int res = 0;
		String sql = "update mvcboard set name = ?, title =?, content=?, ofile=?, sfile=? where idx =?";
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getOfile());
			pstmt.setString(5, dto.getSfile());
			pstmt.setString(6, dto.getIdx());
			
			res = pstmt.executeUpdate();
			System.out.println("res: "+ res);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}
	
	
	/**
	 * 삭제
	 * @param idx
	 * @return
	 */
	public int delete(String idx) {
		int res = 0;
		String sql = "delete from mvcboard where idx = ?";
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, idx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}
	

	
	/**
	 * 조회수 1 상승
	 * @param num
	 * @return
	 */
	public int updateVisitCount(String idx) {
		int res = 0;
		String sql = "update mvcboard set visitcount = visitcount+1 where idx= ?";
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, idx);
			res = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("조회수 오류가 발생했습니다");
		}
		return res;
	}
	
	
	/**
	 * 다운로드수 1 상승
	 * @param num
	 * @return
	 */
	public int updateDownCount(String idx) {
		int res = 0;
		String sql = "update mvcboard set downcount = downcount+1 where idx= ?";
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, idx);
			res = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("다운 오류가 발생했습니다");
		}
		return res;
	}
}
