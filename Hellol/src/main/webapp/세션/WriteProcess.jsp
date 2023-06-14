<%@page import="common.JSFunction"%>
<%@page import="dto.Board"%>
<%@page import="dao.BoardDao"%>
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
	request.setCharacterEncoding("utf-8");

	// 1. 폼 값을 받아서 DTO 객체를 생성
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	// 사용자가 로그아웃을 하지 않았더라도 일정 시간이 경과되면 세션이 제거 되므로 오류가 발생 할 수 있다 
	String id = session.getAttribute("user_id") == null ? "" : session.getAttribute("user_id").toString();
	
	Board board = new Board();
	board.setTitle(title);
	board.setContent(content);
	board.setId(id);
	
	// 2. DAO.insert(...) 호출 : DB에 게시글을 등록하고 결과를 숫자로 반환
	BoardDao dao = new BoardDao();
	int res = dao.insert(board);

	// 3. 등록이 되었으면 리스트 페이지로 이동
	//    등록 실패: 메세지 처리
	if(res>0){
		// 등록 성공
		JSFunction.alertLocation("게시글이 등록 되었습니다", "Board.jsp", out);
%>
	<!-- <script>
		alert("게시글이 등록 되었습니다");
		location.href="Board.jsp";
	</script>  -->

<%
		response.sendRedirect("Board.jsp");
	} else{
		// 등록 실패
		JSFunction.alertBack("게시글 등록 중 오류가 발생하였습니다", out);
%>
	<!-- <script>
		alert("게시글 등록 중 오류가 발생하였습니다");
		history.go(-1); // 전 페이지로 이동
	</script>  -->
<%
	}
%>
</body>
</html>