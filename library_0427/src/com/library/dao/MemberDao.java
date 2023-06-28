package com.library.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.library.common.DBConnPool;
import com.library.vo.Book;
import com.library.vo.Criteria;
import com.library.vo.Member;

public class MemberDao {
	/**
	 * 사용자 로그인
	 * @param id
	 * @param pw
	 * @return
	 */
	public Member login(String id, String pw) {
		Member member = null;
		
		String sql = 
				String.format("select id, name, adminyn, status, grade from member "
				+ "where id='%s' and pw='%s'",id,pw);
		
		// 쿼리 출력
		// System.out.println(sql);
		
		try (Connection conn = DBConnPool.getConnection();
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql);){
			// 질의결과 결과집합을 member객체에 담아줍니다
			if(rs.next()) {
				String name = rs.getString(2);
				String adminYN = rs.getString(3);
				String status = rs.getString(4);
				String grade = rs.getString(5);
				
				member = new Member(id, "", name, adminYN, status, grade);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return member;
	}
	
	
	/**
	 * 멤버 추가
	 * @param member
	 * @return
	 */
	public int insert(Member member) {
		int res = 0;
		String sql = String.format(
				"INSERT INTO MEMBER (id, pw, name, ofile, sfile)  VALUES "
				+ "('%s','%s','%s','%s', '%s')"
				, member.getId(), member.getPw()
				, member.getName(), member.getOfile(), member.getSfile());
		
		System.out.println(sql);
		try (Connection conn = DBConnPool.getConnection();
				Statement stmt = conn.createStatement();){
			res = stmt.executeUpdate(sql);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return res;
		
	}
	
	/**
	 * 아이디 중복 체크
	 * 중복일경우 false리턴
	 * 
	 * @param id
	 * @return
	 */
	public boolean idCheck(String id) {
		boolean res = false;
		
		String sql = String.format(
				"select * from member where id = '%s'",id);
		System.out.println(sql);
		try (Connection conn = DBConnPool.getConnection();
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql);){
			
			// rs.next = 결과집합이 있으면 true -> !rs.next를 반환
			return !rs.next();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		return res;
	}
	
	
	/**
	 * 멤버 삭제
	 * @param id
	 * @return
	 */
	public int delete(String id) {
		int res = 0;
		
		String sql = String.format
				("delete from member where id in ('%s')",id);
		
		
		try (Connection conn = DBConnPool.getConnection();
				Statement stmt = conn.createStatement();){
			
			res = stmt.executeUpdate(sql);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return res;
	}
	
	
	
	/**
	 * 멤버 조회
	 * @param cri
	 * @return
	 */
	public List<Member> getList(Criteria cri){
		List<Member> list = new ArrayList<Member>();
		String sql="select * from member";
		
		if(cri.getSearchWord() != null && !"".equals(cri.getSearchWord())) {
			sql += "where " + cri.getSearchField() + " like '%" + cri.getSearchWord()+ "%' ";
		}
		
		try (Connection conn = DBConnPool.getConnection();
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql)){
			
			while(rs.next()) {
				String id = rs.getString(1);
				String pw = rs.getString(2);
				String name = rs.getString(3);
				String adminyn = rs.getString(4);
				String status = rs.getString(5);
				String grade = rs.getString(6);
				
				Member member = new Member(id, pw, name, adminyn, status, grade);
				list.add(member);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}


	public Member selectOne(String id) {
		Member member = new Member();
		String sql = "select * from member where id=?";
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				member.setId(rs.getString(1));
				member.setPw(rs.getString(2));
				member.setName(rs.getString(3));
				member.setAdminyn(rs.getString(4));
				member.setStatus(rs.getString(5));
				member.setGrade(rs.getString(6));
				member.setOfile(rs.getString(7));
				member.setSfile(rs.getString(8));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return member;
	}

	
	/**
	 * 관리자 수 조회
	 * @param cri
	 * @return
	 */
	public int getToatlCnt(Criteria cri) {
		int totalCnt = 0;
		String sql= "select count(*) from member "; 
		
		if(cri.getSearchWord() != null && !"".equals(cri.getSearchWord())) {
			sql += "where " + cri.getSearchField() + " like '%" + cri.getSearchWord() + "%' ";
		}
			
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			ResultSet rs = pstmt.executeQuery();
			
			rs.next();
			totalCnt = rs.getInt(1); // 첫번째 컬럼의 값을 반환
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("총 게시물의 수를 조회하던 중 예외가 발생하였습니다");
		}
		return totalCnt;
	}
}
