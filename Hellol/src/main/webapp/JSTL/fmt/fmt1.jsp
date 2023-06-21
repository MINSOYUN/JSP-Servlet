
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 
formatNumber
var : 변수명(변수명을 지정하지 않으면 바로 출력)
value : 출력할 숫자
pattern : 숫자패턴
scope : 영역

type : 출력양식을 설정
- percent : 퍼센트
- currency : 통화
- number : 기본값, 일반 숫자
groupingUsed : 구분기호 사용여부
 -->
	 <c:set var="num" value="12345"/>
	 <h4>숫자 포맷 설정</h4>
	 콤마 출력 o : <fmt:formatNumber value="${num }"/> <br>
	 콤마 출력 x : <fmt:formatNumber value="${num }" groupingUsed = "false"/> <br>
	 
	 변수에 저장 : <fmt:formatNumber value="${num }" var="saveVar" type="currency"/> <br>
	 변수에 저장된 값 출력 : ${saveVar } <br>
	 
	 퍼센트 : <fmt:formatNumber value="0.03" type="percent"/>
	 
	 <h4>패턴을 지정하여 숫자를 활용</h4>
	 <c:set var="num1" value="12345.0111"/>
	 0, # : 자릿수를 의미 <br>
	 0 표현 : 해당 자리에 수가 없으면 0으로 출력 -> 자리수를 맞춰서 출력하고 싶을 때 <br>
	 # 표현 : 자리에 수가 없으면 공란으로 표시 <br>
	 <fmt:formatNumber value="${num1 }"/> <br>
	 <fmt:formatNumber value="${num1 }" pattern="0,00.0"/> <br> <
	 <fmt:formatNumber value="${num1 }" pattern="0,000,00.0"/> <br>
	 <fmt:formatNumber value="${num1 }" pattern="#,###.##"/> <br>
	 <fmt:formatNumber value="${num1 }" pattern="###,###.000000"/> <br>
	 
	 <fmt:parseNumber value="${num1 }" integerOnly = "true" var="saveVar"/> <br>
	 정수 부분만 : ${saveVar }
	 
	 <h4>날짜 포맷</h4>
	 <!-- 풀날짜아닌..?<%=new java.util.Date() %> -->
	 <c:set var="today" value="<%=new Date() %>"/>
	 오늘 날짜: ${today }<br>
	 full : <fmt:formatDate value="${today }" type="date" dateStyle="full"/> <br>
	 short : <fmt:formatDate value="${today }" type="date" dateStyle="short"/> <br>
	 long : <fmt:formatDate value="${today }" type="date" dateStyle="long"/> <br>
	 default : <fmt:formatDate value="${today }" type="date" dateStyle="default"/> <br>
	 medium : <fmt:formatDate value="${today }" type="date" dateStyle="medium"/> <br>
	 
	 <h4>시간 포맷</h4>
	 full : <fmt:formatDate value="${today }" type="time" timeStyle="full"/> <br>
	 short : <fmt:formatDate value="${today }" type="time" timeStyle="short"/> <br>
	 long : <fmt:formatDate value="${today }" type="time" timeStyle="long"/> <br>
	 default : <fmt:formatDate value="${today }" type="time" timeStyle="default"/> <br>
	 medium : <fmt:formatDate value="${today }" type="time" timeStyle="medium"/> <br>
	 
	 <h4>날짜 / 시간 표시</h4>
	 <fmt:formatDate value="${today }" type="both" dateStyle="full" timeStyle="long"/> <br>
	 
	 <h4>pattern 지정 후 출력</h4>
	 <fmt:formatDate value="${today }" type="both" pattern="yyyy-mm-dd hh:mm:ss"/> <br>
	 
	 <h4>타임존 설정</h4>
	 <!-- 세계 협정시(GMT) -->
	 <fmt:timeZone value="GMT">
	 	<fmt:formatDate value="${today }" type="both" dateStyle="full" timeStyle="full"/> 	<br>
	 </fmt:timeZone>
	 
	  <fmt:timeZone value="America/Chicago">
	 	<fmt:formatDate value="${today }" type="both" dateStyle="full" timeStyle="full"/> 	<br>
	 </fmt:timeZone>
	 
	 <h4>로케일 설정</h4>
	 <c:set var="today" value="<%= new java.util.Date() %>"/>
	 
	 한글로 설정 : <fmt:setLocale value="ko_kr"/>
	 <fmt:formatNumber value="10000" type="currency"/> /
	 <fmt:formatDate value="${today }"/> <br>
	 
	 일어로 설정 : <fmt:setLocale value="ja_jp"/>
	 <fmt:formatNumber value="10000" type="currency"/> /
	 <fmt:formatDate value="${today }"/> <br>
	 
	 영어로 설정 : <fmt:setLocale value="en_us"/>
	 <fmt:formatNumber value="10000" type="currency"/> /
	 <fmt:formatDate value="${today }"/> <br>
</body>
</html>