<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  	
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<div class="card text-black bg-primary mb-3 no-move" id="g_member5">
	<div class="card-header"> Nickname (Member-Email)</div>
</div>
<c:forEach var="g_vo" items="${g_list}">
<div id="${g_vo.m_idx}">
<div class="card text-black bg-primary mb-3" id="g_member4">
<input type="hidden" name='g_update_idx' value="${g_vo.m_idx}"/>
<c:if test="${g_vo.m_idx eq g_vo.g_leader}">
	<div class="card-header">${g_vo.m_nick} (${g_vo.m_email}) <input type="radio" name="leader" value="${g_vo.m_idx}" class="g_radio" checked="checked"/></div>
</c:if>	
<c:if test="${g_vo.m_idx ne g_vo.g_leader}">
	<div class="card-header">${g_vo.m_nick} (${g_vo.m_email}) <input type="radio" value="${g_vo.m_idx}" name="leader" class="g_radio"/></div>
</c:if>	
</div>
</div>
</c:forEach>
</body>
</html>