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
			cancel: ".no-move",
			// 이동하려는 location에 추가 되는 클래스
			placeholder: "card-placeholder"
			});
			
			// 이동카드, 보드의 값을 구해서 db 연동			
			$(".column").sortable({ 
				item: $('.card'),
				start: function(event, ui) {
					$(this).attr('move_index', ui.item.index());
					$(this).attr('parent_before', ui.item.parent().attr("id"));
					
			    }, 
			    stop: function(event, ui) {   
// 			        console.log('부모 인덱스 : ' + ui.item.parent().index()); // 부모의 인덱스
// 			        console.log('부모의 아이디 : ' + ui.item.parent().attr("id")); // 부모의 아이디
					var card_after_index = ui.item.index();
					// 부모 idx
					var board_after_id = ui.item.parent().attr("id");
					// 이동카드 index
					var card_before_index = $(this).attr('move_index');
					// 부모의 전 idx
					var board_before_id = $(this).attr('parent_before');
					// parent_idx 는 ${g_vo.m_idx} 이거고, move_card는 memo_seq
// 					alert("board_after_id=" + board_after_id + "&card_before_index=" + card_before_index + 
// 							"&card_after_index=" + card_after_index + "&board_before_id=" + board_before_id);  
					
					var url = "memoSeq_modify.do";
					var param = "board_after_id=" + board_after_id + "&card_before_index=" + card_before_index + 
								"&card_after_index=" + card_after_index + "&board_before_id=" + board_before_id;
 
					sendRequest(url, param, resultFn, "get");

			    }
			});
			
			// 해당 클래스 하위의 텍스트 드래그를 막는다.
			/* 드래그 못하게 제대로 하기. 안먹힘*/
			$( ".column").disableSelection();
			}); 
			
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
			var param= "b_idx="+b_idx+ "&page=all";
			
			sendRequest(url, param, resultDel, "post");
			
		}
 
		function resultDel() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var data = xhr.responseText;

				alert("삭제 성공");
//	 			$("#file_container").load("directory_list.do");
				
				//$("#file_container").load(window.location.href + "#file_container");
				location.reload();
			}
		}
		
		</script>
	
	
	
</head>

<body>
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
			<c:forEach var="g_vo" items="${g_list}" >
				<div class="col-sm-4 column" id="${g_vo.m_idx}" style="overflow: auto;">

					<div class="info no-move">
						${g_vo.m_name}
						<!-- 모달버튼. 모달창이 열리면 뒷배경이 깨짐. 해결 해야함 -->
						<form>
							<a data-toggle="modal" href="reg_form.do?m_idx=${g_vo.m_idx}&pj_idx=1&page=all" data-target="#modal-testNew" role="button" data-backdrop="static"> 
							<span class="btn btn-xs btn-success" style="float: right; margin: 5px">+
							</span> <input type="hidden" name="m_idx" value="${g_vo.m_idx}">
							</a>
						</form>

					</div>

					<!-- 이미 쿼리문을 통해 현재 pj_idx만 걸러 왔으니까. group의 m_idx랑 board의 m_idx가 같으면 메모 출력-->
					<!-- 순서를 db에 저장하게 되면 이제 쿼리문 가져올떄 그 순서로 가져와야한다. -->
					<c:forEach var="b_vo" items="${b_list}">
						<c:if test="${b_vo.m_idx eq g_vo.m_idx }">
							<div class="card text-white bg-info mb-3">
								<div class="card-header">${b_vo.subject}</div>
								<div class="card-body">
									<input class="btn_del" type="button" value="삭제" onclick="del(${b_vo.b_idx});"> 
									<a data-toggle="modal" href="memo_modify_form.do?b_idx=${b_vo.b_idx}&page=all" data-target="#modal-testNew" role="button" data-backdrop="static"> 
										<span class="btn btn-xs btn_del" style="float: right; margin: 5px">수정</span>
									</a> <input type="hidden" id="b_idx" value="${b_vo.b_idx}"> 
									${b_vo.b_idx}<br>
									${b_vo.b_date}<br> 
									${b_vo.b_content}<br> 
									${b_vo.b_content}<br>
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

















