<%@page import="dao.Criteria"%>
<%@page import="dto.PageDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>페이지 page</title>
</head>
<body>
	<!--
	 PageDto 객체를 가지고 페이지 블럭을 생성 (필요 요소)
	- 페이지 블럭의 시작번호 (startNo)
	- 페이지 블럭의 끝번호 (endNo)
	- 게시물의 끝 페이지 번호(realEnd)
	- 이전 버튼 출력 여부 (prev) (true / false)
	- 다음 버튼 출력 여부 (next) (true / false)
	 -->
<%
	// 총게시물수, Criteria 검색조건(페이지번호, 페이지당 게시물수, 검색어, 검색조건)
	int totalCnt = 300;

	// totalCnt, pageNo 세팅 필요 !!!
	int pageNo = request.getParameter("pageNo") == null ? 1 : Integer.parseInt(request.getParameter("pageNo"));
	Criteria criteria = new Criteria(pageNo); 
	
	PageDto pageDto = new PageDto(totalCnt, criteria);	
	
	
	// 시작 페이지의 번호가 1보다 크면 true -> 이전버튼 생성
	if(pageDto.isPrev()){
		out.print("<a href='pageDto.jsp?pageNo="+(pageDto.getStartNo()-1)+"'>");
		out.print("<");
		out.print(" </a>");
	}
	
	for(int i= pageDto.getStartNo(); i<= pageDto.getEndNo(); i++){
		out.print(i);
		out.print("<a href='pageDto.jsp?pageNo="+ i +"'");
		out.print(" </a>");
	}
	
	// 마지막 페이지의 번호가 게시물의 끝 페이지 번호와 일치하지 않으면 true -> 다음버튼 생성
	if(pageDto.isNext()){
		out.print("<a href='pageDto.jsp?pageNo="+(pageDto.getEndNo()+1)+"'>");
		out.print(">");
		out.print(" </a>");
	}
%>
</body>
</html>