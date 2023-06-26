package com.library.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.library.common.ConnectionUtil;
import com.library.vo.Book;


import com.library.common.DBConnPool;

public class BookDao {
	/**
	 * 도서목록 조회
	 * @return
	 */
	public List<Book> getList(){
		List<Book> list = new ArrayList<Book>();
		
		//String sql = "select * from book order by no";
		String sql = 
				"select no, title"
				+ "    , nvl((select 대여여부 "
				+ "			 from 대여 "
				+ "			where 도서번호 = no "
				+ "			  and 대여여부='Y'),'N') rentyn "
				+ "    , author, postdate "
				+ "from book "
				+ "order by no";
		
		// try ( 리소스생성 ) => try문이 종료되면서 리소스를 자동으로 반납
		try (Connection conn = ConnectionUtil.getConnection();
				Statement stmt = conn.createStatement();
				// stmt.executeQuery : resultSet (질의한 쿼리에 대한 결과집합)
				// stmt.executeUpdate : int (몇건이 처리되었는지!!!)
				ResultSet rs = stmt.executeQuery(sql)){
			while(rs.next()) {
				int no = rs.getInt(1);
				String title = rs.getString(2);
				String rentYN = rs.getString(3);
				String author = rs.getString(4);
				String postdate = rs.getString(5);
				
				Book book = new Book(no, title, rentYN, author, postdate);
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
		
		sql+=" order by no desc";
			
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
	 * 도서 등록
	 * @param book
	 * @return
	 */
	public int insert(Book book) {
		int res = 0;
		
		String sql = String.format
	("insert into book values (SEQ_BOOK_NO.NEXTVAL, '%s', '%s', '%s')"
				, book.getTitle(), book.getRentyn(), book.getAuthor());

		// 실행될 쿼리를 출력해봅니다
		//System.out.println(sql);
		
		try (Connection conn = ConnectionUtil.getConnection();
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
	public int delete(int no) {
		int res = 0;
		
		String sql = String.format
						("delete from book where no = %d", no);
	
		// 실행될 쿼리를 출력해봅니다
		//System.out.println(sql);
		
		try (Connection conn = ConnectionUtil.getConnection();
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
		
		try (Connection conn = ConnectionUtil.getConnection();
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
		
		
		try (Connection conn = ConnectionUtil.getConnection();
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
		Book book = null;
		String sql = "select * from book where no = ?";
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, no);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				book.setNo(rs.getInt(1));
				book.setTitle(rs.getString(2));
				book.setRentyn(rs.getString(3));
				book.setAuthor(rs.getString(4));
				book.setPostdate(rs.getString(5));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("도서 한 건 조회 도중 오류가 발생하였습니다");
		}
		return book;
	}


	/**
	 * 페이징 된 게시글 조회
	 * @param cri
	 * @return
	 */
	public List<Book> getListPage(Criteria cri){
		List<Book> list = new ArrayList<Book>();
		Book book = new Book();
		
		String sql = "select * "
				+ "from( "
				+ "    select tb.*,  rownum rn "
				+ "    from( "
				+ "        select * "
				+ "        from book ";
		
		if(cri.getSearchWord() != null && !"".equals(cri.getSearchWord())) {
			sql += " where "+ cri.getSearchField()+ " like '%"+cri.getSearchWord() +"%' ";
		}
		sql += " order by no desc "
				+ "    ) tb "
				+ " ) "
				+ " where rn between "+ cri.getStartNo()+" and "+ cri.getEndNo();

		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				book.setNo(rs.getInt(1));
				book.setTitle(rs.getString(2));
				book.setRentyn(rs.getString(3));
				book.setAuthor(rs.getString(4));
				book.setPostdate(rs.getString(5));
				
				list.add(book);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
}
