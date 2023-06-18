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
	String name = request.getParameter("name");
	String star = request.getParameter("star");
	// toString() 필수!!! id는 request 아니라 session 이다!!!
	String id = session.getAttribute("user_id") == null? "" : session.getAttribute("user_id").toString();
	String address = request.getParameter("address");
	
	Hotel hotel = new Hotel();
	hotel.setName(name);
	hotel.setStar(star);
	hotel.setId(id);
	hotel.setAddress(address);
	
	HotelDao dao = new HotelDao();
	int res = dao.insertHotel(hotel);
	
	if(res>0){
		JSFunction.alertLocation("호텔이 등록되었습니다", "Hotel.jsp", out);
	} else{
		JSFunction.alertBack("호텔 등록 중 오류가 발생하였습니다", out);
	}

%>
</body>
</html>