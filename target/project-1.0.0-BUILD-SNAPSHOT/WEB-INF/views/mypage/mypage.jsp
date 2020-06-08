<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  	
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LSJR-MyPage</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css">

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/index.js"></script>

<script src='https://npmcdn.com/react@15.3.0/dist/react.min.js'></script>
<script src='https://npmcdn.com/react-dom@15.3.0/dist/react-dom.min.js'></script>
<script
	src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.14.1/moment-with-locales.min.js'></script>


<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<script defer
	src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>
<link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400"
	rel="stylesheet">

<script
	src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.js'></script>
<script
	src='http://cdnjs.cloudflare.com/ajax/libs/lettering.js/0.6.1/jquery.lettering.min.js'></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">

<link rel='stylesheet prefetch'
	href='https://fonts.googleapis.com/css?family=Roboto:300,400,700'>

<!-- jQeury문 최신본 -->

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>




<!-- 부트스트랩  -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage/bootstrap.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage/bootstrap-theme.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<!-- 부트스트랩 드롭앤솔트 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>



<script>
$(function() {
$(".column").sortable({
// 드래그 앤 드롭 단위 css 선택자
connectWith: ".column",
// 움직이는 css 선택자
handle: ".card-header",
// 움직이지 못하는 css 선택자
cancel: ".no-move",
// 이동하려는 location에 추가 되는 클래스
placeholder: "card-placeholder"
});
// 해당 클래스 하위의 텍스트 드래그를 막는다.
$( ".column .card" ).disableSelection();
});
</script>

	<script>
	/* 프로젝트 삭제 */
		function pj_delete(pj_idx, pj_leader){
			if( pj_leader!='${m_inf.m_nick}'){
				alert("리더권한이 없습니다.");
				return;
			}
			
			if( !confirm("해당 프로젝트를 삭제하시겠습니까?") ){
				return;
			}
			
			var url = "pj_delete.do";
			var param = "pj_idx=" + pj_idx;
			sendRequest( url, param, resultFn_del, "POST" );
	}
	
		function resultFn_del(){

			if( xhr.readyState == 4 && xhr.status == 200 ){
				
				var data = xhr.responseText;
				
				if( data == 'no' ){
					alert("프로젝트 삭제 실패!!");
					return;
				}
				
				alert("프로젝트를 삭제하였습니다.");
				
				location.href="mypage.do";
				
			}
	}
	</script>

	<script>
	/* 프로젝트 탈퇴 */
		function pj_out(pj_idx, pj_leader, m_idx){
			if( pj_leader =='${m_inf.m_nick}'){
				alert("해당 프로젝트를 탈퇴하려면 리더 권한을 다른 팀원에게 위임하셔야 합니다.");		
				return;
			} 
			if( !confirm("해당 프로젝트를 탈퇴하시겠습니까?") ){
				return;
			}
			
			var url = "pj_out.do";
			var param = "pj_idx=" + pj_idx+"&m_idx="+m_idx;
			sendRequest( url, param, resultFn_out, "POST" );
	}
	
		function resultFn_out(){

			if( xhr.readyState == 4 && xhr.status == 200 ){
				
				var data = xhr.responseText;
				
				if( data == 'no' ){
					alert("프로젝트 탈퇴 실패!!");
					return;
				}
				
				alert("해당 프로젝트에서 탈퇴하였습니다.");
				
				location.href="mypage.do";
				
			}
	}
	</script>

	<script>
	/* 프로젝트 수정 */
		function pj_update_form(pj_leader, pj_idx, pj_name, pj_sdate, pj_ddate, pj_contents){
			if( pj_leader!='${m_inf.m_nick}'){
				alert("리더권한이 없습니다.");
				location.reload();
				return;
			}
			${pj_vo.pj_idx}
			$("#pj_idx2").val(pj_idx);
			$("#pj_name2").val(pj_name) ;
			$("#pj_sdate2").val(pj_sdate) ;
			$("#pj_ddate2").val(pj_ddate) ;
			$("#pj_contents2").val(pj_contents) ;			
	}
	
		$(document).ready(function(){
			$('#update').click(function(){

						
				if($("#pj_name2").val() == ""){ 
					alert("프로젝트 제목을 입력해주세요."); 
					$("#pj_name2").focus();
					return false; }
				
				if($("#pj_name2").val().length>20){ 
					alert("프로젝트 제목은 20자 이내로 입력해주세요."); 
					$("#pj_name2").focus();
					return false; }
				
				if($("#pj_ddate2").val() == ""){ 
					alert("프로젝트 마감날짜를 선택해주세요."); 
					$("#pj_ddate2").focus();
					return false; }
						
				if($("#pj_contents2").val() == ""){ 
					alert("프로젝트 내용을 입력해주세요."); 
					$("#pj_contents2").focus();
					return false; }
				
				if($("#pj_contents2").val()>200){ 
					alert("프로젝트 내용은 200자 이내로 입력해주세요"); 
					$("#pj_contents2").focus();
					return false; }
				
				$.ajax({
					type:"POST",
					url:"pj_update.do",
					data:{"pj_idx" : $('#pj_idx2').val(),
						"pj_name" : $('#pj_name2').val(),
						  "pj_open" : $('#pj_open2').val(),
						  "pj_sdate" : $('#pj_sdate2').val(),
						  "pj_ddate" : $('#pj_ddate2').val(),
						  "pj_contents" : $('#pj_contents2').val()
					},			
					success: function(){
						$('#myModal2').modal("hide");
						alert("프로젝트가 수정되었습니다.");
						location.reload();
					}, error: function(){
						alert("프로젝트 수정 실패!!");}		
				});
			
		    });
		});	
		       
		</script>




<script>
    	<!-- 프로젝트 필터링  -->
	var selected_project = "All Projects";
 	   jQuery(document).ready(function() {
  	      $("#pj_select").on("click", "li", function() {
  	    	selected_project=$(this).text(); 
  	    	document.getElementById("selected_project").innerHTML=selected_project;
  	    	
  			$.ajax({
  				type:"POST",
  				url:"pj_filter.do",
  				data : {"select" : selected_project},	
  				success: function(data){
  				    $("#pj_list_container").html(data) ;
  				}, 
  				error: function(){
  				alert("불러올 프로젝트가 존재하지 않습니다.");}		
  			});		
  				 	    	
   	     });
  	  });
 	   
      <!-- Doing필터링  -->
 	var selected_do = "To Do";   
	   jQuery(document).ready(function() {
	      $("#do_select").on("click", "li", function() {
	    	selected_do=$(this).text();
	    	document.getElementById("selected_do").innerHTML=selected_do;
  			$.ajax({
  				type:"POST",
  				url:"do_filter.do",
  				data : {"select" : selected_do},	
  				success: function(data){
  				    $("#todocontainer").html(data) ;
  				}, 
  				error: function(){
  				alert("불러오기 실패");}		
  			});		
	    	
	    	
	     });
	  });
	
	  
	</script>


<!-- 모달에서 데이터 넘기기 -->
<script>
$(document).ready(function(){
	$('#create').click(function(){

				
		if($("#pj_name").val() == ""){ 
			alert("프로젝트 제목을 입력해주세요."); 
			$("#pj_name").focus();
			return false; }
		
		if($("#pj_name").val().length>20){ 
			alert("프로젝트 제목은 20자 이내로 입력해주세요."); 
			$("#pj_name").focus();
			return false; }
		
		if($("#pj_ddate").val() == ""){ 
			alert("프로젝트 마감날짜를 선택해주세요."); 
			$("#pj_ddate").focus();
			return false; }
				
		if($("#pj_contents").val() == ""){ 
			alert("프로젝트 내용을 입력해주세요."); 
			$("#pj_contents").focus();
			return false; }
		
		if($("#pj_contents").val()>200){ 
			alert("프로젝트 내용은 200자 이내로 입력해주세요"); 
			$("#pj_contents").focus();
			return false; }
		
		$.ajax({
			type:"POST",
			url:"pj_create.do",
			data:{"pj_name" : $('#pj_name').val(),
				  "pj_open" : $('#pj_open').val(),
				  "pj_sdate" : $('#pj_sdate').val(),
				  "pj_ddate" : $('#pj_ddate').val(),
				  "pj_contents" : $('#pj_contents').val()
			},			
			success: function(){
				$('#myModal').modal("hide");
				alert("프로젝트가 생성되었습니다.");
				location.reload();
			}, error: function(){
				alert("프로젝트 등록 실패.");}		
		});
	
    });
});	
       
</script>

<!-- 프로젝트 더보기 기능 -->
<script>
$(document).ready(function(){
	$('#show_pj').click(function(){			
		
		$.ajax({
			type:"POST",
			url:"pj_more.do",
			dataType:"text",	
			success: function(data){
			    $("#pj_list_container").html(data) ;
			}, 
			error: function(){
			alert("불러올 프로젝트가 존재하지 않습니다.");}		
		});		
	
	 });		
});	
       
       
</script>
<!-- todo 더보기 기능 -->
<script>
$(document).ready(function(){
	$('#show_do').click(function(){			
		
		$.ajax({
			type:"POST",
			url:"todo_more.do",
			dataType:"text",	
			success: function(data){
			    $("#todocontainer").html(data) ;
			}, 
			error: function(){
			alert("더보기 실패!");}		
		});		
		
	 });		
});	
       
       
</script>
<!-- 그룹 수정 기능 -->
<script>
function pj_group_update(pj_leader, pj_idx){
	if( pj_leader!='${m_inf.m_nick}'){
		alert("리더권한이 없습니다.");
		location.reload();
		return;
	}
	$("#pj_idx2").val(pj_idx);
	
	$.ajax({
		type:"POST",
		url:"pj_group.do",
		data:{"pj_idx" : pj_idx
		},		
		success: function(data){	
		    $("#g_out3").empty();	
		    $("#g_out3").html(
		    		"<div class='card text-black bg-primary mb-3 no-move' id='g_out5'><div class='card-header'> Nickname (Member-Email)</div></div>"	
		    );
		    $("#g_member3").html(data);
		    
		}, 
		error: function(){
		alert("그룹멤버 불러오기 실패!!");}		
	});		
		
}

$(document).ready( function() {
    
    $("#update2").click(function(){
        var size = $("#form1 input[name='g_update_idx']").length;
        var g_update_arr = new Array();  
        for(i=0;i<size;i++){

            g_update_arr.push($("#form1 input[name='g_update_idx']").eq(i).attr("value"));
        }
        var g_leader_no = $("#form1 input[name='leader']:checked").val();
        if(g_leader_no != null){
        	alert("제외인원에는 리더를 포함할 수 없습니다. ");
        	return;
        }
        var g_leader = $("#form2 input[name='leader']:checked").val();
        var pj_idx = $("#pj_idx2").val();
		$.ajax({
			type:"POST",
			url:"g_update.do",
			data:{"g_update_arr" : g_update_arr,
				 "g_leader" : g_leader,
				 "pj_idx" : pj_idx
			},			
			success: function(data){
				if(data=='success'){
				alert("그룹 수정을 성공하였습니다.");
				location.reload();
				}
				
				$('#myModal3').modal("hide");
			}, error: function(){
				alert("그룹 수정에 실패하였습니다.");}		
		});
        
    });
});

</script>

<!-- 그룹 초대 기능 -->
<script>
function pj_group_invite(pj_leader, pj_idx){
	$("#pj_idx3").val(pj_idx);
	if( pj_leader!='${m_inf.m_nick}'){
		alert("리더권한이 없습니다.");
		location.reload();
		return;
	}
}

$(document).ready(function(){
	$('#g_search4').click(function(){
		$.ajax({
			type:"POST",
			url:"g_search.do",
			data:{"m_email" : $('#g_search3').val()
			},			
			success: function(data){
				alert("초대 인원에 추가하였습니다.");
				$("#g_invite3").append(data);
			}, error: function(){
				alert("사용자가 존재하지 않습니다.");}		
		});

    });
});	

$(document).ready( function() {
    
    $("#invite").click(function(){
        var size = $("input[name='invite_idx']").length;
        var invite_arr = new Array();  
        for(i=0;i<size;i++){
        	for(j=0;j<invite_arr.length;j++){
        		if(invite_arr[j] == $("input[name='invite_idx']").eq(i).attr("value")){
        			alert("중복된 사용자가 존재합니다.");
        			return;
        		}
        	}
        	console.log($("input[name='invite_idx']").eq(i).val());
            invite_arr.push($("input[name='invite_idx']").eq(i).attr("value"));
        }
        
		$.ajax({
			type:"POST",
			url:"g_invite.do",
			data:{"invite_arr" : invite_arr,
				"send_m_idx" : $('#m_idx3').val(),
				"pj_idx" : $('#pj_idx3').val()
				
			},			
			success: function(data){
				if(data=='success'){
				alert("초대 메시지가 발송되었습니다.");
				}else if(data=='overlap'){
				alert("해당 그룹에 이미 존재하는 멤버를 초대하였습니다.");	
				}else if(data=='overlap_invite'){
				alert("이미 초대한 멤버가 포함되어있습니다.");	
				}

				$('#myModal4').modal("hide");
			}, error: function(){
				alert("멤버를 초대할 수 없습니다.");}		
		});
        
    });
});
</script>


</head>
<body>
	<!-- 메뉴바 -->
	<c:import url="/upmenubar.do">
		<c:param name="m_idx" value="${m_idx}"/>
	</c:import>
	<!-- 전체 -->
	<div class="whole_board">
		<!-- 프로필  -->
		<div class="grid-7 element-animation">
			<div class="card color-card-2" id="profile-card">
				<ul>
					<li><i class="fas fa-arrow-left i-l b"></i></li>
					<li><i class="fas fa-ellipsis-v i-r b"></i></li>
					<li><i class="far fa-heart i-r b"></i></li>
				</ul>
				<c:set var="nophoto" value="no_file" />
				<c:if test="${m_inf.m_photo eq nophoto}">
				<div class="profile" >
					<i class="fas fa-user-circle fa-9x" id="no_img"></i>
				</div>
				</c:if>	
				<c:if test="${m_inf.m_photo ne nophoto}">
				<div class="profile" >
				<img class="img-circle"  id="yes_img" alt="${m_inf.m_nick} 의 사진" src="resources/upload/${m_inf.m_photo}"  width="128" height="128"/>
				</div>
				</c:if>		
				<h2 class="title-2">${m_inf.m_nick}<span>(${m_inf.m_name})</span>
				</h2>
				<p class="job-title">${m_inf.m_email}</p>
				<div class="desc top">
					<p>${m_inf.m_phone}</p>
				</div>


				<hr class="hr-2">
				<div class="container">
					<div class="content">
						<div class="grid-2">
							<button class="color-b circule">
								<i class="far fa-calendar-alt fa-2x"></i></i>
							</button>
							<h2 class="title-2">${m_inf.doing_cnt}</h2>
							<p class="followers">Doing</p>
						</div>
						<div class="grid-2">
							<button class="color-c circule">
									<i class="far fa-calendar fa-2x"></i>
							</button>
							<h2 class="title-2">${m_inf.todo_cnt}</h2>
							<p class="followers">ToDo</p>
						</div>
						<div class="grid-2">
							<button class="color-d circule">
								<i class="far fa-calendar-check fa-2x"></i>
							</button>
							<h2 class="title-2">${m_inf.done_cnt}</h2>
							<p class="followers">Done</p>
						</div>
					</div>
				</div>
			</div>
		</div>


		<!-- 달력 -->
		<div id="calendar">
			<script src='https://npmcdn.com/react@15.3.0/dist/react.min.js'></script>
			<script
				src='https://npmcdn.com/react-dom@15.3.0/dist/react-dom.min.js'></script>
			<script
				src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.14.1/moment-with-locales.min.js'></script>
			<script type="text/javascript"
				src="${pageContext.request.contextPath}/resources/js/index.js"></script>
		</div>

		<!-- Project 목록 -->
		<div class='newsfeed' id="project_newsfeed">
			<div class='newsfeed_header' id="project_newsfeed2">
				<div class='newsfeed_header__left1'>
					<h1>My Project</h1>
					<input id='pj_dropdown' type='checkbox'> <label
						for='pj_dropdown'> <img id=pj_arrow
						src='https://s3-us-west-2.amazonaws.com/s.cdpn.io/343086/arrowDown.png'>
						<ul id="pj_select">
							<li>All Projects</li>
							<li>Now Projects</li>
							<li>Past Projects</li>
						</ul>
					</label> </input>
				</div>
				<div class='newsfeed_header__right1'>
					<h1 id="selected_project">All Projects</h1>
				</div>
			</div>

			<div class='newsfeed_articlecontainer' id="pj_list_container">
			 	<!-- 플젝이 없을경우  -->
				<c:if test="${empty p_list}">
					<div class='newsfeed_articlecontainer__article' id="no_pj">
						<div class='article_title' onclick="location.href='board.do?pj_idx=${pj_vo.pj_idx}'">
							<h1> 참여한 프로젝트가 없습니다.</h1>
							<h1> 밑에 버튼을 눌러 프로젝트를 생성해주세요.</h1>
						</div>
					</div>
				</c:if>
				<!-- Project 목록 불러오기(데이터포함)  -->
				<c:forEach var="pj_vo" items="${p_list}" begin="0" end="${max_pj}" step="1" varStatus="status">
					<c:set var="now" value="now"/>
					<c:set var="past" value="past"/>
					<div class='newsfeed_articlecontainer__article' >
					
						<!-- 프로젝트 수정/삭제/탈퇴 -->
						<div class="btn-group" id="pj_option">
							<div id="pj_option" data-toggle="dropdown">
								<i class="fas fa-ellipsis-v i-r b"></i>
							</div>
							<ul class="dropdown-menu" id="pj_option_menu">
								<li onclick="pj_group_invite('${pj_vo.pj_leader }','${pj_vo.pj_idx }');"data-toggle="modal" data-target="#myModal4">그룹초대</li>							
								<li onclick="pj_group_update('${pj_vo.pj_leader }','${pj_vo.pj_idx }');" data-toggle="modal" data-target="#myModal3">그룹수정</li>
								<li onclick="pj_update_form('${pj_vo.pj_leader }','${pj_vo.pj_idx }','${pj_vo.pj_name}','${pj_vo.pj_sdate}','${pj_vo.pj_ddate}','${pj_vo.pj_contents}');" data-toggle="modal" data-target="#myModal2">수정</li>
								<li onclick="pj_delete('${pj_vo.pj_idx}', '${pj_vo.pj_leader}');">삭제</li>
								<li onclick="pj_out('${pj_vo.pj_idx}', '${pj_vo.pj_leader}', '${m_inf.m_idx}');">탈퇴</li>
							</ul>
						</div>
						
						<c:choose>
							<c:when test="${pj_vo.pj_progress eq now}">
								<div class='d_date'>
									<p>D-${pj_vo.pj_dday}</p>
								</div>
							</c:when>
							<c:otherwise>
								<div class='d_date'>
									<p>Past Project</p>
								</div>
							</c:otherwise>
						</c:choose>
						<div class='article_title' onclick="location.href='board.do?pj_idx=${pj_vo.pj_idx}'">
							<h1>${pj_vo.pj_name} / <span>${pj_vo.pj_leader}</span>
							</h1>
						</div>


						<div class='start_date'>
							<p>Start Date : ${pj_vo.pj_sdate}</p>
						</div>
						<div class='due_date'>
							<p>
								Due<span>l</span> Date : ${pj_vo.pj_ddate}
							</p>
						</div>

						<div class='article_content'>
							<p>${pj_vo.pj_contents }</p>
						</div>

					</div>


				</c:forEach>
				
				<c:if test="${fn:length(p_list)-1 gt max_pj && max_pj ge '2'}">
				<div class='newsfeed_articlecontainer__article' id="show_all">
					<button class="color-d circule" id="show_pj">
						<i class="fas fa-angle-down fa-2x"></i>
					</button>
				</div>
				</c:if>
				<div class='newsfeed_articlecontainer__article' id="plus_project">
					<button class="color-d circule" id="plus" data-toggle="modal"
						data-target="#myModal">
						<i class="fas fa-plus "></i>
					</button>
				</div>

			</div>
		</div>

		<!-- Doing/ToDo/Done목록 -->
		<div class='todo_done_doing'>
			<div class='todo_done_doing_header'>
				<div class='todo_done_doing_header__left'>
					<h1>My Do</h1>
					<span id="selected_do">To Do</span> <input id='dropdown2'
						type='checkbox'> <label for='dropdown2'> <img
						src='https://s3-us-west-2.amazonaws.com/s.cdpn.io/343086/arrowDown.png'>
						<ul id="do_select">
							<li>To Do</li>
							<li>Doing</li>
							<li>Done</li>
						</ul>
					</label> </input>
				</div>
			</div>

			<div class='todo_done_doing_boardcontainer' id="todocontainer">
			   <c:if test="${empty todo_list}">
					<div class='  todo_done_doing_boardcontainer__board' id="none_todo">
							<h2> 일정이 없습니다. </h2>
					</div>
				</c:if>
			
				<c:forEach var="todo_vo" items="${todo_list}"  begin="0" end="${max_todo}" step="1" varStatus="status"   >
					<div class='  todo_done_doing_boardcontainer__board'>
						<div class='article_title'>
							<h3>#${todo_vo.pj_name}</h3>
						</div>


						<div class='article_title'>
							<h4>${todo_vo.subject}</h4>
						</div>


						<div class='start_date'>
							<p>${todo_vo.b_date}</p>
						</div>

						<div class='article_content'>
							${todo_vo.b_content}
						</div>

					</div>


				</c:forEach>

				<c:if test="${fn:length(todo_list)-1 gt max_todo && max_todo ge '3'}">
				<div class='todo_done_doing_boardcontainer__board' id="show_all_do">
					<button class="color-d circule" id="show_do">
						<i class="fas fa-angle-down fa-2x"></i>
					</button>
				</div>
				</c:if>
			</div>
		</div>

	</div>
	<!-- 전체 div -->


	<!-- 프로젝트 생성 모달창  -->
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		data-backdrop="static">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
					<h2 class="modal-title" id="myModalLabel">새 프로젝트 생성</h2>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="pj_name">프로젝트명</label>
						 <input name="pj_name" 
							id="pj_name" placeholder="제목을 입력하세요.(10자 이내)" type="text"
							class="form-control" />
					</div>
					<div class="form-group" id="disclosure_group">
						<label for="pj_open">공개여부</label> <br> 
						<input name="pj_open"
							id="pj_open" value='open' type="radio" class="form-control" checked="checked"/> <span>공개</span>
						<input name="pj_open" id="pj_open" value='private' type="radio"
							class="form-control" /> <span>비공개</span>
					</div>
					<div class="form-group">
						<label for="pj_sdate">시작일자</label> 
						<input name="pj_sdate"
							id="pj_sdate"  type="date" class="form-control" />
					</div>
					<div class="form-group">
						<label for="pj_ddate">마감일자</label> 
						<input name="pj_ddate"
							id="pj_ddate"  type="date" class="form-control" />
					</div>
					<div class="form-group">
						<label for="pj_contents">내용</label>
						<textarea name="pj_contents" id="pj_contents" 
							placeholder="간단한 설명을 입력해주세요.(200자 이내)" class="form-control"
							cols="38" rows="4"></textarea>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="create">Create</button>
					<button type="button" class="btn btn-default" data-dismiss="modal" id="close">Close</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 프로젝트 수정 모달창  -->
	<div class="modal fade" id="myModal2" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		data-backdrop="static">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
					<h2 class="modal-title" id="myModalLabel">프로젝트 수정</h2>
				</div>
				<div class="modal-body">
					<div class="form-group">
					<input id="pj_idx2"  value="" type="hidden" />
						<label for="pj_name">프로젝트명</label>
						 <input name="pj_name" 
							id="pj_name2"  type="text"	class="form-control" />
					</div>
					<div class="form-group" id="disclosure_group">
						<label for="pj_open">공개여부</label> <br> 
						<input name="pj_open" id="pj_open2" value='open' type="radio" class="form-control" checked="checked"/> <span>공개</span>
						<input name="pj_open" id="pj_open2" value='private' type="radio" class="form-control" /> <span>비공개</span>
					</div>
					<div class="form-group">
						<label for="pj_sdate">시작일자</label> 
						<input name="pj_sdate"
							id="pj_sdate2"  type="date" class="form-control" />
					</div>
					<div class="form-group">
						<label for="pj_ddate">마감일자</label> 
						<input name="pj_ddate"
							id="pj_ddate2"  type="date" class="form-control" />
					</div>
					<div class="form-group">
						<label for="pj_contents">내용</label>
						<textarea name="pj_contents" id="pj_contents2"  class="form-control"	cols="38" rows="4"></textarea>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="update">Update</button>
					<button type="button" class="btn btn-default" data-dismiss="modal" id="close">Close</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 그룹 수정 모달창  -->
	<div class="modal fade" id="myModal3" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		data-backdrop="static">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
					<h2 class="modal-title" id="myModalLabel">그룹 수정</h2>
				</div>
				<div class="modal-body" id="modal_g-body">
				    <input id="pj_idx2"  value="" type="hidden" />
	
							<div class="form-group" id="g_member">
							<form id="form2">
								<label for="g_member" id="g_member2">그룹 참여 인원</label>
								<div class="col-4 column" id="g_member3">
	
								</div>
							</form>	
							</div>

							<div class="form-group" id="g_out">
								<label for="g_out" id="g_out2">제외 인원</label>
								<form id="form1">
								<div class="col-4 column" id="g_out3">
									<div class="card text-black bg-primary mb-3 no-move" id="g_out5">
										<div class="card-header"> Nickname (Member-Email)</div>
									</div>													
						     	</div>
						     	</form>
							</div>
	
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="update2">Update</button>
					<button type="button" class="btn btn-default" data-dismiss="modal" id="close">Close</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 그룹 초대 모달창  -->
	<div class="modal fade" id="myModal4" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		data-backdrop="static">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
					<h2 class="modal-title" id="myModalLabel">그룹 초대</h2>
				</div>
				<div class="modal-body" id="modal_g-body">
				    <input id="pj_idx3"  value="" type="hidden" />
					<input id="m_idx3"  value="${m_inf.m_idx }" type="hidden" />
					<div class="form-group" id="g_search">
						<label for="g_member" id="g_search2">사용자 검색</label>
						 <input name="search" id="g_search3"  type="text"	class="form-control" placeholder="초대할 사람의 E-mail을 입력해주세요." />
						 <button type="button" class="btn" id="g_search4">Search</button>	
					</div>
					
					<div class="form-group" id="g_invite">
								<label for="g_invite" id="g_invite2">초대할 인원</label>
								<div class="col-4 column" id="g_invite3">
									<div class="card text-black bg-primary mb-3 no-move" id="g_member5">
										<div class="card-header"> Nickname (Member-Email)</div>
									</div>
									
								</div>
					</div>
	
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="invite">Invite</button>
					<button type="button" class="btn btn-default" data-dismiss="modal" id="close">Close</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>