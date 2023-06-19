<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>EL 폼값 받기</h3>
<ul>
	<li>이름: </li>
		${param.name }
	<li>성별: </li>
		${param.gender }
	<li>학력: </li>
		${param.grade }
	<li>관심사항: </li>
		${paramValues.inter[0] }
		${paramValues.inter[1] }
		${paramValues.inter[2] }
		${paramValues.inter[3] }
</ul>
</body>
</html>