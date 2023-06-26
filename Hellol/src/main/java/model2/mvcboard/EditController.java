package model2.mvcboard;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.http.fileupload.FileUtils;

import com.oreilly.servlet.MultipartRequest;

import common.FileUtil;
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
		
		String saveDirectory = "C:/upload";
		// 파일 업로드 : 업로드 경로, 최대 사이즈
		MultipartRequest mr = FileUtil.uploadFile(req, saveDirectory, 1024 * 1000);
		
		if(mr == null) {
			// 파일 업로드 실패
			JSFunction.alertBack(resp, "파일 저장 중 오류가 발생하였습니다");
			return;
		}
		
		MVCBoardDTO dto = new MVCBoardDTO();
		String idx = mr.getParameter("idx");
		dto.setIdx(idx);
		dto.setName(mr.getParameter("name"));
		dto.setTitle(mr.getParameter("title"));
		dto.setContent(mr.getParameter("content"));

		
		String fileName = mr.getFilesystemName("ofile");
		System.out.println("fileName" + fileName);
		if(fileName != null) {
			// 첨부파일의 확장자
			// 마지막 인덱스 . 으로부터 끝까지 문자열 가져와 확장자 추출
			// 파일명에 점(.)이 2개 이상 포함될 수 있기 때문
			String ext = fileName.substring(fileName.lastIndexOf("."));
			
			// H : 0~23 S : millisecond
			// 현재 시간을 파일이름으로 지정
			String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());  // 현재시간 추출
			String oFileName = fileName.substring(0, fileName.lastIndexOf("."));  // 확장자 제외한 파일명 추출
			
			String newFileName = oFileName + "_" + now + ext;  // 원본파일명 + 시간 + 확장자
			System.out.println("원본파일명 : " + fileName);
			System.out.println("신규파일명 : " + newFileName);
			
			// 3. 파일명 변경
			// 경로 + 파일의 이름
			// File.separator는 경로를 구분하는 특수 기호
			File oldFile = new File(saveDirectory + File.separator + fileName);
			File newFile = new File(saveDirectory + File.separator + newFileName);
			
			oldFile.renameTo(newFile);  // 파일명 변경
			
			dto.setOfile(fileName);  // 원본 파일명
			dto.setSfile(newFileName);  // 저장된 파일명
		} else {
			// 첨부파일 없으면 파일명 동일
			dto.setOfile(fileName);
			dto.setSfile(fileName);
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
