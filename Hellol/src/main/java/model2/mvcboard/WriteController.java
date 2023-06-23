package model2.mvcboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.JSFunction;

@WebServlet("/mvcboard/write.do")
public class WriteController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name = req.getParameter("name");
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String ofile = req.getParameter("ofile");
		String pass = req.getParameter("pass");
	
		MVCBoardDTO dto = new MVCBoardDTO();
		dto.setName(name);
		dto.setTitle(title);
		dto.setContent(content);
		dto.setOfile(ofile);
		dto.setPass(pass);
		
		MVCBoardDAO dao = new MVCBoardDAO();
		int res = dao.insert(dto);
		
		req.setAttribute("dto", dto);
		
		if(res>0) {
			JSFunction.alertLocation(resp, "../mvcboard/list.do", "등록되었습니다");
		} else {
			JSFunction.alertBack(resp, "게시글 등록에 실패하였습니다");
		}
		
		// 공유되는 영역이 없는 경우 redirect
		req.getRequestDispatcher("/14MVCBoard/Write.jsp").forward(req, resp);
	}
	
	
	public WriteController() {
		// TODO Auto-generated constructor stub
	}

}
