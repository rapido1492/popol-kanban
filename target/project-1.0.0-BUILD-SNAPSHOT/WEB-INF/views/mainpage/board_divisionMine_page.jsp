<!-- 신이룸 -->


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Main Page</title>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- 부트스트랩 3.x를 사용한다. -->
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>

<!-- css 가져오는 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mainpage/boardpage.css">

	<!-- 드래그 -->
	<script>
	

	 
	$(function() {
		$(".column").sortable({
		// 드래그 앤 드롭 단위 css 선택자
		connectWith: ".column",
		// 움직이는 css 선택자
		handle: ".card-body",
		// 움직이지 못하는 css 선택자
		cancel: ".no-move"
		// 이동하려는 location에 추가 되는 클래스
		/* placeholder: "card-placeholder" */
		});


			
			// 이동카드, 보드의 값을 구해서 db 연동			
			$(".column").sortable({ 
				item: $('.card'),
				start: function(event, ui) {
					$(this).attr('move_index', ui.item.index());
					$(this).attr('parent_before', ui.item.parent().attr("id"));
			    }, 
			    stop: function(event, ui) { 
					var card_after_index = ui.item.index();
					// 부모 idx
					var division_after_id = ui.item.parent().attr("id");
					// 이동카드 index
					var card_before_index = $(this).attr('move_index');
					// 부모의 전 idx
					var division_before_id = $(this).attr('parent_before');
					// 보드의 고유 idx
					var b_idx = $(':hidden#b_idx'+card_before_index).val();
					
					
					var url = "Mine_memoSeq_modify.do";
					var param = "division_after_id=" + division_after_id + "&card_before_index=" + card_before_index + 
								"&card_after_index=" + card_after_index + "&division_before_id=" + division_before_id + "&b_idx=" + b_idx;
 
					sendRequest(url, param, resultFn, "get");

			    }
			});
			
			// 해당 클래스 하위의 텍스트 드래그를 막는다.
			/* 드래그 못하게 제대로 하기. 안먹힘*/
			$( ".column").disableSelection();

			});
			
			// 카드이동 콜백
			function resultFn() {
				console.log("이동 콜백");
			}
			
			
			</script>
			
<!-- 클릭했을때 상세보기 -->
	<script>
		function view() {
			/* 나중에 모달로 내용 상세보기 넣기. */
			
			alert("상세보기");
		}
		
		function del(b_idx) {
			
// 			f.action="memo_del.do";
// 			f.submit();
			
			
			var url= "memo_del.do";
			var param= "b_idx="+b_idx + "&page=mine";
			
			sendRequest(url, param, resultDel, "post");
			
		}
 
		function resultDel() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var data = xhr.responseText;

				alert("삭제 성공");
//	 			$("#file_container").load("directory_list.do");
				
				//$("#file_container").load(window.location.href + "#file_container");
				// 이렇게 하면 어떤 행동을 해도 All 리스트로 가게 된다.
// 				location.href = "board.do";
				alert("asdf");
				 location.reload();
			}
		}
		
	</script>

</head>
<body>

<% 

String[] division_str = {"todo", "doing","done"}; 
pageContext.setAttribute("division_str", division_str);

%>

<!-- 모달 팝업창 -->
	<div id="modal-testNew" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="테스트정보 등록" aria-describedby="테스트 모달">
		<div class="modal-dialog" style="min-width: 700px; min-height: 300px; background: grey;">
			<div class="modal-content"></div>
		</div>
	</div>
	
	
	

	<!-- 보드판 -->
	<div class="container-fluid" id="container-fluid" style="background:grey;">
		<div class="row">
			
			<!-- 세로 리스트 박스 이름이 각 회원이름이 추가되겠지. 그룹테이블에서 특정 idx인 -->
			<c:forEach begin="0" end="2" varStatus="status1">
				<div class="col-sm-4 column" id="${division_str[status1.index]}">
 
					<form>
						<!-- 여기 임시 값도 수정해야 한다. -->
						<!-- pj_idx는 임시  --> 
						<a data-toggle="modal" href="reg_form.do?m_idx=${my_list[status1.index].m_idx}&division=${division_str[status1.index]}&pj_idx=1&page=mine"
							data-target="#modal-testNew" role="button" data-backdrop="static"> 
						<span class="btn btn-xs btn-success" style="float: right; margin: 5px">+</span> 
						<input type="hidden" name="m_idx" value="${my_list[0].m_idx}">
						</a>
					</form>

				<div class="info no-move">
					${division_str[status1.index]}
					<!-- 모달버튼. 모달창이 열리면 뒷배경이 깨짐. 해결 해야함 --> 
				</div>

				<c:forEach var="my_list" items="${my_list}" varStatus="status">
					<c:if test="${my_list.division eq division_str[status1.index]}">
						<div class="card text-white bg-info mb-3">
							<div class="card-header">${my_list.subject}</div>
							<div class="card-body">
								<input class="btn_del" type="button" value="삭제" onclick="del(${my_list.b_idx});">
								<a data-toggle="modal" href="memo_modify_form.do?b_idx=${my_list.b_idx}&page=mine" data-target="#modal-testNew" role="button" data-backdrop="static">
									<span class="btn btn-xs btn_del" style="float: right; margin: 5px">수정</span>
<%-- 									</a> <input type="hidden" id="b_idx" value="${my_list.b_idx}">  --%>
								</a> <input type="hidden" id="b_idx${status.index}" value="${my_list.b_idx}"> 
								
								${my_list.b_idx}<br>
								${my_list.b_date}<br> 
								${my_list.b_content}<br> 
								${my_list.b_content}<br> 
<!-- 							<h5 class="card-title">card 2</h5> -->
<!-- 							<p class="card-text">card 2</p> -->
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</c:forEach>
		</div>
	</div>
	
	
</body>
</html>