<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="bootstrap.jsp" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
		<style type="text/css">
			table{margin:0 auto;}
		</style>
		<script src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>
		<!-- jQeury문 최신본 -->
		<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>	
		<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
		<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
		 <script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- 		    <script>
		    window.onload = function(){
		       ck = CKEDITOR.replace("editor");
		    };
		    </script> -->
		    
		<script type="text/javascript">
		function send_check() {
			var form = document.form;
			if(form.subject.value.trim() == '') {
				alert("제목을 입력해야 합니다.");
				form.subject.focus();
				return;
			}
			
			if(form.b_content.value.trim() == '') {
				alert("내용을 입력해야 합니다.");
				form.name.focus();
				return;
			}
				
			if(form.priority.value.trim() == 0) {
				alert("우선순위를 선택해주세요");
				return;
			}
				
			if(form.password.value == 0) {
				form.password.value="0000";
			}
			form.submit();
		}
	</script>
	</head>
	<body>
		<form name="form" method="post" action="bbsboard_insert.do" enctype="multipart/form-data">
			<div class="container">
			      <div class="form-group">
				        <label for="subject">제목</label>
				        <input type="text" class="form-control" name="subject" placeholder="제목을 입력하세요.">
			      </div>
			      <div class="form-group">
				      <label for="priority">우선순위</label>
				      <select name="priority" id="priority">
				            <option value="1">낮음</option>
				            <option value="2">중간</option>
				            <option value="3">높음</option>
					  </select>
					  <hr />
					   <label for="division">분류</label>
				      <select name="division" id="division">
				            <option value="todo">todo</option>
				            <option value="doing">doing</option>
				            <option value="done">done</option>
					  </select>
				  <hr />
				  </div>
			      <div class="form-group">
				        <label for="content">내용</label>
				        <textarea class="form-control" name="b_content" rows="3"></textarea>
			      </div>
			      <div class="form-group">
			      	<input id="photo" type="file" name="photo"/> 
			      	<input type="password" name="password" placeholder="파일 패스워드를 입력해주세요"/>
			      </div>
	      		<div>
			      </div>	 
				    <button type="button" class="btn btn-primary" onclick="send_check(this.form);">작성</button>
					<button type="button" class="btn btn-danger" onclick="location.href='bbsboard_list.do'">취소</button>					 
			  </div>
		</form>
	</body>
</html>