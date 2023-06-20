<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.Member"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 
JSTL(JSP Starndard Tag Library)
JSP의 표준태그라이브러리를 이용하면 스크립틀릿을 사용하지 않고 태그를 사용하여 제어문, 반복문 등을 사용할 수 있다
기본태그가 아닌 확장태그이므로 사용하기 위해서 별도의 라이브러리가 필요하다
메이븐리파지토리로 접근하여 jstl-1.2jar 파일을 다운로드 받고 lib 폴더에 추가한다

JSTL 종류
	core 태그: 변수 선언, 조건문 / 반복문, URL 처리
	접두어 : c
	
	Formatting 태그: 숫자, 날짜, 시간 포맷 지정
	접두어: fmt
	
	1. 라이브러리 추가
	2. taglib 지시어 추가
 -->
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <!-- 1. 변수 선언
 	var: 변수명
 	value: 값
 	scope: 저장영역
 	 -->
 	 <c:set var="directVar" value="100"/>
 	 <c:set var="elVar" value="${directVar mod 5 }"/>
 	 <c:set var="expVar" value="<%=new Date() %>"/>
 	 <c:set var="betweenVar">변수값 요렇게 설정</c:set>
 	 
 	 <h4>EL을 이용해 변수 출력</h4>
 	 <ul>
 	 	<li>directVar : ${pageScope.directVar }</li>
 	 	<li>elVar : ${elVar}</li>
 	 	<li>expVar : ${expVar}</li>
 	 	<li>betweenVar : ${betweenVar}</li>
 	 </ul>
 	 
 	 <h4>자바빈즈 생성1 - 생성자 사용</h4>
 	 <!-- 생성하기 위해서는 지시어 사용할 수 밖에! -->
 	 <c:set var="personVar1" value='<%=new Member("id", "", "하니", "2023-06-20") %>' scope="request"></c:set>
 	 <ul>
 	 	<li>${personVar1.id }</li>
 	 	<li>${requestScope.personVar1.name }</li>
 	 </ul>
 	 
 	 <h3>자바빈즈 생성 후 값을 변경하기</h3>
 	 <h4>자바빈즈 생성2 - target, property 사용</h4>
 	 <!-- 
 	 자바빈즈 생성 후 값을 변경해봅시다
 	 target : 자바빈즈 변수명
 	 property : 자바빈즈 속성명(멤버변수명)
 	 value : 값 지정
 	  -->
 	 <c:set var="personVar2" value='<%=new Member("hani", "", "하니", "2023-06-20") %>' scope="request"></c:set>
 	 <ul>
 	 	<li>변경 전 아이디: ${requestScope.personVar2.id }</li>
 	 	<li>변경 전 이름: ${personVar2.name }</li>
 	 </ul>
 	 <c:set target="${personVar2}" property="id" value="hani1234"></c:set>
 	 <c:set target="${personVar2}" property="name" value="하니1234"></c:set>
 	  <ul>
 	 	<li>변경 후 아이디: ${requestScope.personVar2.id }</li>
 	 	<li>변경 후 이름: ${personVar2.name }</li>
 	 </ul>
 	 
 	
 	 <h4>List 컬렉션 이용하기</h4>
 	 <%
 	 ArrayList<Member> list = new ArrayList<Member>();
 	 list.add(new Member("hani","","하니",""));
 	 list.add(new Member("nami","","나미",""));
 	 %>
 	 <c:set var="pList" value="<%=list %>" scope="request"></c:set>
 	 <ul>
 	 	<li>아이디: ${pList[0].id }</li>
 	 	<li>이름: ${requestScope.pList[0].name}</li>
 	 	<li>아이디: ${pList[1].id }</li>
 	 	<li>이름: ${requestScope.pList[1].name}</li>
 	 </ul>
 	 
 	 <h4>map 컬렉션 이용하기</h4>
 	 <%
 	 Map<String, Member> map = new HashMap<String, Member>();
 	 map.put("pArg1", new Member("id1","","이름1", ""));
 	 map.put("pArg2", new Member("id2","","이름2", ""));
 	 %>
 	 <c:set var="map" value="<%=map %>" scope="request"></c:set>
 	 <ul>
 	 	<li>아이디: ${map.pArg1.id }</li>   <!-- map은 키값을 통해 접근해야 한다 -->
 	 	<li>이름: ${requestScope.map.pArg1.name}</li>
 	 	<li>아이디: ${map.pArg2.id }</li>
 	 	<li>이름: ${map.pArg2.name}</li>
 	 </ul>
</body>
</html>