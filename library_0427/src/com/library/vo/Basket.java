package com.library.vo;

public class Basket {
	private String no;
	private String sfile;
	private String title;	
	private String author;
	private String publisher;
	private String regidate;
	
	
	public Basket(String no, String sfile, String title, String author, String publisher, String regidate) {
		super();
		this.no = no;
		this.sfile = sfile;
		this.title = title;
		this.author = author;
		this.publisher = publisher;
		this.regidate = regidate;
	}

	@Override
	public String toString() {
		return getNo()
				+ " " + getSfile()
				+ " " + getTitle()
				+ " " + getAuthor()
				+ " " + getPublisher()
				+ " " + getRegidate();
	}

	public String getNo() {
		return no;
	}


	public void setNo(String no) {
		this.no = no;
	}


	public String getSfile() {
		return sfile;
	}


	public void setSfile(String sfile) {
		this.sfile = sfile;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getAuthor() {
		return author;
	}


	public void setAuthor(String author) {
		this.author = author;
	}


	public String getPublisher() {
		return publisher;
	}


	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}


	public String getRegidate() {
		return regidate;
	}


	public void setRegidate(String regidate) {
		this.regidate = regidate;
	}
	
}
