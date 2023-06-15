<%@page import="common.JSFunction"%>
<%@page import="dao.BoardDao"%>
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
<%@include file="IsLogin.jsp" %>
<%	
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8");

	// 파라미터를 입력받아 Dto 객체 생성
	String num = request.getParameter("num");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	Board board = new Board(num, title, content, "","","");
	// board.setNum(num);
	// board.setTitle(title);
	// board.setContent(content);
	
	BoardDao dao = new BoardDao();
	int res = dao.update(board);
	
	if(res > 0){
		// board.getNum 대신 num 사용 가능
		JSFunction.alertLocation("게시글이 수정되었습니다", "View.jsp?num="+ board.getNum(), out);
	} else{
		JSFunction.alertBack("게시글 수정 도중 오류가 발생하였습니다", out);
	}
%>
</body>
</html>