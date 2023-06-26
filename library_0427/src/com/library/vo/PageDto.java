package com.library.vo;

import com.library.dao.Criteria;

public class PageDto {

	
	// 페이지를 구성하는데 필요한 요소
	int startNo;           // 페이지 블럭 시작번호
	int endNo;             // 페이지 블럭 끝번호
    int realEnd;		   // 게시물 끝페이지 번호 (<< 끝 페이지로 이동 >>)
	boolean prev, next;    // 이전, 다음 버튼 (boolean true 이면 보여진다)
	
	
	// 페이지 블럭을 생성하기 위해 필요한 요소
	int total;             // 총 개시물 수
	Criteria criteria;     // 페이지 번호, 페이지당 게시물수 (pageNo, amount)
    
    
	
	public PageDto() {
		
	}


	// 페이지 블럭 초기화
	public PageDto(int total, Criteria criteria) {
		super();
		this.total = total;
		this.criteria = criteria;
		
		// 페이지 블럭의 끝번호 구하기
		// 7페이지 끝번호 요청 : 올림(7/10.0) * 10 = 10
		// ->  7을 10으로 나눈 결과인 0.7을 올림한 1에 10을 곱한 10이 되어 페이지 블록의 끝 번호가 10
		// 11페이지 끝번호 요청: 올림(11/10.0) * 10 = 20
		// (형변환 int) 올림(페이지번호/한 페이지당 게시물 수) * 한 페이지당 게시물 수;
		endNo = (int)Math.ceil(criteria.getPageNo() / 5.0) * 5;
		System.out.println("pageNo : " + criteria.getPageNo());
		// endNo - (amount - 1);
		startNo = endNo - (5-1);
		
		// 진짜 끝 페이지 번호
		// 총 행 / 한페이지당 개시물 수
		// 55 / 10 = 5.5 -> 소수점 올림처리하여 6
		realEnd = (int)Math.ceil((total * 1.0) / criteria.getAmount());
		
		// 페이지 블럭의 끝번호를 설정
		// 사용자가 직접 페이지 번호를 입력하는 경우
		// 게시물의 끝페이지보다 큰 경우, 게시물의 끝페이지로 설정
		endNo = endNo> realEnd ? realEnd : endNo;

		// 앞으로 이동 / 뒤로 이동
		prev = startNo > 1 ? true : false;
		next = endNo == realEnd ? false : true;
	}




	public int getStartNo() {
		return startNo;
	}



	public void setStartNo(int startNo) {
		this.startNo = startNo;
	}



	public int getEndNo() {
		return endNo;
	}



	public void setEndNo(int endNo) {
		this.endNo = endNo;
	}



	public int getRealEnd() {
		return realEnd;
	}



	public void setRealEnd(int realEnd) {
		this.realEnd = realEnd;
	}



	public boolean isPrev() {
		return prev;
	}



	public void setPrev(boolean prev) {
		this.prev = prev;
	}



	public boolean isNext() {
		return next;
	}



	public void setNext(boolean next) {
		this.next = next;
	}



	public int getTotal() {
		return total;
	}



	public void setTotal(int total) {
		this.total = total;
	}



	public Criteria getCriteria() {
		return criteria;
	}



	public void setCriteria(Criteria criteria) {
		this.criteria = criteria;
	}

}
