<%@page import="dao.MemberDao"%>
<%@page import="dto.Member"%>
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
	String id = request.getParameter("user_id");
	String pw = request.getParameter("user_pw");
	
	MemberDao dao = new MemberDao();
	Member member = dao.login(id, pw);
	
	if(member != null){  // 아이디, 비밀번호가 있다면
		session.setAttribute("user_id", member.getId());
		session.setAttribute("member", member);
		
		response.sendRedirect("Hote.jsp");
	} else{
		request.setAttribute("LoginErrMsg", "아이디 / 비밀번호가 일치하지 않습니다");
		// 이건 뭐지  ????????????
		request.getRequestDispatcher("LoginForm.jsp").forward(request, response);
	}
	%>
</body>
</html>