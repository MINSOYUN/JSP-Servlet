<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">

      #header a:hover{
      		display: inline-block;
            background-color: rgba(247, 176, 150, 0.733);
            font-weight: bold;
            border-radius:20%;
        }
      #header div {
 	 		display: inline-block;
 	 		margin-right: 100px;
 	 		border-radius: 20%;
		}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<header>

	userId : ${sessionScope.userId }
	adminYn : ${sessionScope.adminYn }
<table border="2" width="100%" style="border-collapse: collapse; height:50px" id="header">
    <tr>
	<!-- 어드민 -->
		<td align="center">
			<c:if test="${sessionScope.adminYn eq 'Y'}" var="res">
				<div>로고</div>
				<div><a href="../loginAdmin.jsp">도서관리</a></div>
				<div><a href="../loginAdmin2.jsp">사용자관리</a></div>
			</c:if>
	
	<!-- 사용자 -->
			<c:if test="${sessionScope.adminYn eq 'N'}">
				<div>로고</div>
				<div>
					<a href="">도서관리시스템</a>
					<a href="">마이페이지</a>
				</div>
			</c:if>			
    
	<!-- 로그인 x -->
			<c:if test="${empty sessionScope.userId }" var="res1">
				<div><a href="./../login.jsp">로그인</a></div>
			</c:if>
	<!-- 로그인 후 -->		
			<c:if test="${not res1}" var="res1">
				<div><a href="../login.jsp">로그아웃</a></div>
			</c:if>
		</td>
   </tr>

</table>	

</header>

</body>
</html>