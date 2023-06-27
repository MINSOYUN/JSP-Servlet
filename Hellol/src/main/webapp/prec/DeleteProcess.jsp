<%@page import="hotel.Hotel"%>
<%@page import="common.JSFunction"%>
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
	String num = request.getParameter("num");

	//Hotel hotel = new Hotel();
	//hotel.setNum(num);

	HotelDao dao = new HotelDao();
	int res = dao.delete(num);
	
	if(res>0){
		JSFunction.alertLocation("해당 호텔을 삭제하였습니다", "Hotel.jsp", out);
	} else{
		JSFunction.alertBack("호텔을 삭제하지 못했습니다", out);
	}
%>
</body>
</html>