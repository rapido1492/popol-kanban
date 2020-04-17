<!-- 신이룸 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<!-- 부트스트랩 3.x를 사용한다. -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<script type="text/javascript">
		function modify( f ) {
			
			f.action="modify_update.do";
			f.submit();
		}
		
		
	</script>
</head>
<body>
	<form name="f" method="post" enctype="multipart/form-data">
		<!-- 모달창이 열리면 뒷배경이 깨짐 -->
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close" aria-hidden="true" onclick="location.href='board.do'">×</button>
			<h3 class="smaller lighter blue no-margin modal-title">메모 등록</h3>
		</div>

		<div class="modal-body">
			테스트입니다.<br>

			<table border="1" align="center" width="600" style="border-collapse: collapse;">

<!-- 				<tr> -->

				<tr>
					<td>메모 변경 내용</td>
					<td>
						<textarea name="b_content" cols="70" rows="5"></textarea>
<!-- 						<input type="text" class="b_content" width="70" height="70"> -->
					</td>
				</tr>
				
				<tr>
					<td>비밀번호</td>
					<td>
						<input name="p_saleprice" size="70">
					</td>
				</tr>

			</table>


		</div>
		<div class="modal-footer">
			<span class="btn btn-sm btn-success" id="testSave" > 
			<input type="button" onclick="modify(this.form);">
			<input type="hidden" name="b_idx" value="${b_idx}">
			<input type="hidden" name="page" value="${page}">
			수정<i class="ace-icon fa fa-arrow-right icon-on-right bigger-110" ></i>
			</span>
			<button class="btn btn-sm btn-danger pull-right" data-dismiss="modal" id="btnClose" onclick="location.href='pagecheck.do?page=${page}'">
				<i class="ace-icon fa fa-times"></i>닫기
			</button>
		</div>
	</form>
</body>
</html>