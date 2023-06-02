package common;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class HelloJSP
 */
@WebServlet("/HelloJSP")   // HelloJSP 웹주소가 요청되면 실행 / mapping
public class HelloJSP extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HelloJSP() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		// LocalDateTime 클래스의 now 메서드를 사용하여 현재 날짜와 시간을 가져온다
		LocalDateTime ldt = LocalDateTime.now();
		// DateTimeFormatter 클래스의 ofPattern 메서드를 사용하여 날짜와 시간의 형식을 정의
		// format 메서드를 사용하여 해당 형식에 맞게 포맷
		String date = ldt.format(DateTimeFormatter.ofPattern("yyyy-mm-dd hh:mm:ss"));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
