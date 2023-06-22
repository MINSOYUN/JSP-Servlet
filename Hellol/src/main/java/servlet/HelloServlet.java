package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// extends HttpServlet
public class HelloServlet  extends HttpServlet{
	
	@Override   // doget 자동완성 -> 사용자의 요청이 get인 경우 실행
	// 매개변수의 타입이 클래스임! req의 클래스 Http~~
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// 서블릿이 호출되면 jsp 로 반환
		req.setAttribute("message", "서블릿 호출!!");
		
		//PrintWriter out = res.getWriter();
		//out.print("서블릿호출");
		
		// 리퀘스트 영역이 공유가 되지 않는다
		// res.sendRedirect("HelloServlet.jsp");  // 매핑하기 위해 web.xml 파일 불러오기
		
		// request 영역이 공유
		req.getRequestDispatcher("HelloServlet.jsp").forward(req, res);
	}

	public HelloServlet() {
		// TODO Auto-generated constructor stub
	}

}
