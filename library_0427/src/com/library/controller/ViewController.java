package com.library.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.library.dao.BookDao;
import com.library.vo.Book;

@WebServlet("/book/view.do")
public class ViewController extends HttpServlet{

	public ViewController() {
		// TODO Auto-generated constructor stub
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BookDao dao = new BookDao();
		String no = req.getParameter("no");
		Book book = dao.selectOne(no);
		
		req.setAttribute("book", book);
		req.getRequestDispatcher("/book/View.jsp").forward(req, resp);
	}

}
