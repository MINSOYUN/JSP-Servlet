<%@page import="utils.CookieManager"%>
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
		
      String id = request.getParameter("userid");   // String 반환
      String pw = request.getParameter("userpw");
      
      // 체크박스가  체크되었을 경우, 아이디를 쿠키에 저장
      String saveCheck = request.getParameter("saveCheck");
      out.print("saveCheck: "+ saveCheck);   // 출력 안될 시 확인
		if("Y".equals(saveCheck) && saveCheck != null){
			// 쿠키 생성
			CookieManager.makeCookie(response, "userId",id, 3600);
		}
		
      if("abc".equals(id) && "123".equals(pw)){
    	  // 로그인 성공
          //response.sendRedirect("gogreen.jsp?name="+id);
    	  // 세션에 id 저장
    	  session.setAttribute("id", id);
    	  response.sendRedirect("gogreen.jsp");
      } else{
    	  // 로그인 실패
          response.sendRedirect("gogreen.jsp?loginErr=Y");
      }
                
    %>
</body>
</html>