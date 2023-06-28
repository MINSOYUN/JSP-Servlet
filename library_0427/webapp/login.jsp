<%@page import="com.util.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body{
		background-color: #f2f2f2;
		display: flex;
        justify-content: center;
	}
	
	#rightside {
		width: 300px;
		background-color: #f2f2f2;
		padding: 20px;
	}

	.side1 {
		margin-top: 50px;
	}
	
	.loginbox {
		margin-bottom: 20px;
	}

	#login input[type="text"], #login input[type="password"] {
		width: 80%;
		padding: 10px; 
		margin-bottom: 10px;
		border-radius: 5px;
		border: 1px solid #ccc;
	}

	#info {
		font-size: 12px;
		color: #777;
	}

	#info input[type="checkbox"] {
		margin-right: 5px;
	}

	#info a {
		margin-right: 10px;
		text-decoration: none;
		color: #777;
	}

</style>
</head>
<body>
<aside id='rightside'>
  <div class = 'side1'>
         <%
         String error = request.getParameter("loginError");
         if(error != null && "Y".equals(error)){
        	 out.print("<script>alert('아이디 비밀번호를 확인해주세요')</script>");
         }
         
         String userId =CookieManager.readCookie(request, "userId");
         
 
         String name = request.getParameter("name");
         
         if(name != null && !name.equals("")){
        	 out.print("<h1>"+name+"님 환영합니다. </h1>");          	 
		 } else{
         %>   <!-- 로그인 성공하면 div 안보이게 else에서만 출력되게 한다 -->
		<form action ="./login/loginAction.do" method = "post"> <!-- 나의 현재위치 ./을 기준으로 위치 잡기 -->
             <div class='loginbox'>
                 <div id='login'>
                     <input type="text" name="userid" id="userid" placeholder='ID를 입력해주세요.' value=<%=userId %>>
                     <input type="password" name="userpw" id="userpw" placeholder='PW를 입력해주세요.'>
                 </div>
                 <div id='button'>
                 <input type="submit" value="로그인">
                 </div>
             </div>
             <div id='info'>
             <input type="checkbox" name=saveCheck value="Y" <%= ! ("").equals(userId) ? "checked" : "" %>>아이디 저장
                 <a href="">회원가입</a>
                 <a href="">ID찾기</a>
                 <a href="">PW찾기</a>
             </div>
         </form>
         <% } %>
  </div>
</aside>
</body>
</html>