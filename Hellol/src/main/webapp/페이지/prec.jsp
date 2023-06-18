<%@page import="dto.PageDto"%>
<%@page import="dao.Criteria"%>
<%@page import="org.apache.tomcat.util.security.KeyStoreUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	int pageNo = request.getParameter("pageNo") == null ? 1 : Integer.parseInt(request.getParameter("pageNO"));

	Criteria criteria = new Criteria(pageNo);
	
	int total = 300;
	
	PageDto pageDto = new PageDto(total, criteria);
	
	if(pageDto.isPrev()){
		out.print("<input type='button' value='<<' onclick='go(1)'>");
		out.print("<input type='button' value='<<' onclick='go("+(pageDto.getStartNo()-1)+")'>");
	}
	
	for(int i=pageDto.getStartNo(); i<=pageDto.getEndNo(); i++){
		out.print("<input type='button'value='"+i+"' onclick ='go("+i+")'>");
	}
	
	
	if(pageDto.isNext()){
		out.print("<input type='button' value='>' onclick='go("+pageDto.getRealEnd()+")'>");
		out.print("<input type='button' value='>>' onclick='go("+(pageDto.getEndNo()+1)+")'>");
	}
%>
</body>
</html>