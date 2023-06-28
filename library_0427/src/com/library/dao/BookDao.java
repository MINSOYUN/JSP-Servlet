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
//				+ " nvl((select 대여여부 from 대여 where 도서번호 = no and 대여여부 ='Y'), 'N')
				+" rentyn, "
				+ "  visitcount, case when trunc(postdate) = trunc(sysdate) then to_char(sysdate, 'YYYY-MM-DD HH24:MI:ss') "
				+ "  else to_char(postdate, 'YYYY-MM-DD') end as postdate "
				+ "  from book ";
		
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
				String no = rs.getString(1);
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
				("insert into book values (SEQ_BOOK_NO.NEXTVAL, '%s', '%s', '%s', '%s', 0, sysdate, '%s', '%s', null)"
				, book.getTitle(), book.getAuthor(), book.getPublisher(), book.getRentyn(), book.getOfile(), book.getSfile());

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
	 * 도서 대여 여부
	 * @param bookNo
	 * @return
	 */
	public String getRentYN(String bookNo) {
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
				rentYN = rs.getString(1);   // getString(1) : rentYN
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
		String sql = " select "
				  + " b.no, b.title, d.대여여부, b.author, b.publisher, b.visitcount, b.postdate, d.아이디"
				  + " , to_char(대여일,'yy/mm/dd') 대여일, to_char(반납가능일,'yy/mm/dd') 반납가능일" 
				  + " , 반납일, sfile, ofile, d.대여번호"
				  + " from book b, 대여 d where b.rentno = d.대여번호(+) and b.no="+no;
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			ResultSet rs = pstmt.executeQuery();

			while(rs.next()) {
				book.setNo(rs.getString(1));
				book.setTitle(rs.getString(2));
				book.setRentyn(rs.getString(3));
				book.setAuthor(rs.getString(4));
				book.setPublisher(rs.getString(5));
				book.setVisitcount(rs.getString(6));
				book.setPostdate(rs.getString(7));
				book.setId(rs.getString(8));
				book.setStartDate(rs.getString(9));
				book.setEndDate(rs.getString(10));
				book.setReturnDate(rs.getString(11));
				book.setSfile(rs.getString(12));
				book.setOfile(rs.getString(13));
				book.setRentno(rs.getString(14));
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
		String sql = "update book set title=?, author=?, publisher=? where no=?";
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, book.getTitle());
			pstmt.setString(2, book.getAuthor());
			pstmt.setString(3, book.getPublisher());
			pstmt.setString(4, book.getNo());
			
			System.out.println("title:"+book.getTitle());
			System.out.println("getAuthor:"+book.getAuthor());
			System.out.println("getPublisher:"+book.getPublisher());
			System.out.println("getNo:"+book.getNo());
			
			
			res = pstmt.executeUpdate();
			System.out.println("res: "+ res);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return res;
	}
	
	
	/**
	 * 도서대여
	 * @param book
	 * @return
	 */
	public int rentBook(Book book) {
		int res = 0;
		String sql1 = "SELECT 'R' || LPAD(seq_대여.nextval, 5, '0') FROM 대여";  // 시퀀스번호 조회
		String sql2 = "update book set rentno= ?, rentyn='Y' "
				+ " where no=? and (rentno is null or rentno='' )";   // 업데이트쿼리
		String sql3 = "insert into 대여 values (?, ?, ?, 'Y', sysdate, null, sysdate+14, null)";  
		
		// 대여번호 조회 R00001
		try (Connection conn = DBConnPool.getConnection();
				){
				conn.setAutoCommit(false);	// 자동 커밋 설정 x
				PreparedStatement pstmt = conn.prepareStatement(sql1); 
			
				ResultSet rs = pstmt.executeQuery();
				if(!rs.next()) {  // 대여 번호 없으면
					return res;
				}
				
				String rentno = rs.getString(1);  // 대여번호 생성
				
				System.out.println("rentno: "+rentno);   // 대여번호 출력
				
				pstmt.close();
				
				// sql 2
				pstmt = conn.prepareStatement(sql2);
				pstmt.setString(1, rentno);
				pstmt.setString(2, book.getNo());
				
				res = pstmt.executeUpdate(); // 업데이트 성공
				
				System.out.println("sql2:"+sql2);
				System.out.println("res:"+res);
				
				pstmt.close();
				
				// sql 3
				if(res>0) {
					pstmt = conn.prepareStatement(sql3);
					pstmt.setString(1, rentno);
					pstmt.setString(2, book.getId());
					pstmt.setString(3, book.getNo());
					
					res = pstmt.executeUpdate();  // sql 3번까지 성공?
					System.out.println("sq3:"+sql3);
					
					if(res>0) {
						conn.commit();  // 성공하면 커밋
					} else {
						conn.rollback();  // 실패하면 롤백
					}
				}
				
				
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}
	
	
	
	/**
	 * 도서 반납
	 * @return
	 */
	public int update(String no, String rentno) {
		int res = 0;
		String sql1 = "select rentno from book where rentno is not null";
		String sql2 = "update book set rentYN = 'N', rentno='' where rentno = ? and (rentno is not null)";
		String sql3 = "update 대여 set 대여여부='N', 반납일=sysdate where 대여번호=?"; 
		
		try (Connection conn = DBConnPool.getConnection();){
			conn.setAutoCommit(false);
			PreparedStatement pstmt = conn.prepareStatement(sql1); 
			
			ResultSet rs = pstmt.executeQuery();
			if(!rs.next()) {  // 대여 번호 없으면
				return res;
			}
			
			rentno = rs.getString(1);  // 대여번호 생성
			
			System.out.println("rentno: "+rentno);   // 대여번호 출력
			
			pstmt.close();
			
			
			// sql 2
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, rentno);
			
			res = pstmt.executeUpdate(); // 업데이트 성공
			
			System.out.println("sql2:"+sql2);
			System.out.println("res:"+res);
			
			pstmt.close();
			
			// sql 3
			if(res>0) {
				pstmt = conn.prepareStatement(sql3);
				pstmt.setString(1, rentno);
				res = pstmt.executeUpdate();
				
				System.out.println("sql3:"+sql3);
				System.out.println("res:"+res);
				
				pstmt.close();
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return res;
	}

}
