package com.library.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.library.common.DBConnPool;
import com.library.vo.Basket;
import com.library.vo.Book;
import com.library.vo.Criteria;
import com.library.vo.Member;

public class UserDao {
	
	
	
	/**
	 * 내 정보 수정
	 * @param member
	 * @return
	 */
	public int updateUser(Member member) {
		int res = 0;
		String sql = "update member set id=?, pw= ?, name=?, info=? where id=?";
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPw());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getInfo());
			pstmt.setString(5, member.getId());
			
			res = pstmt.executeUpdate();
			System.out.println("res: "+ res);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}

	
	/**
	 * 장바구니에 담기
	 * @return
	 */
	public int basket(String no) {
		int res = 0;
		
		String sql = String.format
						(" INSERT INTO 장바구니 (no, sfile, title, author, publisher) "
								+ " SELECT b.no, b.sfile, b.title, b.author, b.publisher "
								+ " FROM book b "
								+ " WHERE b.no = %s ", no);
		
		try (Connection conn = DBConnPool.getConnection();
				Statement stmt = conn.createStatement();	){
			res = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("결과:"+res);
		return res;
	}

	
	/**
	 * 장바구니 목록 조회
	 * @return
	 */
	public List<Basket> getList(Criteria cri) {
		List<Basket> list = new ArrayList<Basket>();
		
		String sql = 
				"select * from ( "
				+ " select t.*, rownum rn from ( "
				+ " select * "
				+ "from 장바구니";
		
		if(cri.getSearchWord() != null && !"".equals(cri.getSearchWord())) {
			sql += "where " + cri.getSearchField() + " like '%" + cri.getSearchWord()+ "%' ";
		}
		sql += " ) t "
				+") "
				+"where rn between " + cri.getStartNo() + " and " + cri.getEndNo();

		try (Connection conn = DBConnPool.getConnection();
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql)){
			while(rs.next()) {
				String no = rs.getString(1);
				String sfile = rs.getString(2);
				String title = rs.getString(3);
				String author = rs.getString(4);
				String publisher = rs.getString(5);
				String regidate = rs.getString(6);
				
				Basket basket = new Basket(no, sfile, title, author, publisher, regidate);
				list.add(basket);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}

}
