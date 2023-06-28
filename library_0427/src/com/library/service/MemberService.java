package com.library.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.library.dao.MemberDao;
import com.library.vo.Book;
import com.library.vo.Criteria;
import com.library.vo.Member;
import com.library.vo.PageDto;

public class MemberService {
	MemberDao dao = new MemberDao();
	
	/**
	 * 로그인
	 * @param id
	 * @param pw
	 * @return
	 */
	public Member login(String id, String pw) {
		Member member = null;
		
		member = dao.login(id, pw);
		if(member == null){
			System.err.println("아이디/비밀번호를 확인해주세요");
		} else {
			System.out.println(member.getName()+"님 환영합니다.");
		}
		return member;
	}
	
	
	/**
	 * 멤버추가
	 * @param id
	 * @param pw
	 * @param name
	 * @param adminYN
	 * @return
	 */
	public int insert (Member member) {
		int res = dao.insert(member);
		return res;
	}
	
	
	/**
	 * 멤버 삭제
	 * @param delId
	 */
	public int delete(String delNo) {
		int res= dao.delete(delNo);
		
		return res;
	}
	
	
	/**
	 * 아이디 체크
	 * @param id
	 * @return
	 */
	public boolean idCheck(String id) {
		boolean res = dao.idCheck(id);
		if(!res) {
			System.out.println("아이디가 중복 되었습니다.");
		}
		return res;
	}

	
	/**
	 * 멤버 조회
	 * @param cri
	 * @return
	 */
	public List<Member> getList(Criteria cri) {
		List<Member> list = new ArrayList<Member>();
		list = dao.getList(cri);
		int totalCnt = dao.getToatlCnt(cri);
		// 리스트 조회
		return list;
	}


	public Member selectOne(String id) {
		Member member = dao.selectOne(id);
		return member;
	}
}










