<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/httpRequest.js">
	
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>

<title>Insert title here</title>

<script>
	$(document).ready(function() {
		$("#layerPopup").hide();
		$("#contents > a").click(function() {
			$("#contents > a").blur();
			$("#layerPopup").show();
			$("#layerPopup a").focus();
			return false;
		});
		$("#layerPopup a").keydown(function(e) {
			if (e.shiftKey && e.keyCode == 9) { // Shift + Tab 키를 의미합니다.
				$("#contents > a").focus();
				$("#layerPopup").hide();
				return false;
			}
		});

		$("#layerPopup exit chat_save").click(function() {
			$("#contents > a").focus();
			$("#layerPopup").hide();
		});

		// 			$(".roomlist").click(function(chat_idx) { 
		// 				var chat_idx1 = chat_idx.value;
		// 				alert(chat_idx1);
		// 				location.href="chat_room.do?chat_idx="+chat_idx;
		// 			});

	});

	function chat_save(f) {

		// email유효성 검사 하기.

		f.action = "chat_reg.do";
		f.method = "post";
		f.submit();

	}

	function roomEnter(idx) {
		var chat_idx = idx;
		//alert(chat_idx);
		location.href = "chat_room.do?chat_idx=" + chat_idx;

	}
	
	
	function roomsend(idx) {
		console.log("chat_idx"+idx);
		var chat_idx = document.getElementById("chat_idx"+idx).value;
		console.log("chat_idx : " + chat_idx);

		$.ajax({
		        type : "GET",
		        url : "chat_room.do?chat_idx="+chat_idx,
		        dataType : "text",
		        error : function(){
		            //alert('통신실패!!'); 
		        },
		        success : function(data){
		            $("#contents3").html(data) ;
		        }
		         
		    });
	}
	
	
//     let ws=new SockJS("<c:url value='/echo' />");
//     ws.onopen=function(event){
//         console.log("hello socket");
//         console.log(event.data);
//         var msg={};
//         msg.type="list";
<%-- 		var h = <%=session.getAttribute("m_idx")%>; --%>
//         msg.m_idx=h;
//         console.log(msg);
//         ws.send(JSON.stringify(msg));
//     };
    
//    // 메시지가 도착하면 호출
//    ws.onmessage=function onMessage(event){
//             console.log("22 receive Message from Socket : "+ event.data);
//             writeResponse(event.data);
//    };
   
//    ws.onclose=function onClose(event){
//             console.log("22 Socket Close");
// //             writeResponse("Connection closed");
//             /* 나갈때 어디로 갈지. */
// //             location.href="chat_save.do";
//    };
	
</script>

<style type="text/css">
#layerPopup {
	width: 300px;
	height: 400px;
	border: 4px solid #ddd;
	position: absolute;
	left: 100px;
	top: 100px;
	background: #fff;
}

#layerPopup button {
	cursor: pointer;
}

.roomlist {
	cursor: pointer;
}
</style>

</head>
<body>

        

	<div id="contents">
		<a href="#layerPopup">방생성</a>
		<div id="layerPopup">
			<form>
				<table border="1" align="center" style="border-collapse: collapse; width: 100;">
					<tr>
						<td>간단 제목</td>
						<td>
							<textarea name="chat_name" cols="70" rows="5"></textarea>
						</td>
					</tr>

					<tr>
						<td>색상</td>
						<td>
							<textarea name="color" cols="70" rows="5"></textarea>
						</td>
					</tr>
				</table>

				<input type="hidden" name="m_idx" value="${list[0].m_idx}">

				<button type="chat_save" onclick="chat_save(this.form);">생성</button>
				<button type="exit">닫기</button>

			</form>
		</div>
	</div>

	<div id="contents2"> 
		<!--     <a href="#">레이어 팝업이 제공되었습니다.</a> --> 
		<div id="list_container" style="width: 100%; height: 300px; overflow: auto;">
			<div style="background: yellow; height: 40px;">채팅 인포</div>
<c:choose>
<c:when test="${!empty list}">
			<c:forEach var="vo" items="${list}" varStatus="status">
				<%--    				<a href="#roomPopup" onclick="roomEnter(${vo.chat_idx});"> --%>
				<a href="#roomPopup" id="a" onclick="roomsend(${status.index});">
					<div class="roomlist" style="background: grey; border: dotted; height: 60px;">
						<!-- 컬러 가지고 오면 넣기 -->
						<!-- 몇명인지 넣기 -->
						<div style="background:${vo.color}; height:60px;width:25px; display: inline-block;"></div>
						<input type="hidden" id="chat_idx${status.index}" value="${vo.chat_idx}">
						<%-- 					<input type="hidden" id="m_idx" value="${vo.m_idx}"> --%>
						${vo.chat_name}
					</div>
				</a>
			</c:forEach>
			
	</c:when>	
	 <c:otherwise>
	 채팅방을 생성하세요.
    </c:otherwise>


	</c:choose>	
			</div>
	</div>
	
	<div id="contents3"></div>




	<hr>


</body>
</html>
