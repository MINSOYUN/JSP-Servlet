<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="./login.jsp" method="post">
        아이디 : <input type="text" name="user_id" required = "required"/><br />
        패스워드 : <input type="text" name="user_pwd" required = "required"/><br />
        <input type="submit" value="로그인" />
    </form>
    <%
    String err = request.getParameter("err");
    
    if(err !=null && ! err.equals("")){
    	out.print("로그인실패");
    }
    %>
</body>
</html>