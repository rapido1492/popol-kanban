<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DIRECTORY</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/httpRequest.js">
	</script>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>

 
<script>

	function del() {
		// 비번이 맞는지, 팀장인지 유효성 검사하기.
		// 			var pwd = f.pwd.value;//원본 비번
		// 			var c_pwd = f.c_pwd.value;//사용자가 입력한 비번
		// 			if( pwd != c_pwd ){
		// 				alert("비밀번호가 일치하지 않습니다");
		// 				return;
		// 			}
		var file_check = [];
		file_check = $(".file_check:checked");

		if (!confirm("정말 삭제하시겠습니까?")) {
			return;
		}

		var file_idx = "";
		for (var i = 0; i < file_check.length; i++) {
			if (i == 0) {
				file_idx += file_check[i].value;
			} else {
				file_idx += "," + file_check[i].value;
			}
		}

		var url = "directory_del.do";
		var param = "file_idx=" + encodeURI(file_idx);

		sendRequest(url, param, resultFn, "get");

	}//del()

	function resultFn() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			var data = xhr.responseText;

			if (data == 'no') {
				alert("삭제실패");
				return;
			}

			alert("삭제 성공");
// 			$("#file_container").load("directory_list.do");
			
			//$("#file_container").load(window.location.href + "#file_container");
			location.href = "directory_list.do";
		}
	}
	
	/* 이유는 모르겠지만 function의 이름이 search는 안된다... 실시간 검색에도 사용할 수 있겠다잉. */
	// 검색 한번하면 페이지가 달라지는(?) 주소 보면서 하기.
	function searching(f) {
		// 숫자로 들어올 수 있으니까 미리 var를 스트링으로 해놓고 시작
		var search = ""+f.search.value;
		 
		if(event.keyCode == 13){ 
			f.action = "dir_searching.do?search=" + search;
			f.method = "get";
			f.submit();
			return;
		}else{ 
			
			f.action = "dir_searching.do?search=" + search;
			f.method = "get";
			f.submit();
			
// 			var url = "dir_searching.do";
// 			var param = "search=" + search; 
	 
// 			sendRequest(url, param, search_resultFn, "get");
		}
		
	
	}
	function search_resultFn() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			var data = xhr.responseText;
// 			$("#file_container").reload();
			console.log("ㄷ로아옴");
		}
	}
	
	
	function download(f) {
		var file_name = [];
		file_name = $(".file_name:checked");
		alert(file_name.length); 
		 
		for (var i = 0; i < file_name.length; i++) {
			
			f.method = "post";
			f.action = "dir_download.do?file_name=" + encodeURI(file_name[i].value);
			f.submit();
			
			// 너무 빨리 for문이 돌기때문에 다중 다운로드가 안되는 것 같다.
			// work()를 통해 1초간 시간을 지연해준다.
			work();
			
		}
		location.href="directory_list.do";
		
		
 	}
	 
	function work(){
		// 1초 이상 걸리는 작업 
		for(var i=0; i < 1000000000; i++);
		
			console.log("work완료");
	}

	
</script>



</head>
<body>
	<form id="form">
		<div id="container">

			<h1>보관함</h1>

			<div>
				<input type="button" value="+" onclick="location.href='directory_reg.do'"> 
				비밀번호 : <input type="password" name="pwd"><br> 
				<input type="button" value="삭제" onclick="del();">  
				<input type="button" value="내려받기" onclick="download(this.form);">  
				검색어 : <input type="text" id="search" name="search" onkeypress="if(event.keyCode == 13){ searching(this.form); }"> <!--  onKeyDown="searching(this.form);"  -->
				<input type="button" value="검색" onclick="searching(this.form);">
<!-- 				<input type="hidden" value="1576522324116_acid2Test.jpg" name="file_name"> -->
			</div>

			<div id="file_container" class="file_container" style="width: 300px; height: 500px;">
				<c:forEach var="vo" items="${list}">

					<div class="visit_box" style="background: grey; width: 90px; height: 90px; display: inline-block;">
						<input type="checkbox" class="file_check" value="${vo.file_idx}"> ${vo.file_idx}<br>
						
						<!-- 첨부된 이미지가 있을때만 img태그를 사용 -->
						<!--<img alt="${vo.m_idx}의 파일" src="${pageContext.request.contextPath}/resources/upload/${vo.file_name}" width="50"/> -->
						작성자 : ${vo.m_idx}<br> <!-- 작성자 이름으로 -->
						용량 : ${vo.file_memory/1000}KB<br>
						<!-- 소수점 두번째자리수까지만. -->
						<input type="hidden" name="pwd" value="${vo.pwd}">
						<input type="checkbox" class="file_name" value="${vo.file_name}"><br>
						

					</div>
				</c:forEach>
			</div>
		</div>
	</form>
	
</body>
</html>