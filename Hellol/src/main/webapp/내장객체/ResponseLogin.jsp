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
	String pw = request.getParameter("user_pwd");
	out.print("id: " + id + "<br>");
	out.print("pw: " + pw + "<br>");
	
	// 아이디가 abc, 비밀번호가 123이면 로그인성공
	// id 값을 앞에 작성해줘야 null 처리가 나지 않는다
	if("abc".equals(id) && "123".equals(pw)){
			out.print("로그인 성공");
			// 요청할 페이지 정보
			response.sendRedirect("ResponseWelcom.jsp");
		} else{
			
			// RequestDispatcher rd = request.getRequestDispatcher("ResponseMain");
			// rd.forward(request, response);

			
			out.print("로그인 실패");
			response.sendRedirect("ResponseMain.jsp?loginErr=1");   // 넘어갈 때 파라미터 주기
		}
	%>
</body>
</html>