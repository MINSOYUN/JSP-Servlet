<%@page import="common.JSFunction"%>
<%@page import="dao.NewBoardDao"%>
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
<%
	String num = request.getParameter("num");
	Board board = new Board();
	board.setNum(num);
	
	NewBoardDao dao = new NewBoardDao();
	int res = dao.delete(num);
	
	if(res>0) {
		JSFunction.alertLocation("게시글을 삭제하였습니다", "List.jsp", out);
	} else{
		JSFunction.alertBack("게시글 삭제에 실패하였습니다", out);
	}
%>
</body>
</html>