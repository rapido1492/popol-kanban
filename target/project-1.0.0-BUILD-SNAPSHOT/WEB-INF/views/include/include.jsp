<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

function ok(f) {
	
	var m_idx = f.m_idx.value;
	var invite_sender = f.m_idx.value;
	var project = f.project.value;
	var in_idx = f.in_idx.value;
	
	f.action = "invite_accept.do";
	f.method = "post";
	f.submit();
 	opener.parent.location='mypage.do'; 
}

</script>

</head>
<body>
<form>
	<a> ${ avo.invite_sender } 님이
	<br> ${avo.project } 프로젝트에 초대 하였습니다. <br>
	           해당 초대에 수락 하겠습니까?
	     <input type="hidden" name="m_idx" value="${m_idx }">
	     <input type="hidden" name="invite_sender" value="${ avo.invite_sender }">
	     <input type="hidden" name="project" value="${avo.project }">
	     <input type="hidden" name="in_idx" value="${vo.in_idx }">
	</a>
	<br>
<input type="button" value="수락" onclick="ok(this.form);">
<input type="button" value="거절" onclick="window.close();">
</form>



</body>
</html>