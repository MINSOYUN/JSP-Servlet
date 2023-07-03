package com.library.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.library.dao.BookDao;
import com.library.vo.Book;
import com.library.vo.Criteria;
import com.library.vo.PageDto;



public class ListController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BookDao dao  = new BookDao();
		
		
		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		String pageNo = req.getParameter("pageNo");
		
		// 초기화
		Criteria cri = new Criteria(searchField, searchWord, pageNo);
		
		cri.setSearchField(req.getParameter("searchField"));
		cri.setSearchWord(req.getParameter("searchWord"));
		
		// 검색어, 페이지 정보를 담은 객체를 매개변수로 넣어 줍니다
		List<Book> list = dao.getList(cri);
		
		int totalCnt = dao.getTotalCnt(cri);
		
		PageDto pageDto = new PageDto(totalCnt, cri);
		
		req.setAttribute("list", list);
		req.setAttribute("totalCnt", totalCnt);
		req.setAttribute("pageDto", pageDto);
		
		req.getRequestDispatcher("/book/list.jsp").forward(req, resp);
	}
	
	public ListController() {
	}

}
