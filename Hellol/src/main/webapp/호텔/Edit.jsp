<%@page import="hotel.Hotel"%>
<%@page import="hotel.HotelDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="Link.jsp" />
<%
	String num = request.getParameter("num");
	HotelDao dao = new HotelDao();
	Hotel hotel = dao.selectOne(num);
%>
<h3>수정하기</h3>
	<form name= "EditFrm" action="EditProcess.jsp" method="post">
	<input type="hidden" name="num" value="<%=num%>"/>
	<table border="1" width="90%">
		<tr>
			<th>호텔 이름</th>
			<td><input type="text" value="<%=hotel.getName() %>" name="name" style="width:90%;"></td>
		</tr>
		<tr>
			<th>호텔 성급</th>
			<td>
				<select name="star"> 
					<option value="5성급">5성급</option> 
					<option value="4성급">4성급</option> 
					<option value="3성급">3성급</option> 
				</select>
			</td>
		</tr>
		<tr>
			<th>주소</th>
			<td><textarea name = "address" style="width:90%; height:100px;"><%=hotel.getAddress() %></textarea></td>
		</tr>
		<tr>
			<td colspan="2"  align="center">
				<button type="submit">수정 완료</button>
				<button type="reset">초기화</button>
				<button type="button" onClick="location.href='Board.jsp'">목록 보기</button>
			</td>
		</tr>
	</table>
	</form>
</body>
</html>