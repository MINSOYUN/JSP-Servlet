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
	request.setCharacterEncoding("utf-8");
	
	String num = request.getParameter("num");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	Board board = new Board(num, title, content, "","","");
	
	NewBoardDao dao = new NewBoardDao();
	int res = dao.update(board);
	
	if(res>0){
		JSFunction.alertLocation("수정 완료됐습니다", "View.jsp?name="+board.getNum(), out);
	} else{
		JSFunction.alertBack("게시글 수정에 실패하였습니다", out);
	}
%>
</body>
</html>