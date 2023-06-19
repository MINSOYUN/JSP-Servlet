<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>각 영역에 저장된 속성 읽기</h3>
<ul>
	<li>페이지 영역</li>
		${pageScope.scopeValue}
	<li>리퀘스트 영역</li>
		${requestScope.scopeValue} 
	<li>세션 영역</li>
		${sessionScope.scopeValue}
	<li>애플리케이션 영역</li>
		${applicationScope.scopeValue}
</ul>

<h3>영역 지정없이 속성 읽기</h3>
<ul>
	<li>${scopeValue} </li>
</ul>
</body>
</html>