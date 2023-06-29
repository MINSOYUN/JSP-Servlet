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
import com.library.vo.PageDto;
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
		
		// 회원 등록
		if(uri.indexOf("write") > 0) {
			//resp.sendRedirect("./Write.book");
			
			req.getRequestDispatcher("./Write.jsp").forward(req, resp);
		
		
		// 조회
		} else if(uri.indexOf("list") > 0) {
			Criteria cri = new Criteria(req.getParameter("searchField"), req.getParameter("searchWord"), req.getParameter("pageNo"));
			
			// 리스트 조회 및 요청 객체에 저장
			req.setAttribute("list", ms.getList(cri));  // 멤버 리스트 조회 및 저장
			req.setAttribute("totalCnt", ms.getToatlCnt(cri));
			req.getRequestDispatcher("./listMember.jsp").forward(req, resp);
		
		
		// 회원 상세보기
		} else if(uri.indexOf("view")>0) {
			req.setAttribute("member", ms.selectOne(req.getParameter("id")));
			req.getRequestDispatcher("./ViewMember.jsp").forward(req, resp);
		
			
		// 회원 삭제
		} else if(uri.indexOf("delete") > 0) {
			int res = ms.delete(req.getParameter("delNo"));
			System.out.println("삭제건: "+res);
			if(res>0) {
				JSFunction.alertLocation(resp, "./listMemer.member", res+"건 삭제되었습니다");
			} else {
				JSFunction.alertBack(resp, "관리자 정보 삭제에 실패하였습니다");
			}
			
			resp.sendRedirect("./listMember.member");
	
		
		// 회원 수정
		} else if(uri.indexOf("edit") > 0) {
			Member member = ms.selectOne(req.getParameter("id"));
			req.setAttribute("member", member);
			req.getRequestDispatcher("./EditMember.jsp").forward(req, resp);
		}
	}
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		
		// 회원 등록
		if(uri.indexOf("write") > 0) {
			String saveDirectory = "C:\\Users\\user\\git\\JSP-Servlet\\library_0427\\webapp\\images\\memberImg";

			MultipartRequest mr = FileUtil.uploadFile(req, saveDirectory, 1024*1000);
			String id = mr.getParameter("id");
			String pw = mr.getParameter("pw");
			String name = mr.getParameter("name");
			String ofile = mr.getParameter("ofile");
			String sfile = mr.getParameter("sfile");
			String info = mr.getParameter("info");
			System.out.println("자기소개: "+ info);
			Member member = new Member(id, pw, name, ofile, sfile, info);
			
			ofile = mr.getFilesystemName("memberImg");
			System.out.println("ofile" + ofile);
			
			if(ofile != null && !"".equals(ofile)) {
				sfile = FileUtil.fileNameChange(saveDirectory, ofile);	
				
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
		} else if(uri.indexOf("edit") > 0) {
			String id = req.getParameter("id");
			String adminyn = req.getParameter("adminyn");
			String status = req.getParameter("status");
			String grade = req.getParameter("grade");
			String info = req.getParameter("info");
			
			Member member = new Member();
			member.setId(id);
			member.setAdminyn(adminyn);
			member.setStatus(status);
			member.setGrade(grade);
			member.setInfo(info);
			
			System.out.println("id수정:"+id);
			System.out.println("adminyn수정:"+adminyn);
			System.out.println("status수정:"+status);
			System.out.println("grade수정:"+grade);
			System.out.println("info수정:"+info);
			System.out.println("member수정:"+member);
			int res = ms.updateMember(member);
			System.out.println("수정값:"+res);
			
			if(res>0) {
				JSFunction.alertLocation(resp, "../member/view.member?id="+id ,"회원 정보를 수정하였습니다");
			} else {
				JSFunction.alertBack(resp, "회원 정보 수정에 실패하였습니다");
			}
			
		}
	}
}
