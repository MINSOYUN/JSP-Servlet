<%@page import="dao.NewBoardDao"%>
<%@page import="common.JSFunction"%>
<%@page import="dto.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@include file="../세션/IsLogin.jsp" %>
<%@include file="../세션/Link.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	String id = session.getAttribute("user_id") == null ? "" : session.getAttribute("user_id").toString();
	
	Board board = new Board();
	board.setTitle(title);
	board.setContent(content);
	board.setId(id);
	
	NewBoardDao dao = new NewBoardDao();
	int res = dao.insert(board);
	
	if(res > 0){
		JSFunction.alertLocation("게시글이 등록되었습니다", "List.jsp", out);
	} else {
		JSFunction.alertBack("게시글이 등록되지 않았습니다", out);
	}

%>
</body>
</html>