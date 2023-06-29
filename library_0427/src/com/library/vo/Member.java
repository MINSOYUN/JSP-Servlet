package com.library.vo;

public class Member {
	private String id;
	private String pw;
	private String name;
	private String adminyn;
	private String status;
	private String grade;
	
	private String ofile;	// 원본 파일명
	private String sfile;  // 저장된 파일명
	
	private String info;
	
	
	// 멤버 조회 시 사용 (사진, 자기소개 첨부 x)
	public Member(String id, String pw, String name, String adminyn, String status, String grade, String info) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.adminyn = adminyn;
		this.status = status;
		this.grade = grade;
		this.info = info;
	}
	
	
	// 로그인 시 사용
	public Member(String id, String pw, String name, String adminyn, String grade) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.adminyn = adminyn;
		this.grade = grade;
	}
	
	
	// 멤버 추가 시 사용
	public Member(String id, String pw, String name, String ofile, String sfile, String info) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.ofile = ofile;
		this.sfile = sfile;
		this.info = info;
		this.adminyn = "N";
		this.status = "N";
		this.grade = "C";
	}



	public Member() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		return getId()
				+ " " + getName()
				+ " " + getAdminyn()
				+ " " + getStatus()
				+ " " + getGrade();
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAdminyn() {
		return adminyn;
	}
	public void setAdminyn(String adminyn) {
		this.adminyn = adminyn;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
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


	public String getInfo() {
		return info;
	}


	public void setInfo(String info) {
		this.info = info;
	}
	
	
	
	
}
