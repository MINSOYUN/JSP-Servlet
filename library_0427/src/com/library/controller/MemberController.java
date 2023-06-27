package com.library.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.library.service.MemberService;

@WebServlet("*.member")
public class MemberController extends HttpServlet{
	
	MemberService ms = new MemberService();

	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		System.out.println("요청 uri: " + uri);
		
		// 관리자 등록
		if(uri.indexOf("register") > 0) {
			req.getRequestDispatcher("./Register.jsp").forward(req, resp);
		}
	}
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		
		// 관리자 등록
		if(uri.indexOf("write") > 0) {
			int res = ms.insert(req.getParameter("id"), req.getParameter("pw"), req.getParameter("name"), req.getParameter("adminyn"));
			
			req.setAttribute("message", res+"건 등록되었습니다");
			
			resp.sendRedirect("./list.member");
		}
	}
}
