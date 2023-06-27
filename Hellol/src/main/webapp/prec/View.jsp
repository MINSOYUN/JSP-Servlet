<%@page import="common.JSFunction"%>
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
<%
	HotelDao dao = new HotelDao();
	Hotel hotel = dao.selectOne(request.getParameter("num"));
	
	if(hotel == null){
		JSFunction.alertBack("해당하는 호텔을 조회할 수 없습니다", out);
		return;
	}
%>

<script>
	function deletePost(){
		var res = confirm("호텔을 삭제하시겠습니까?");
		if(res){
			location.href="DeleteProcess.jsp?num=<%=hotel.getNum()%>";
		}
	}
</script>
<jsp:include page="Link.jsp" />
<h3>호텔 상세 보기</h3>
<form>
	<table border="1" width="90%" >
		<tr  align="center">
			<th>번호</th>
			<td colspan="2"><%=hotel.getNum() %></td>
			<th>작성자</th>
			<td><%=hotel.getId()%></td>
			
		</tr>
		<tr  align="center">
			<th>호텔 이름</th>
			<td colspan="2"><%=hotel.getName() %></td>
			<th>작성일</th>
			<td><%=hotel.getPostdate() %></td>
		</tr>
		<tr>
			<th>성급</th>
			<td colspan="5"><%=hotel.getStar() %></td>
		</tr>
		<tr>
			<th>주소</th>
			<td colspan="5" ><textarea name = "content" style="width:90%; height:100px;"><%=hotel.getAddress() %></textarea></td>
		</tr>
		<tr align="center">
			<td colspan="5">
				<button type="button" onClick="location.href='Hotel.jsp'">목록 보기</button>
				<%
				// 로그인한 아이디와 글쓴이가 같으면 수정, 삭제 버튼 활성화
				if(session.getAttribute("user_id") != null && hotel.getId().equals(session.getAttribute("user_id"))){ %>
				<button type="button" onclick="location.href='Edit.jsp?num=<%= hotel.getNum()%>'">수정하기</button>
				<button type="button" onclick="deletePost()">삭제하기</button>
				<% } %>
			</td>
		</tr>
	</table>
</form>
</body>
</html>