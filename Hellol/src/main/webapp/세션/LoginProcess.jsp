<%@page import="dto.Board"%>
<%@page import="java.util.List"%>
<%@page import="javax.swing.plaf.metal.MetalBorders.Flush3DBorder"%>
<%@page import="javax.swing.plaf.metal.MetalBorders.Flush3DBorder"%>
<%@page import="dto.Member"%>
<%@page import="dao.MemberDao"%>
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
	// id, pw 값 가져오기 geParameter()
	// form 요소의 값을 읽어오는 것이 get, set은 내가 저장하는 것
	String id = request.getParameter("user_id");
	String pw = request.getParameter("user_pw");

	MemberDao dao = new MemberDao();
	Member member = dao.login(id, pw);  // dao는 member 반환

	if(member != null){
		// 로그인 성공 -> 세션에 member 객체를 저장
		// Object 타입
		session.setAttribute("user_id", member.getId());
		session.setAttribute("member", member);
		
		// response.sendRedirect("LoginForm.jsp");
		response.sendRedirect("Board.jsp");
	} else{
		// 로그인 실패 -> loginFrom 페이지로 이동, 오류메세지 출력(로그인 실패 인식 하기 위해)
		request.setAttribute("LoginErrMsg", "아이디, 비밀번호가 일치하지 않습니다");
		// request 영역을 공유하기 위해 forward(getRequestDispatcher의 객체) 사용
		request.getRequestDispatcher("LoginFrom.jsp").forward(request, response);
	}

%>
	
</body>
</html>