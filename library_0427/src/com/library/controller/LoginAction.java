package com.library.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.library.service.MemberService;
import com.library.vo.Member;
import com.util.CookieManager;

/**
 * Servlet implementation class LoginAction
 */
@WebServlet("/login/loginAction.do")
public class LoginAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginAction() {
    }

    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// name 속성의 값을 매개값으로 넘겨주면 value 속성의 값을 반환합니다
		String id = request.getParameter("userid");
		String pw = request.getParameter("userpw");
		String saveCheck = request.getParameter("saveCheck");
		
		// id 저장에 체크하면 세션 길게 저장
		if("Y".equals(saveCheck)){
			// 60*60*24*7 -> 7일
			CookieManager.makeCookie(response, "userId", id, 60*60*24*7);
		}
		
		
		// lib 이동
		MemberService service = new MemberService();
		Member member = service.login(id, pw);
		
		
		if(member != null && !member.getId().equals("")){
			HttpSession session = request.getSession();
			// 로그인 성공
			session.setAttribute("member", member);
			session.setAttribute("userId", member.getId());
			System.out.println(member.getId()+"님 환영합니다!");
			
			// 관리자면 Y
			if("Y".equals(member.getAdminyn())){
				// 관리자인 경우 세션 adMinYN에 Y 저장
				session.setAttribute("adminYn", "Y");
			} 
			// uri : /library_0427/book/list.book
			response.sendRedirect("../book/list.book");
			// request.getRequestDispatcher("../book/list.book").forward(request, response);
	
		} else{
			// 로그인 실패
			// 로그인 화면으로 이동
			response.sendRedirect("../login.jsp?loginError=Y");
		}
		System.out.print("member: "+member);
	}

}
