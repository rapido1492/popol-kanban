<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/menubar/upmenubar.css">

<!-- <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script> -->

<script type="text/javascript">

$(document).ready(function(){
	  $("#flip").click(function(){
		  $("#nav5").slideToggle(1500);
	  });
	});
	
function includepopup() {
	window.open("invite_alert.do", "include", "width=400, height=300, left=100, top=50");
}

</script>

</head>
<body>

<div class="header5">
		<div class="logo5">
			<p><span>LSJR </span></p>
		</div>
		<div id="flip5"><p>Menu</p></div>
		<nav id="nav5">
			<ul>
				<li><a href="mypage.do">Home </a></li>

				<li><a href="logout.do">log out</a></li>
				<li><a href="signchange_form.do?m_idx=${m_idx }">${ m_name }님 환영 합니다.</a></li>
								<c:if test="${ m_inviterflag eq 'true'}">
					<li><a onclick="includepopup();">초대가 왔어요~</a></li>
				</c:if>
			</ul>
		</nav>
	</div>

</body>
</html>