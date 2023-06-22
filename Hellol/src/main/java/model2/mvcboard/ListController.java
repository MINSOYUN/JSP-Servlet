package model2.mvcboard;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class ListController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 리스트 조회
		MVCBoardDAO dao = new MVCBoardDAO();
		List<MVCBoardDTO> list = dao.getList();
		
		System.out.println("list: " +list.size());
		
		
		// request 영역에 저장
		req.setAttribute("list", list);
		// 화면 페이지 전환
		req.getRequestDispatcher("/14MVCBoard/List.jsp").forward(req, resp);
	}
	
	public ListController() {
	}

}
