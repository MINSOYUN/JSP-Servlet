<%@page import="java.util.List"%>
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

<jsp:include page="Link.jsp"></jsp:include>

<%
	String searchFiled = request.getParameter("searchFiled");
	String searchWord = request.getParameter("searchWord");
	
	searchWord = searchWord == null? "" : searchWord;
	
	HotelDao dao = new HotelDao();
	// 필요한 이유 이해하기!!!!!!!!!!!!
	List<Hotel> hotelList = dao.getList(searchFiled, searchWord);
	int totalCnt = dao.getTotalCnt(searchFiled, searchWord);
	
%>


<h3>서울 Hotel 목록</h3>
총건수: <%=totalCnt %>
<!-- 검색폼 -->
<form> 
	<table border=1 width="90%">
		<tr align="center">
		  <td>
			<select name="searchFiled"> 
				<option value="title">제목</option> 
				<option value="content">내용</option>
			</select>
				<input type="text" name="searchWord" value="<%= searchWord%>">
				<input type="submit" value="검색하기">
		  </td>
		</tr>
	</table>
</form>
<!-- 검색폼 끝 -->

<table border="1" width="90%">
	<tr>
		<th>번호</th> 
		<th>제목</th>
		<th>내용</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>조회수</th>
	</tr>
	<%
	// null 이 아니라 isEmpty !!!!
	if(hotelList.isEmpty()){
	%>
	<tr>
		<td colspan = 5 align ="center"></td>
	</tr>
	<% } else{
		for(Hotel hotel : hotelList){ %>
	<tr>
		<td><%=hotel.getNum() %></td>
		<td><%=hotel.getName() %></td>	
		<td><%=hotel.getStar() %></td>	
		<td><%=hotel.getId() %></td>	
		<td><%=hotel.getAddress() %></td>	
		<td><%=hotel.getPostdate() %></td>			
	</tr>
	<% 
		}
	} %>
</table>


<%
	if(session.getAttribute("user_id") != null){
%>
<table border=1 width="90%">
	<tr>
		<td align="right">
			<input type="button" value="호텔추가" onclick="location.href='Write.jsp'">
		</td>
	</tr>
</table>
<%		
	}
%>
</body>
</html>