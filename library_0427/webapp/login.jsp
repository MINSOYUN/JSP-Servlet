<%@page import="com.util.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel ="stylesheet" href="css/style.css">
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