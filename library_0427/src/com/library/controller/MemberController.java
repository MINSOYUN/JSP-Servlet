package com.library.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.library.service.MemberService;
import com.library.vo.Criteria;
import com.library.vo.Member;
import com.oreilly.servlet.MultipartRequest;

import common.FileUtil;
import common.JSFunction;

@WebServlet("*.member")
public class MemberController extends HttpServlet{
	
	MemberService ms = new MemberService();

	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		System.out.println("요청 uri: " + uri);
		
		// 관리자 등록
		if(uri.indexOf("write") > 0) {
			//resp.sendRedirect("./Write.book");
			
			req.getRequestDispatcher("./Write.jsp").forward(req, resp);
		
		
		// 조회
		} else if(uri.indexOf("list") > 0) {
			Criteria cri = new Criteria(req.getParameter("searchField"), req.getParameter("searchWord"), req.getParameter("pageNo"));
			
			// 리스트 조회 및 요청 객체에 저장
			req.setAttribute("list", ms.getList(cri));  // 멤버 리스트 조회 및 저장
			
			req.getRequestDispatcher("./listMember.jsp").forward(req, resp);
		
		
		// 관리자 상세보기
		} else if(uri.indexOf("view")>0) {
			req.setAttribute("member", ms.selectOne(req.getParameter("id")));
			System.out.println("member:"+ ms.selectOne(req.getParameter("id")));
			req.getRequestDispatcher("./View.jsp").forward(req, resp);
			
		}
	}
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		
		// 관리자 등록
		if(uri.indexOf("write") > 0) {
			String saveDirectory = "C:\\Users\\user\\git\\JSP-Servlet\\library_0427\\webapp\\images\\memberImg";

			MultipartRequest mr = FileUtil.uploadFile(req, saveDirectory, 1024*1000);
			
			Member member = new Member(mr.getParameter("id"), mr.getParameter("pw"), mr.getParameter("name"));
			
			String ofile = mr.getFilesystemName("memberImg");
			System.out.println("ofile" + ofile);
			
			if(ofile != null && !"".equals(ofile)) {
				String sfile = FileUtil.fileNameChange(saveDirectory, ofile);	
				
				// 경로 포함되어 있지 않은 파일명 저장
				member.setOfile(ofile);
				member.setSfile(sfile);
			}
			
			int res = ms.insert(member);
			if(res>0) {
				JSFunction.alertLocation(resp, "./listMemer.member", res+"건 등록되었습니다");
			} else {
				JSFunction.alertBack(resp, "회원 등록에 실패하였습니다");
			}
			
		
		
		// 상세보기
		} else if(uri.indexOf("view") > 0) {
			
			
		}
	}
}
