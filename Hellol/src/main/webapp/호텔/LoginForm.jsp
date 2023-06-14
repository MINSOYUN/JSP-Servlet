<%@page import="dto.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head><title>Session</title></head>
<body>
	<jsp:include page="Link.jsp" />
    <h2>로그인 페이지</h2>
    <span style="color: red; font-size: 1.2em;"> 
    </span>
    
    <%
    if(session.getAttribute("user_id") == null){
    %>
    <form action="LoginProcess.jsp" method="post" name="loginFrm"
        onsubmit="return validateForm(this);">
        아이디 : <input type="text" name="user_id" required="required"/><br />
        패스워드 : <input type="password" name="user_pw" required="required"/><br />
        <input type="submit" value="로그인하기" />
    </form>
	<% } else {
		String name = "";
    	if(session.getAttribute("member") != null){
	    	Member member = (Member)session.getAttribute("member");
	    	name = member.getName();
    }
	%>
	<%= name %> 님 환영합니다
	<% } %>
</body>
</html>