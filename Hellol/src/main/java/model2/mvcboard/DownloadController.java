package model2.mvcboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.FileUtil;

@WebServlet("/mvcboard/download.do")
public class DownloadController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String ofile = req.getParameter("ofile");
		String sfile = req.getParameter("sfile");
		FileUtil.download(req, resp, "C:\\upload", ofile, sfile);
		
		// 다운로드 시 조회수 상승
		String idx = req.getParameter("idx");
		MVCBoardDAO dao = new MVCBoardDAO();
		dao.updateDownCount(idx);
	}
	
	public DownloadController() {
		// TODO Auto-generated constructor stub
	}

}
