package com.library.controller;

import java.io.IOException;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.connector.Response;

import com.library.service.BookService;

@WebServlet("*.book")
public class BookController extends HttpServlet{
	
	BookService bs = new BookService();

	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI(); // 어떤 경로가 호출되었는지 알 수 있다
		System.out.println("요청 uri: " + uri);
		
		// uri에서 list 문자열이 처음으로 나타나는 인덱스 반환
		if(uri.indexOf("list") > 0) {  // 0보다 크다 : 경로에 list 포함 -> list가 요청되었으면 list 조회
			req.setAttribute("list", bs.getList());  // 책 리스트 조회 및 저장
			req.getRequestDispatcher("./list.jsp").forward(req, resp);
		}
	}
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doPost(req, resp);
	}

}
