<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>액션태그 - include</title>
</head>
<body>

<%
/*
액션태그
JSP에서 사용하는 표준 태그로 페이지 사이에서 이동을 제어하거나 
자바객체(자바빈)를 생성할때 주로 사용됩니다.

- XML문법을 따르며 반드시 종료태그를 작성 해야 합니다.
- 액션태그 사이에 주석을 사용할 수 없습니다.
- 표현식을 사용 할 수 없습니다.

액션태그의 종류
<jsp:include> 		: 외부파일을 현재 파일에 포함시킵니다
<jsp:forward> 		: 다른 페이지로 요청을 넘깁니다
<jsp:param> 		: 다른 페이지로 매개변수를 전달 합니다.
					  jsp:include, jsp:forward 태그와 함께 사용 합니다.

<jsp:useBean>		: 자바빈을 생성합니다
*/

	pageContext.setAttribute("pAttr", "동명왕");
	request.setAttribute("rAttr", "온조왕");
%>

	<h3>지시어와 액션태그 동작 방식 비교</h3>
	<h4>지시어</h4>
	<%@ include file = "inc/OuterPage1.jsp" %>
	<p> 외부 파일에 선언한 변수 : <%= newVar1 %></p>
	
	<h4>액션태그</h4>
	<!-- 액션태그 방식: 페이지 영역이 공유되지 않는다, 외부파일에서 생성된 변수가 공유되지 않는다 -->
	<jsp:include page="inc/OuterPage2.jsp"/>   <!-- /> 끝태그 의미 -->
	<p> 외부 파일에 선언한 변수 : <%--= newVar2 --%></p> <!-- 외부파일을 컴파일 시켜 가져오기 때문에 공유가 되지 않아 오류가 발생한다 -->
</body>
</html>