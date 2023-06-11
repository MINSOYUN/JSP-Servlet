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
	// name 속성의 값을 매개값으로 넘겨주면 value 속성의 값을 반환합니다
	String id = request.getParameter("userid");
	String pw = request.getParameter("userpw");
	
	// 아이디 저장 체크박스
	String saveYN = request.getParameter("save_check");
	out.print("saveYN: " + saveYN+ "<br>");
	
	// 아이디 저장하기 체크박스에 체크가 되었다면 쿠키에 아이디가 저장됩니다
	if("Y".equals(saveYN)){
		// CookieManager 를 이용하여 쿠키를 생성 후 응답객체에 담아줍니다
		// CookieManager.makeCookie(response, "userId",id, 3600);
		
		// 쿠키 생성하기
		Cookie cookie = new Cookie("userId", id);
		// 유지시간 설정 3600 -> 1h
		cookie.setMaxAge(3600);
		// 응답객체에 담기
		response.addCookie(cookie);
	}
	
	
	if("abc".equals(id) && "123".equals(pw)){
		out.print("로그인 성공");
		response.sendRedirect("login.jsp?name="+id);
	} else{
		out.print("로그인 실패");
	 }
	%>
</html>