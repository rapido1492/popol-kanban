<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:import url="/upmenubar.do">
		<c:param name="m_idx" value="${m_idx}"/>
	</c:import>
	<jsp:include page="../menubar/leftmenubar.jsp"/>
	
	${ vo.m_idx }
	
	<br>

	비어있음.

</body>
</html>