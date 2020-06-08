<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="bootstrap.jsp" %>
<%@ include file = "/WEB-INF/views/login/logincheck.jsp" %>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<head>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.4.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
		
		<!-- Bootstrap core CSS -->
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
		<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
		
	</head>
	
	<body>
	<c:import url="/upmenubar.do">
		<c:param name="m_idx" value="${m_idx}"/>
	</c:import>
	<jsp:include page="../menubar/leftmenubar.jsp"/>
	<div class="container">
        <table class="table table-bordered table-condensed table-striped table-hover" id="user-table">
		<thead class="thead-dark">
			<tr>
				<th scope="col">분류</th>
				<th scope="col">우선순위</th>
				<th scope="col">번호</th>
				<th scope="col">제목</th>
				<th scope="col">작성자</th>
				<th scope="col">작성일</th>
				<th scope="col">조회수</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${!empty list}">
			<c:forEach var="vo" items="${list}">
				<tr>
					<!-- 분류 -->
					<td>
						<c:if test="${vo.division eq 'todo' }">
							<button type="button" class="btn btn-success">to do</button>
						</c:if>
						<c:if test="${vo.division eq 'doing' }">
							<button type="button" class="btn btn-warning">doing</button>
						</c:if>
						<c:if test="${vo.division eq 'done' }">
							<button type="button" class="btn btn-primary">done</button>
						</c:if>
					</td>
					<!-- 우선순위 -->
					<td>
						<c:if test="${vo.priority eq '3' }">
							<button type="button" class="btn btn-danger">높음</button>
						</c:if>
						<c:if test="${vo.priority eq '2' }">
							<button type="button" class="btn btn-warning">중간</button>
						</c:if>
						<c:if test="${vo.priority eq '1' }">
							<button type="button" class="btn btn-success">낮음</button>
						</c:if>
					</td>
					<!-- 번호 -->
					<td>${vo.b_idx}</td>
					<td>
					<!-- 제목 -->
					<a href="bbsboard_view.do?b_idx=${vo.b_idx} &m_idx=${m_idx}
												&page=${empty param.page ? 1 : param.page} "
								class="num" style="color: black"> ${vo.subject}
							</a>
					</td>
					<!-- 작성자 -->
					<td>${vo.m_nick }</td>
					<!-- 작성일 -->
					<td>${vo.b_date}</td> 
					<!-- 조회수 -->
					<td>${vo.readhit}</td> 
				</tr>
			</c:forEach>
		</c:if>
			<!-- 데이터가 없는 경우 -->
			<c:if test="${empty list}">
			<tr>
				<td align="center" colspan="11" width="100%" height="50">
					현재 등록된 글이 없습니다.
				</td>
			</tr>
			</c:if>
		</tbody>
	</table>
	${pageMenu}
	<div class="form-group row justify-content-center">
		<form action="search.do" method="post">
			<div class="w10" style="padding-right:10px">
				<select id="search_value" name="search_value">
					<option value="all">제목+본문</option>
					<option value="subject">제목</option>
					<option value="content">본문</option>
					<option value="writer">닉네임</option>
				</select>
			</div>
			<div class="w300" style="padding-right:10px">
				<input type="text" name="keyword" id="keyword">
			</div>
			<div>
				<button class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch" onclick="location.href='search.do'">검색</button>
			</div>
		  </form>
		  <br />
		  	<button type="button" class="btn btn-primary" onclick="location.href='bbsboard_insert_form.do'">등록</button>
		</div>
	</div>
</body>
</html>