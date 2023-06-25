package model2.mvcboard;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.http.fileupload.FileUtils;

import com.oreilly.servlet.MultipartRequest;

import common.JSFunction;

@WebServlet("/mvcboard/edit.do")
public class EditController extends HttpServlet{

	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 게시물 조회
		MVCBoardDAO dao = new MVCBoardDAO();
		MVCBoardDTO dto = dao.selectOne(req.getParameter("idx"));
		
		// request 영역에 저장
		req.setAttribute("dto", dto);
		
		req.getRequestDispatcher("/14MVCBoard/Edit.jsp").forward(req, resp);
	}
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String saveDirectory = req.getServletContext().getRealPath("/Uploads");
		
		ServletContext application = getServletContext();
		int maxPostSize = Integer.parseInt(application.getInitParameter("maxPostSize"));
		
		MultipartRequest mr = FileUtil.uploadFile(req, saveDirectory, maxPostSize);
		
		if(mr = null) {
			JSFunction.alertBack(resp, "용량이 큽니다");
		}
		
		String idx = req.getParameter("idx");
		String prevOfile = req.getParameter("prevOfile");
		String prevSfile = req.getParameter("prevSfile");
		String name = req.getParameter("name");
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		HttpSession session = req.getSession();
		String pass = (String)session.getAttribute("pass");
		
		MVCBoardDTO dto = new MVCBoardDTO();
		dto.setIdx(idx);
		dto.setName(name);
		dto.setTitle(title);
		dto.setContent(content);
		dto.setSfile(pass);
		
		String fileName = mr.getFilesystemName("ofile");
		if(fileName != null) {
			// 첨부파일 있으면 파일명 변경

		} else {
			// 첨부파일 없으면 파일명 동일
			dto.setOfile(prevOfile);
			dto.setSfile(prevSfile);
		}
		
		
		MVCBoardDAO dao = new MVCBoardDAO();
		int res = dao.update(dto);
		
		System.out.println(res);
		
		if(res>0) {
			JSFunction.alertLocation(resp, "../mvcboard/view.do?idx="+idx, "게시글을 수정하였습니다");
		} else {
			JSFunction.alertBack(resp, "게시글 수정에 실패하였습니다");
		}
		
	}
	
	public EditController() {
	}

}
