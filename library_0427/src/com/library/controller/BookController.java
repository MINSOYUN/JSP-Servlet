
package com.library.controller;

import java.io.IOException;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.connector.Response;

import com.library.dao.BookDao;
import com.library.service.BookService;
import com.library.vo.Book;
import com.library.vo.Criteria;
import com.oreilly.servlet.MultipartRequest;

import common.FileUtil;
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
			//resp.sendRedirect("./list.book");
			req.getRequestDispatcher("./list.book").forward(req, resp);
			
			
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
		
		
		// 다운로드
		} else if(uri.indexOf("download")>0) {
			String ofile = req.getParameter("ofile");
			String sfile = req.getParameter("sfile");
			String saveDirectory = "C:\\Users\\user\\git\\JSP-Servlet\\library_0427\\webapp\\images\\bookImg";
			FileUtil.download(req, resp, saveDirectory, ofile, sfile);
		
		
		// 대여 중 도서
		} else if(uri.indexOf("renting")>0) {
			Criteria cri = new Criteria(req.getParameter("searchField"), req.getParameter("searchWord"), req.getParameter("pageNo"));
			req.setAttribute("map", bs.rentingBook(cri)); 
			req.getRequestDispatcher("./Renting.jsp").forward(req, resp);
		
			
		// 대여 이력 있는 도서
		} else if(uri.indexOf("history")>0) {
			Criteria cri = new Criteria(req.getParameter("searchField"), req.getParameter("searchWord"), req.getParameter("pageNo"));
			req.setAttribute("map", bs.history(cri)); 
			req.getRequestDispatcher("./History.jsp").forward(req, resp);
			
			// 대여기간 연장
		} else if(uri.indexOf("extension")>0) {
			int res = bs.extension(req.getParameter("extension"));
			
			if(res>0) {
				req.setAttribute("message", res+"건 기한 연장되었습니다");
			} else {
				req.setAttribute("message", "기한 연장에 실패하였습니다. 관리자에게 문의해주세요");
			}
			
			req.getRequestDispatcher("./Renting.jsp").forward(req, resp);
		}
	}
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		
		// 도서 등록
		if(uri.indexOf("write") > 0) {
			String saveDirectory = "C:\\Users\\user\\git\\JSP-Servlet\\library_0427\\webapp\\images\\bookImg";

			MultipartRequest mr = FileUtil.uploadFile(req, saveDirectory, 1024*1000);
			
			Book book = new Book(mr.getParameter("title"), mr.getParameter("author"), mr.getParameter("publisher"), mr.getParameter("info"));
				
				String ofile = mr.getFilesystemName("bookImg");
				System.out.println("ofile" + ofile);
				
				if(ofile != null && !"".equals(ofile)) {
					String sfile = FileUtil.fileNameChange(saveDirectory, ofile);	
					
					// 경로 포함되어 있지 않은 파일명 저장
					book.setOfile(ofile);
					book.setSfile(sfile);
				}
				
				int res = bs.insert(book);
			
				if(res>0) {
					JSFunction.alertLocation(resp, "./list.book", "등록되었습니다");
				} else {
					JSFunction.alertBack(resp, "등록 중 예외사항이 발생하였습니다");
				}
				
		
		
		// 도서 대여
		} else if(uri.indexOf("rent")>0) {
			HttpSession session = req.getSession();
			
			if(session.getAttribute("userId") == null) {
				JSFunction.alertBack(resp, "로그인 후 이용 가능한 메뉴입니다");
				return;
			}
			
			String no = req.getParameter("no");
			
			Book book = new Book();
			book.setNo(req.getParameter("no"));
			book.setId(session.getAttribute("userId").toString());
			
			int res = bs.rentBook(book);
		
			if(res>0) {
				JSFunction.alertLocation(resp, "./view.book?no="+book.getNo(),"대여되었습니다");
			} else {
				JSFunction.alertBack(resp, "대여 중 오류가 발생하였습니다");
			}
			
		
		// 도서 반납
		} else if(uri.indexOf("return")>0) {
			HttpSession session = req.getSession();
			
			if(session.getAttribute("userId") == null) {
				JSFunction.alertBack(resp, "로그인 후 이용 가능한 메뉴입니다");
				return;
			}
			
			Book book = new Book();
			String no = req.getParameter("no");
			String rentno = req.getParameter("rentno");
			book.setId(session.getAttribute("userId").toString());
			
			int res = bs.returnBook(no, rentno);
			
			if(res>0) {
				JSFunction.alertLocation(resp, "./view.book?no="+no, res+"건 반납되었습니다");
			} else {
				JSFunction.alertBack(resp, "반납 중 오류가 발생하였습니다");
			}
			

		// 수정
		} else if(uri.indexOf("edit") > 0) {
			String title = req.getParameter("title");
			String author = req.getParameter("author");
			String publisher = req.getParameter("publisher");
			String no = req.getParameter("no");
			String info = req.getParameter("info");
			
			Book book = new Book();
			book.setTitle(title);
			book.setAuthor(author);
			book.setPublisher(publisher);
			book.setNo(no);
			book.setInfo(info);
			
			int res = bs.updateBook(book);
			
			System.out.println("book정보:"+book);
			
			if(res>0) {
				JSFunction.alertLocation(resp, "../book/view.book?no="+no ,"도서 목록을 수정하였습니다");
			} else {
				JSFunction.alertBack(resp, "도서 목록 수정에 실패하였습니다");
			}
		
		
		// 대여 중인 도서
		} else if(uri.indexOf("renting") > 0) {
			

		}
	
	}

}
