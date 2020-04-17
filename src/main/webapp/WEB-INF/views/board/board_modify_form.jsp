<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ include file="bootstrap.jsp" %>   
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
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
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
		
		<script>
		function send_check(form) {
			var form = document.form;
			
			alert(form.existing_file.value);
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
				
			if(form.division.value.trim() == 0) {
				alert("분류를 선택해주세요");
				return;
			}
/* 			
			if(form.password.value == 0) {
				form.password.value="0000";
			} */
			var url="modify.do?b_idx=" + form.b_idx.value +"&subject="+ form.subject.value +"&priority="+ form.priority.value +
			"&division="+ form.division.value  + "&b_content=" + encodeURIComponent(form.b_content.value);
			/* + "&file_name=" + form.photo.value; */
			sendRequest( url, null, resultFn, "POST");
		}
		
		function resultFn() {
			if( xhr.readyState==4 && xhr.status==200 ) {
				var data = xhr.responseText;
				//[{'result':'yes'}]
				//var json = eval(data);
				if( data=='yes' ) {
					location.href="bbsboard_view.do?b_idx=${param.b_idx}"+"&m_idx=" + ${m_idx};
				}
				else{
					alert("댓글등록 실패");
					return;
				}
			}
		}
		</script>
	</head>
	<body>
		 <form method="post" action="modify.do" name="form" 
            enctype="multipart/form-data">
                <input type="hidden" name="b_idx" value="${vo.b_idx}"/>
   				<input type="hidden" name="existing_file" value="${vo.filename}"/>
			<div class="container">
			      <div class="form-group">
				       <label for="subject">제목</label>
				       <input type="text" class="form-control" name="subject" value="${vo.subject }">
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
				        <textarea class="form-control" name="b_content" rows="3">${vo.b_content }</textarea>
			      </div>
			      <!-- 추후 추가 예정 -->
<%-- 			      <div>
			      	<c:if test="${vo.file_name} != null">
			      		<input type="file" value="${vo.file_name }" name="photo">
			      	</c:if>	
				      <div class="form-group">
				      	<input id="photo" type="file" value="${vo.filename}" name="photo"/> 
				      	<input type="password" name="password" placeholder="파일 패스워드를 입력해주세요"/>
				      </div>
			      </div> --%>
				    <button type="button" class="btn btn-primary" onclick="send_check(this.form);">작성</button>
					<button type="button" class="btn btn-danger" onclick="location.href='bbsboard_list.do?page=${param.page}'">취소</button>
			  </div>
		</form>
	</body>
</html>