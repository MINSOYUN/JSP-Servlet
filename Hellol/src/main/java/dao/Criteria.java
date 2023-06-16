package dao;

public class Criteria {
	
	// null 방지 위해 "" 공백초기화  !!!!!!!
	private String searchField="";  // 검색 조건
	private String searchWord="";   // 검색어
	
	// 초기화
	int pageNo = 1; // 요청한 페이지 번호
	int amount = 10; // 한 페이지당 보여질 게시물 수
	
	int startNo = 1; 
	int endNo = 10;
	

	public Criteria(int pageNo) {
		if(pageNo>0) {
			this.pageNo = pageNo;
			endNo = pageNo * amount;
			startNo = pageNo  * amount - (amount -1);
		}
	}
	
	

	// 사용자가 직접 페이지번호와, 한 페이지당 게시물 수 고를 수 있는 경우 사용
	public Criteria(int pageNo, int amount) {
		super();
		this.pageNo = pageNo;
		this.amount = amount;
	}



	public Criteria(String searchField, String searchWord, int pageNo) {
		if(searchWord != null) {
			this.searchField = searchField;
			this.searchWord = searchWord;
		}
		if(pageNo > 0 ) {
			this.pageNo = pageNo;
			endNo = pageNo * amount;
			startNo = pageNo  * amount - (amount -1);
		}
	}
	
	
	// pageNoStr 타입 String 일 때 int로 형변환 후 page>0 조건 걸기 
	public Criteria(String searchField, String searchWord, String pageNoStr) {
		if(searchWord != null) {
			this.searchField = searchField;
			this.searchWord = searchWord;
		}
		
		if(pageNoStr != null) {
			pageNo = Integer.parseInt(pageNoStr);
			
			if(pageNo > 0 ) {
				this.pageNo = pageNo;
				endNo = pageNo * amount;
				startNo = pageNo  * amount - (amount -1);
			} else {
				pageNo = 1;
			}
			
		} 
		
	}
	
	
	public String getSearchField() {
		return searchField;
	}
	public void setSearchField(String searchField) {
		this.searchField = searchField;
	}
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
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
	
	

}