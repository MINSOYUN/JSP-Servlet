package servlet;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDao;
import dto.Member;

public class MemberAuth extends HttpServlet{

	MemberDao dao;
	
	@Override   // dao 생성 
	public void init(ServletConfig config) throws ServletException {
		dao = new MemberDao();
	}
	
	
	@Override   // doget 과 dopost 를 가르는 것이 service
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String admin_id = this.getInitParameter("admin_id");
		System.out.println(admin_id);
		
		String id = req.getParameter("id");
		String pw = req.getParameter("pw");
		// 반환타입 Member -> member 객체가 null 이면 회원가입이 되어있지 않다
		Member member = dao.login(id, pw);
		
		if(member != null) {
			req.setAttribute("authMessage", member.getName() + "회원님 환영합니다");
			
			//if(member.getId().equals(admin_id)) {
				//req.setAttribute("authMessage", admin_id + "님은 관리자입니다");
			//}
		} else {
			req.setAttribute("authMessage", "로그인 실패");
		}
		
		//req.getRequestDispatcher("/서블릿/MemberAuth.jsp").forward(req, resp);
		
		String str = URLEncoder.encode("/서블릿/MemberAuth.jsp");
		resp.sendRedirect(str);
	}
	
	
	public MemberAuth() {
		// TODO Auto-generated constructor stub
	}

}
