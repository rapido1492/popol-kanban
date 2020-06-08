<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
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

		
		<script>	
			function comment_save(form) {	
				var content= form.content.value;
				var rewriter = form.rewriter.value;
				var b_idx = form.b_idx.value;
				var m_idx = form.m_idx.value;
				var filename = form.filename.value;
				
				if(form.content.value.trim() == '') {
					alert("내용을 입력해야 합니다."); 
					form.content.focus();
					return;
				}
				
				if(form.rewriter.value.trim() == '') {
					alert("작성자를 입력해야 합니다.");
					form.pwd.focus();
					return;
				} 
				var url = "bbsboard_comment.do?content="+content +"&b_idx="+ b_idx +"&rewriter="+rewriter +"&m_idx="+${m_idx}
				+ "&filename"+ filename
				sendRequest(url, null, commentresultFn,"post");
			} 
			
			//콜백메서드
			function commentresultFn() {
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
			
			function del() {
				if(confirm("삭제하시겠습니까?")) {
					var url ="bbsboard_del.do?b_idx=${bvo.b_idx}" + "&m_idx=" + ${m_idx};
					sendRequest(url, null, delresultFn,"post");
				}
			}
			
			//콜백메서드
			function delresultFn() {
				if( xhr.readyState==4 && xhr.status==200 ) {
					var data = xhr.responseText;
					//[{'result':'yes'}]
					//var json = eval(data);
					
					if( data=='yes' ) {
						alert("글을 삭제했습니다.");
						location.href="bbsboard_list.do?page=${param.page}"+ "&m_idx=" + ${m_idx};
					}
					else{
						alert("삭제는 leader만 가능합니다.");
						return;
					}
				}
			}
			function download(){

				var filename = $("#filename").text();

				var url = "download.do?file_name="+encodeURIComponent(filename);

				 location.href=url;

				}
		</script>
</head>

<body>
	<!-- Page Content -->
	<div class="container">
		<div class="row">
			<!-- Post Content Column -->
			<div class=".col">
				<!-- Title -->
					<h1 class="mt-4">Title: ${bvo.subject }</h1>
					<!-- Author -->
					<c:if test="${bvo.file_name ne 'no_file'}">
						<img class="img-circle" src="resources/upload/${bvo.file_name }" width="64" height="64"/>
					</c:if>
					Writed by ${bvo.m_nick} 

					<hr style="border: solid 0.5px gray;">
					
					<!-- Date/Time -->
					<p>Posted on ${bvo.b_date }</p>
					
					<hr style="border: solid 0.5px gray;">
	
					<!-- Post Content -->
					<p class="lead">${bvo.b_content }
					<br />
					<!-- 첨부된 이미지가 있을때만 img태그를 사용 -->
						<c:if test="${bvo.file_name ne 'no_file'}">
							<img alt="${bvo.m_nick}  의 사진" src="resources/upload/${bvo.filename}" width="200"/>
						</c:if>
					</p>
					<hr style="border: solid 0.5px gray;">
					
					<button type="button" class="btn btn-primary" onclick="location.href='bbsboard_list.do?page=${param.page}'">목록</button>
 					<!-- <button type="button" class="btn btn-info" onclick="reply();">답글달기</button> -->
 					<button type="button" class="btn btn-warning" onclick="location.href='modify_form.do?b_idx=${bvo.b_idx}'">수정</button>
					<button type="submit" class="btn btn-danger" onclick="del();">삭제</button>
					<div>
						<a href="download.do?file_name=${bvo.file_name}">${bvo.file_name}</a>
					</div>
					<div class="media mb-4">
						<c:forEach var="re" items="${revo}">
						<div class="media-body">
						<c:if test="${re.filename ne 'no_file'}">
							<img class="img-circle" alt="${re.rewriter} 의 사진" src="resources/upload/${re.filename}"  width="64" height="64"/>
							<h5 class="mt-0">작성자: ${re.rewriter }</h5>
						</c:if>
							${re.content }
						</div>
						<br />
						<hr style="border: solid 0.5px gray;">
						</c:forEach>
					</div>
					<div style="border: 1px solid; width: 600px; padding: 5px">
			    		<form name="form1" action="form" method="post">
				        	<input type="hidden" name="b_idx" value="${bvo.b_idx}"/>
				        	<input type="hidden" name="m_idx" value="${m_idx}"/>
				       	 	<input type="hidden" name="rewriter" value="${userNick}">
				       	 	<input type="hidden" name="filename" value="${bvo.m_photo }" />
				       	 	작성자: ${userNick} 
				       	 	<br/>
				        	<textarea name="content" rows="3" cols="60" maxlength="500" placeholder="댓글을 달아주세요."></textarea>
				        	<input type="button" value="저장" onclick="comment_save(this.form)">
						</form>
					</div>
				</div>
			</div>
		</div>
		<!-- /.row -->
	<!-- /.container -->

	<!-- Footer -->
	<footer class="py-5 bg-dark">
		<div class="container">
			<div class=".col">
				<p class="m-0 text-center text-white">Copyright &copy; LJLR
					Website 2019</p>
			</div>
		</div>
		<!-- /.container -->
	</footer>
</body>
</html>
