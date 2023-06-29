package com.library.vo;

public class Book {
	private String no;		// 도서 일련번호
	private String title;	// 도서명
	private String author;	// 작가
	private String publisher;
	private String rentyn;	// 도서 대여여부

	private String ofile;	// 원본 파일명
	private String sfile;	// 저장된 파일명
	
	private String id;  // 대여자 id	
	private String rentno;	
	private String startDate;  // 대여시작일
	private String endDate;  // 반납가능일
	private String returnDate;	// 반납일
	
	private String visitcount;
	private String postdate;
	private String info;
	
	
	// 도서를 추가할 경우 도서명과 작가명만 알고 있으면 생성 가능
	public Book(String title, String author, String publisher, String ofile, String sfile, String info) {
		this.title = title;
		this.author = author;
		this.publisher = publisher;
		// 신규도서이므로 N
		this.rentyn = "N";
		this.ofile = ofile;
		this.sfile = sfile;
		this.info = info;
		
	}
	
	public Book(String title, String author, String publisher, String info) {
		this.title = title;
		this.author = author;
		this.publisher = publisher;
		this.info = info;
		// 신규도서이므로 N
		this.rentyn = "N";
	}
	
	public Book(String no, String title, String author, String publisher, String rentyn, String visitcount, String postdate) {
		super();
		this.no = no;
		this.title = title;
		this.author = author;
		this.publisher = publisher;
		this.rentyn = rentyn;
		this.visitcount = visitcount;
		this.postdate = postdate;
	}
	
	public Book() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		String rentYNStr = "";
		
		// 도서가 rentYN=Y(대여중)인 경우 대여중으로 표시
		if("Y".equals(getRentyn())) {
			rentYNStr="대여중";
		}
		return getNo()
				+ " " + getTitle()
				+ " " + getAuthor()
				+ " " + rentYNStr;
	}
	
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getRentyn() {
		return rentyn;
	}
	public void setRentyn(String rentyn) {
		this.rentyn = rentyn;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}

	public String getPostdate() {
		return postdate;
	}
	public void setPostdate(String postdate) {
		this.postdate = postdate;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public String getVisitcount() {
		return visitcount;
	}

	public void setVisitcount(String visitcount) {
		this.visitcount = visitcount;
	}

	public String getOfile() {
		return ofile;
	}

	public void setOfile(String ofile) {
		this.ofile = ofile;
	}

	public String getSfile() {
		return sfile;
	}

	public void setSfile(String sfile) {
		this.sfile = sfile;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getRentno() {
		return rentno;
	}

	public void setRentno(String rentno) {
		this.rentno = rentno;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getReturnDate() {
		return returnDate;
	}

	public void setReturnDate(String returnDate) {
		this.returnDate = returnDate;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}
	
	
}
