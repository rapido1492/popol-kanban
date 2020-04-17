<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="bootstrap.jsp" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
		<script src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>
<!-- 		    <script>
		    window.onload = function(){
		       ck = CKEDITOR.replace("editor");
		    };
		</script> -->
		
		<script>
			function send_check() {
				var form = document.form;
				
				if(form.subject.value.trim() == '') {
					alert("제목을 입력해야 합니다.");
					form.subject.focus();
					return;
				}
				
				if(form.name.value.trim() == '') {
					alert("작성자를 입력해야 합니다.");
					form.name.focus();
					return;
				}
				
				if(form.content.value.trim() == '') {
					alert("내용을 입력해야 합니다.");
					form.content.focus();
					return;
				}
				
				if(form.pwd.value.trim() == '') {
					alert("비밀번호를 입력해야 합니다.");
					form.pwd.focus();
					return;
				}
				
				form.submit();
			}
		</script>
	</head>
	<body>
		<form name="form" method="post" action="bbsboard_reply.do" enctype="multipart/form-data">
		<input type="hidden" name="idx" value="${param.idx}" />
		<input type="hidden" name="page" value="${param.page}" />
		
		<div class="container">
	      <div class="form-group">
	        <label for="subject">제목</label>
	        <input type="text" class="form-control" name="subject" placeholder="제목을 입력하세요.">
	      </div>
	      <div class="form-group">
	        <label for="writer">작성자</label>
	        <input type="text" class="form-control" name="name" placeholder="내용을 입력하세요.">
	      </div>
	      <div class="form-group">
	        <label for="content">내용</label>
	        <textarea class="form-control" name="content" rows="3"></textarea>
	      </div>
	      <div class="form-group">
	        <label for="pwd">비밀번호</label>
	        <input type="password" class= "form-control" name="pwd">
	      </div>
	      <div>
			<input type="file" name="photo">
		  </div>
		<button type="button" class="btn btn-primary" onclick="send_check();">등록</button>
		<button type="button" class="btn btn-danger" onclick="location.href='bbsboard_list.do'">취소</button>
		  </div>
		</form>
	</body>
</html>