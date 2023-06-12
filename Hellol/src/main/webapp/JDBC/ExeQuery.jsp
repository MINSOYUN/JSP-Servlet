<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="common.ConnectionUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>회원목록 조회</h3>
	<table border='1'>
	<%
	Connection con = ConnectionUtil.getConnection();
	String sql = "select id, name, regidate from member";
	PreparedStatement stmt = con.prepareStatement(sql);
	
	// 쿼리 실행
	ResultSet rs = stmt.executeQuery();
	
	// 목록 가지고 오기 위해 if 말고 while 사용 -> 왜?
	while(rs.next()){
		String id = rs.getString("id");
		String name = rs.getString("name");
		String regidate = rs.getString("regidate");
		
		out.print(
				String.format("<tr> <td>%s</td> <td>%s</td> <td>%s</td> </tr>", id, name, regidate)
				);
	}
	rs.close();
	stmt.close();
	con.close();
	%>
	</table>
</body>
</html>