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
		int totalCnt = dao.getTotalCnt(cri);
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
	public int insert(Book book) {
		
		int res = dao.insert(book);
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
	 * @param book
	 */
	public int rentBook(Book book) {
		int res = dao.rentBook(book);
		return res;
	}

	
	/**
	 * 도서 반납
	 * @param bookNo
	 */
	public int returnBook(String no, String rentno) {
		int res = 0;
		res = dao.update(no, rentno);
		System.out.println("no:"+no);
		System.out.println("rentno:"+rentno);
		return res;
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
	
	
	
	/**
	 * 대여 중인 도서 조회
	 * @param cri
	 * @return
	 */
	public Map<String, Object> rentingBook(Criteria cri){
		Map<String, Object> map = new HashMap<>();
		
		List<Book> list = dao.rentingBook(cri);
		int totalCnt = dao.getRentingCnt(cri);
		PageDto pageDto = new PageDto(totalCnt, cri);
		
		map.put("list", list);
		map.put("totalCnt", totalCnt);
		map.put("pageDto", pageDto);
		
		return map;
	}



	/**
	 * 도서 기한 연장
	 * @param parameter
	 * @return
	 */
	public int extension(String noStr) {
		int res = dao.extension(noStr);
		return res;
	}


	
	/**
	 * 대여 이력이 있는 도서 목록 조회
	 * @param cri
	 * @return
	 */
	public Map<String, Object> history(Criteria cri){
		Map<String, Object> map = new HashMap<>();
		
		List<Book> list = dao.history(cri);
		int totalCnt = dao.getRentingCnt(cri);
		PageDto pageDto = new PageDto(totalCnt, cri);
		
		map.put("list", list);
		map.put("pageDto", pageDto);
		
		return map;
	}

	
}

