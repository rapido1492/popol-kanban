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
			   <c:if test="${empty todo_list}">
					<div class='  todo_done_doing_boardcontainer__board' id="none_todo">
							<h2> 일정이 없습니다. </h2>
					</div>
				</c:if>

				<c:forEach var="todo_vo" items="${todo_list}" >
					<div class='  todo_done_doing_boardcontainer__board'>
						<div class='article_title'>
							<h3>#${todo_vo.pj_name}</h3>
						</div>


						<div class='article_title'>
							<h4>${todo_vo.subject}</h4>
						</div>


						<div class='start_date'>
							<p>${todo_vo.b_date}</p>
						</div>

						<div class='article_content'>
							${todo_vo.b_content}
						</div>

					</div>

				</c:forEach>
</body>
</html>