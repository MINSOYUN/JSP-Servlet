package com.library.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.library.dao.MemberDao;
import com.library.dao.UserDao;
import com.library.vo.Basket;
import com.library.vo.Book;
import com.library.vo.Criteria;
import com.library.vo.Member;
import com.library.vo.PageDto;

public class UserService {
	UserDao dao = new UserDao();
	
	
	public int updateUser(Member member) {
		int res = dao.updateUser(member);
		return res;
	}

	
	/**
	 * 장바구니에 담기
	 * @param noStr
	 * @return
	 */
	public int basket(String no) {
		int res = dao.basket(no);
		return res;
	}

	
	/**
	 * 장바구니 목록
	 * @param cri
	 * @return
	 */
	public Object getList(Criteria cri) {
		Map<String, Object> map = new HashMap<>();
		
		// 리스트 조회
		List<Basket> list = dao.getList(cri);
		
		map.put("list", list);
		System.out.println("map: "+map);
		return map;
	}

}
