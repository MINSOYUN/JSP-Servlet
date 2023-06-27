package com.library.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.library.vo.Book;
import com.library.vo.Criteria;
import com.library.common.DBConnPool;

public class BookDao {
	/**
	 * 도서목록 조회
	 * @return
	 */
	public List<Book> getList(Criteria cri){
		List<Book> list = new ArrayList<Book>();
		
		//String sql = "select * from book order by no";
		String sql = 
				"select * from ( "
				+ "    select t.*, rownum rn "
				+ " from ( "
				+ " select no, title, author, publisher, "
				+ " nvl((select 대여여부 from 대여 where 도서번호 = no and 대여여부 ='Y'), 'N') rentyn"
				+ "    , visitcount, case when trunc(postdate) = trunc(sysdate) then to_char(sysdate, 'YYYY-MM-DD HH24:MI:ss')"
				+ " else to_char(postdate, 'YYYY-MM-DD') end"
				+ " from book ";
		
		if(cri.getSearchWord() != null && !"".equals(cri.getSearchWord())) {
			sql += "where " + cri.getSearchField() + " like '%" + cri.getSearchWord()+ "%' ";
		}
		sql += " order by no desc) t "
				+") "
				+"where rn between " + cri.getStartNo() + " and " + cri.getEndNo();

		try (Connection conn = DBConnPool.getConnection();
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql)){
			while(rs.next()) {
				int no = rs.getInt(1);
				String title = rs.getString(2);
				String author = rs.getString(3);
				String publisher = rs.getString(4);
				String rentYN = rs.getString(5);
				String visitcount = rs.getString(6);
				String postdate = rs.getString(7);
				
				Book book = new Book(no, title, author, publisher, rentYN, visitcount, postdate);
				list.add(book);
			}

		} catch (SQLException e) {
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
		String sql= "select count(*) from book "; 
		
		if(criteria.getSearchWord() != null && !"".equals(criteria.getSearchWord())) {
			sql += "where " + criteria.getSearchField() + " like '%" + criteria.getSearchWord() + "%' ";
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
	
	
	
	/**
	 * 도서 등록
	 * @param book
	 * @return
	 */
	public int insert(Book book) {
		int res = 0;
		
		String sql = String.format
	("insert into book values (SEQ_BOOK_NO.NEXTVAL, '%s', '%s', '%s', '%s', 0, sysdate)"
				, book.getTitle(), book.getAuthor(), book.getPublisher(), book.getRentyn());

		try (Connection conn = DBConnPool.getConnection();
				Statement stmt = conn.createStatement();	){
			res = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return res;
	}
	
	
	
	/**
	 * 도서 삭제
	 * @return
	 */
	public int delete(String noStr) {
		int res = 0;
		
		String sql = String.format
						("delete from book where no in (%s)", noStr);
		
		try (Connection conn = DBConnPool.getConnection();
				Statement stmt = conn.createStatement();	){
			res = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return res;
	}
	
	
	
	/**
	 * 도서 업데이트
	 * @return
	 */
	public int update(int no, String rentYN) {
		int res = 0;
		
		String sql = String.format
		("update book set rentYN = '%s' where no = %d", rentYN ,no);
	
		// 실행될 쿼리를 출력해봅니다
		//System.out.println(sql);
		
		try (Connection conn = DBConnPool.getConnection();
				Statement stmt = conn.createStatement();	){
			res = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return res;
	}

	
	
	/**
	 * 도서 대여 여부
	 * @param bookNo
	 * @return
	 */
	public String getRentYN(int bookNo) {
		String rentYN = "";
		String sql = 
				String.format(
					"SELECT RENTYN FROM BOOK WHERE NO = %s", bookNo);
		
		
		try (Connection conn = DBConnPool.getConnection();
				Statement stmt= conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql);){
			// 조회된 행이 있는지 확인
			if(rs.next()) {
				// DB에서 조회된 값을 변수에 저장
				rentYN = rs.getString(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return rentYN;
	}

	
	/**
	 * 도서 1건 조회
	 * @param no
	 */
	public Book selectOne(String no) {
		Book book = new Book();
		String sql = "select * from book where no = ?";
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, no);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				book.setNo(rs.getInt(1));
				book.setTitle(rs.getString(2));
				book.setAuthor(rs.getString(3));
				book.setPublisher(rs.getString(4));
				book.setRentyn(rs.getString(5));
				book.setVisitcount(rs.getString(6));
				book.setPostdate(rs.getString(7));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("도서 한 건 조회 도중 오류가 발생하였습니다");
		}
		return book;
	}

	
	/**
	 * 비밀번호 검증
	 * @param pass
	 * @param no
	 * @return
	 */
	public boolean confirmPassword(String pass) {
		boolean res = false;
		String sql ="select * from member where pw=?";
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, pass);
			ResultSet rs = pstmt.executeQuery();
			res = rs.next();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}

	
	/**
	 * 조회수 상승
	 * @param no
	 * @return
	 */
	public int updateVisitcount(String no) {
		int res = 0;
		String sql = "update book set visitcount = visitcount +1 where no =?";
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, no);
			res =pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}
	
	
	public int updateBook(Book book) {
		int res = 0;
		String sql = "update book set title=?, author=?, publisher=?, rentyn=? where no=?";
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, book.getTitle());
			pstmt.setString(2, book.getAuthor());
			pstmt.setString(3, book.getPublisher());
			pstmt.setString(4, book.getRentyn());
			pstmt.setInt(5, book.getNo());
			
			System.out.println("title:"+book.getTitle());
			System.out.println("getAuthor:"+book.getAuthor());
			System.out.println("getPublisher:"+book.getPublisher());
			System.out.println("getRentyn:"+book.getRentyn());
			System.out.println("getNo:"+book.getNo());
			
			
			res = pstmt.executeUpdate();
			System.out.println("res: "+ res);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}

}
