package model2.mvcboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.Session;

import common.JSFunction;

@WebServlet("/mvcboard/pass.do")
public class PassController  extends HttpServlet{

	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// mode:  수정(edit), 삭제(delete)
		req.setAttribute("idx", req.getParameter("idx"));
		req.setAttribute("mode", req.getParameter("mode"));
		
		// 포워딩
		req.getRequestDispatcher("/14MVCBoard/Pass.jsp").forward(req, resp);
	}
	
	
	// form method 가 post이기 때문에 값을 받기 위해서 doPost()
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String idx = req.getParameter("idx");
		String mode = req.getParameter("mode");
		String pass = req.getParameter("pass");
		
		MVCBoardDAO dao = new MVCBoardDAO();
		
		// 게시글의 비밀번호가 일치하는지 확인
		boolean confirmed = dao.comfirmPassword(pass, idx);
		
		// 비밀번호 체크 성공
		if(confirmed) {
			System.out.println("비밀번호 검증 성공");
			
			// 수정
			if(mode.equals("edit")) {
				// id 값 가져가기 위해서 sendRedirect
				resp.sendRedirect("../mvcboard/edit.do?idx=" +idx);
				
				// 삭제
			} else if(mode.equals("delete")) {
				int res = dao.delete(idx);

				if(res>0) {
					// 삭제성공
					JSFunction.alertLocation(resp, "../mvcboard/list.do", "삭제되었습니다");
				} else {
					// 삭제 실패
					JSFunction.alertBack(resp, "게시물 삭제에 실패하였습니다");
				}
			}
			
			// 비밀번호 체크 실패
		} else {
			JSFunction.alertBack(resp, "비밀번호 검증에 실패하였습니다");
		}
		
		
	}
	
	public PassController() {
		// TODO Auto-generated constructor stub
	}

}
