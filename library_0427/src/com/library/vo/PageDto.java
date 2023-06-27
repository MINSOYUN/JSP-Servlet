package com.library.vo;

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

		endNo = (int)Math.ceil(criteria.getPageNo() / 5.0) * 5;
		System.out.println("pageNo : " + criteria.getPageNo());
		startNo = endNo - (5-1);
		
		realEnd = (int)Math.ceil((total * 1.0) / criteria.getAmount());
		
		endNo = endNo> realEnd ? realEnd : endNo;

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
