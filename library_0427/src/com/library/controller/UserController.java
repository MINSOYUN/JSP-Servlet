package com.library.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.library.service.BookService;
import com.library.service.MemberService;
import com.library.service.UserService;
import com.library.vo.Book;
import com.library.vo.Criteria;
import com.library.vo.Member;
import com.oreilly.servlet.MultipartRequest;

import common.FileUtil;
import common.JSFunction;

@WebServlet("*.user")
public class UserController extends HttpServlet{
	
	MemberService ms = new MemberService();
	UserService us = new UserService();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI(); 
		System.out.println("요청 uri: " + uri);
		
		// 상세보기
		if(uri.indexOf("view")>0) {
			req.setAttribute("member", ms.selectOne(req.getParameter("id")));
			req.getRequestDispatcher("./ViewUser.jsp").forward(req, resp);
			
		
		// 수정하기
		} else if(uri.indexOf("edit")>0) {
			Member member = ms.selectOne(req.getParameter("no"));
			req.setAttribute("member", member);
			System.out.println("수정:"+ member);
			
			req.getRequestDispatcher("./EditUser.jsp").forward(req, resp);
			
		
		// 장바구니 목록
		} else if(uri.indexOf("basket")>0) {
			int res = us.basket(req.getParameter("no"));
			System.out.println("갯수:"+ res);
			Criteria cri = new Criteria(req.getParameter("searchField"), req.getParameter("searchWord"), req.getParameter("pageNo"));
			
			req.setAttribute("map", us.getList(cri)); 
			System.out.println("마지막map: "+req.getAttribute("map"));
			if(res>0) {
				JSFunction.alertLocation(resp, "./Basket.jsp", "장바구니에 "+res+"건의 도서가 담겼습니다");
			} else {
				JSFunction.alertBack(resp, "장바구에 담지 못하였습니다. 다시 시도해주세요");
			}
			
			
		// 구매하기
		} else if(uri.indexOf("purchase")>0) {
			int res = us.basket(req.getParameter("purchase"));
			
			if(res>0) {
				JSFunction.alertLocation(resp, "", "구매 페이지로 이동합니다");
			} else {
				JSFunction.alertBack(resp, "구매할 수 없는 도서입니다");
			}
			
			req.getRequestDispatcher("../book/list.book").forward(req, resp);
			
		}
	}
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		System.out.println("uri:"+uri);
		
		// 마이페이지 정보 수정
		if(uri.indexOf("edit") > 0) {
			String id = req.getParameter("id");
			String pw = req.getParameter("pw");
			String name = req.getParameter("name");
			String info = req.getParameter("info");
			
			Member member = new Member();
			member.setId(id);
			member.setAdminyn(pw);
			member.setStatus(name);
			member.setInfo(info);
			
			int res = us.updateUser(member);
			
			if(res>0) {
				JSFunction.alertLocation(resp, "./view.user?id="+id ,"회원 정보를 수정하였습니다");
			} else {
				JSFunction.alertBack(resp, "회원 정보 수정에 실패하였습니다");
			}
	
	}
	
}
}
