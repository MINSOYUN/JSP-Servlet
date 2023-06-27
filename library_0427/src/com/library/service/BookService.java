package com.library.service;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.library.dao.BookDao;
import com.library.vo.Book;
import com.library.vo.Criteria;
import com.library.vo.PageDto;

public class BookService {
	BookDao dao = new BookDao();
	
	/**
	 * 도서 리스트를 조회 합니다.
	 * @param cri 
	 * @return
	 */
	public Map<String, Object> getList(Criteria cri){
		Map<String, Object> map = new HashMap<>();
		
		// 리스트 조회
		List<Book> list = dao.getList(cri);
		// 총 건수
		int totalCnt = dao.getToatlCnt(cri);
		// 페이지 DTO
		PageDto pageDto = new PageDto(totalCnt, cri);
		
		map.put("list", list);
		map.put("totalCnt", totalCnt);
		map.put("pageDto", pageDto);
		
		return map;
	}

	
	
	/**
	 * 도서 추가
	 */
	public int insert(String title, String author, String publisher) {
		Book book = new Book(title, author, publisher);
		int res = dao.insert(book);
		if(res > 0) {
			System.out.println(res + "건 입력 되었습니다.");
		} else {
			System.err.println("입력중 오류가 발생 하였습니다.");
			System.err.println("관리자에게 문의 해주세요");
		}
		return res;
	}

	
	
	/**
	 * 도서 삭제
	 * @param noStr
	 * @return
	 */
	public int delete(String noStr) {
		int res = dao.delete(noStr);
		return res;
	}

	
	
	/**
	 * 도서 대여
	 * @param bookNo
	 */
	public void rentBook(int bookNo) {
		// 대여가능한 도서인지 확인
		String rentYN = dao.getRentYN(bookNo);
		if("Y".equals(rentYN)) {
			System.err.println("이미 대여중인 도서 입니다.");
		} else if ("".equals(rentYN)) {
			System.out.println("없는 도서 번호 입니다.");
		}
		
		// 대여처리
		int res = dao.update(bookNo, "Y");
		
		if(res>0) {
			System.out.println(res + "건 대여 되었습니다.");
		}else {
			System.out.println("대여중 오류가 발생 하였습니다.");
			System.out.println("관리자에게 문의 해주세요");
		}
	}

	
	/**
	 * 도서 반납
	 * @param bookNo
	 */
	public void returnBook(int bookNo) {
		// 반납가능한 도서인지 확인
		String rentYN = dao.getRentYN(bookNo);
		if("N".equals(rentYN)) {
			System.err.println("반납 가능한 상태가 아닙니다.");
		} else if ("".equals(rentYN)) {
			System.out.println("없는 도서 번호 입니다.");
		}
		
		// 반납처리
		int res = dao.update(bookNo, "N");
		
		if(res>0) {
			System.out.println(res + "건 반납 되었습니다.");
		}else {
			System.out.println("반납 처리 중 오류가 발생 하였습니다.");
			System.out.println("관리자에게 문의 해주세요");
		}
	}

	
	/**
	 * 상세조회
	 */
	public Book selectOne (String no) {
		Book book = dao.selectOne(no);
		dao.updateVisitcount(no);
		return book;
	}


	/**
	 * 비밀번호 검증
	 * @param pass
	 * @return
	 */
	public boolean confirmPassword(String pass) {
		boolean res = dao.confirmPassword(pass);
		return res;
	}
	
	
	/**
	 * 도서 업데이트
	 * @param book
	 * @return
	 */
	public int updateBook(Book book) {
		int res =dao.updateBook(book);
		System.out.println(res);
		if(res>0) {
			System.out.println("도서 정보를 수정하였습니다");
		} else {
			System.out.println("도서 정보 업데이트를 실패하였습니다");
		}
		return res;
	}
	
}

