<%@page import="common.JSFunction"%>
<%@page import="hotel.HotelDao"%>
<%@page import="hotel.Hotel"%>
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
	String num = request.getParameter("num");
	String name = request.getParameter("name");
	String star = request.getParameter("star");
	String address = request.getParameter("address");

	Hotel hotel = new Hotel(num, name, star, "", address, "");
	
	HotelDao dao = new HotelDao();
	int res = dao.update(hotel);
	
	if(res > 0){
		// board.getNum 대신 num 사용 가능
		JSFunction.alertLocation("호텔 상세 정보가 수정되었습니다", "View.jsp?num="+ hotel.getNum(), out);
	} else{
		JSFunction.alertBack("호텔 상세 정보 수정 도중 오류가 발생하였습니다", out);
	}
	
%>
</body>
</html>