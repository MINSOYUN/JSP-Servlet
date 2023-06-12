<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="loginAction.jsp" method="post">
		<%
		// 쿠키에 저장된 아이디 보여주기
		// 쿠키에 저장된 아이디가 있다면 id 필드의 value 속성에 아이디 값을 넣어줍니다
		Cookie[] cookies = request.getCookies();
		String userId = "";
		// 자바 메서드 사용
		// String userId =CookieManager.readCookie(request, "userId");

		if (cookies != null) {
			for (Cookie cookie : cookies) {
				// String -> .equals 로 비교
				if ("userId".equals(cookie.getName())) { // 로그인 성공 -> 쿠키에 id 저장 -> 저장된 쿠키의 이름 찾기
			userId = cookie.getValue(); // 쿠키의 값 변수에 저장
			out.print("userId: " + userId);
			break; // 아이디 찾으면 반복문 탈출
				}
			}
		}
		

		String name = request.getParameter("name");
		if (name != null && !name.equals("")) {
			out.print("<h3>" + name + "님 환영합니다. </h3>");
		} else {
		%>
		
		<!-- 로그인 성공하면 div 안보이게 else에서만 출력되게 한다 -->
		<div class='loginbox'>
			<div id='login'>
				<input type="text" name="userid" id="userid"placeholder='ID를 입력해주세요.' required value="<%=userId%>"><br>
				<input type="password" name="userpw" id="userpw" placeholder='PW를 입력해주세요.' required><br>
				<input type="checkbox" name="save_check" value="Y">아이디 저장하기
			</div>
			<div id='button'>
				<input type="submit" value="로그인">
			</div>
		</div>
		<div id='info'>
			<a href="">회원가입</a> <a href="">ID찾기</a> <a href="">PW찾기</a>
		</div>
	</form>
	<%
	}
	%>
</body>
</html>