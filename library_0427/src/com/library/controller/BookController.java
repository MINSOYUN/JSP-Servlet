package com.library.controller;

import java.io.IOException;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.connector.Response;

import com.library.dao.BookDao;
import com.library.service.BookService;
import com.library.vo.Book;
import com.library.vo.Criteria;

import common.JSFunction;

@WebServlet("*.book")
public class BookController extends HttpServlet{
	
	BookService bs = new BookService();
	

	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI(); // 어떤 경로가 호출되었는지 알 수 있다
		System.out.println("요청 uri: " + uri);
		
		// uri에서 list 문자열이 처음으로 나타나는 인덱스 반환
		if(uri.indexOf("list") > 0) {  // 0보다 크다 : 경로에 list 포함 -> list가 요청되었으면 list 조회
			// 검색조건 세팅 / pageNo, endNo, startNo 세팅
			Criteria cri = new Criteria(req.getParameter("searchField"), req.getParameter("searchWord"), req.getParameter("pageNo"));
			
			// 리스트 조회 및 요청 객체에 저장
			req.setAttribute("map", bs.getList(cri));  // 책 리스트 조회 및 저장
			
			req.getRequestDispatcher("./list.jsp").forward(req, resp);
		
			
		// 삭제
		} else if (uri.indexOf("delete") > 0) {
			int res = bs.delete(req.getParameter("delNo"));
			
			if(res>0) {
				req.setAttribute("message", res+"건 삭제되었습니다");
			} else {
				req.setAttribute("message", "삭제 실패하였습니다. 관리자에게 문의해주세요");
			}
			
			// 포워딩
			resp.sendRedirect("./list.book");
			//req.getRequestDispatcher("./list.book").forward(req, resp);
			
			
		// 상세보기
		} else if(uri.indexOf("view") > 0) {
			req.setAttribute("book", bs.selectOne(req.getParameter("no")));
			
			req.getRequestDispatcher("./View.jsp").forward(req, resp);
			
			
		// 도서 추가
		} else if(uri.indexOf("write") > 0) {
			req.getRequestDispatcher("./Write.jsp").forward(req, resp);
		
		
		// 비밀번호 검증
		} else if(uri.indexOf("pass") > 0) {
			req.setAttribute("no", req.getParameter("no"));
			req.setAttribute("mode",req.getParameter("mode"));
			
			req.getRequestDispatcher("./Pass.jsp").forward(req, resp);
	
			
			// 도서 수정
		} else if(uri.indexOf("edit")>0) {
			Book book = bs.selectOne(req.getParameter("no"));
			req.setAttribute("book", book);
			
			req.getRequestDispatcher("./Edit.jsp").forward(req, resp);
		}
	}
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		
		if(uri.indexOf("write") > 0) {
			req.getParameter("title");
			int res = bs.insert(req.getParameter("title"), req.getParameter("author"), req.getParameter("publisher"));
			
			req.setAttribute("message", res+"건 등록되었습니다");
			resp.sendRedirect("./list.book");
		
		
		// 비밀번호 검증
		} else if(uri.indexOf("pass") > 0) {
			String no = req.getParameter("no");
			String mode = req.getParameter("mode");
			String pass = req.getParameter("pass");
			
			boolean res = bs.confirmPassword(pass);
			if(res) {
				if(mode.equals("edit")) {
					resp.sendRedirect("./edit.book");
				} else if(mode.equals("delete")) {
					resp.sendRedirect("./delete.book");
				}
			} else {
				System.out.println("비밀번호가 올바르지 않습니다");
				req.getRequestDispatcher("./Pass.jsp").forward(req, resp);
			}
		
			
		// 수정
		} else if(uri.indexOf("edit") > 0) {
			String title = req.getParameter("title");
			String author = req.getParameter("author");
			String publisher = req.getParameter("publisher");
			String no = req.getParameter("no");
			
			Book book = new Book();
			book.setTitle(title);
			book.setAuthor(author);
			book.setPublisher(publisher);
			
			int res = bs.updateBook(book);
			if(res>0) {
				JSFunction.alertLocation(resp, "../book/view.book?no="+no, "도서 목록을 수정하였습니다");
			} else {
				JSFunction.alertBack(resp, "도서 목록 수정에 실패하였습니다");
			}
		}
	
	}

}
