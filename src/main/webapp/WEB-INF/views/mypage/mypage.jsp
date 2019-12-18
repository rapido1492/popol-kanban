<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


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
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>




<script>
    	<!-- 프로젝트 필터링  -->
	var selected_project = "Now Projects";
 	   jQuery(document).ready(function() {
  	      $("#pj_select").on("click", "li", function() {
  	    	selected_project=$(this).text();
  	    	document.getElementById("selected_project").innerHTML=selected_project;
   	     });
  	  });
 	   
      <!-- Doing필터링  -->
 	var selected_do = "To Do";   
	   jQuery(document).ready(function() {
	      $("#do_select").on("click", "li", function() {
	    	selected_do=$(this).text();
	    	document.getElementById("selected_do").innerHTML=selected_do;
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
			url:"/project/pj_create.do",
			data:{"pj_name" : $('#pj_name').val(),
				  "pj_open" : $('#pj_open').val(),
				  "pj_sdate" : $('#pj_sdate').val(),
				  "pj_ddate" : $('#pj_ddate').val(),
				  "pj_contents" : $('#pj_contents').val()
			},			
			success: function(){
				$('#myModal').modal("hide");
				alert("프로젝트가 생성되었습니다.");
			}, error: function(){
				alert("프로젝트 등록 실패.");}			
		});
    });
});	
    
        
</script>



</head>
<body>

	<!-- 전체 -->
	<div class="whole_board">
		<!-- 프로필  -->
		<div class="grid-7 element-animation">
			<div class="card color-card-2">
				<ul>
					<li><i class="fas fa-arrow-left i-l b"></i></li>
					<li><i class="fas fa-ellipsis-v i-r b"></i></li>
					<li><i class="far fa-heart i-r b"></i></li>
				</ul>
				<img
					src="https://images.unsplash.com/photo-1499557354967-2b2d8910bcca?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=7d5363c18112a02ce22d0c46f8570147&auto=format&fit=crop&w=635&q=80%20635w"
					${m_inf.m_photo} alt="profile-pic" class="profile">
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
								<i class="fas fa-play fa-2x"></i>
							</button>
							<h2 class="title-2">5</h2>
							<p class="followers">${vo.doing_cnt}Doing</p>
						</div>
						<div class="grid-2">
							<button class="color-c circule">
								<i class="far fa-calendar-alt fa-2x"></i>
							</button>
							<h2 class="title-2">4</h2>
							<p class="followers">${vo.todo_cnt}ToDo</p>
						</div>
						<div class="grid-2">
							<button class="color-d circule">
								<i class="fas fa-check fa-2x"></i>
							</button>
							<h2 class="title-2">3</h2>
							<p class="followers">${vo.done_cnt}Done</p>
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
		<div class='newsfeed'>
			<div class='newsfeed_header'>
				<div class='newsfeed_header__left1'>
					<h1>My Project</h1>
					<input id='pj_dropdown' type='checkbox'> <label
						for='pj_dropdown'> <img id=pj_arrow
						src='https://s3-us-west-2.amazonaws.com/s.cdpn.io/343086/arrowDown.png'>
						<ul id="pj_select">
							<li>All</li>
							<li>Now Projects</li>
							<li>Past Projects</li>
						</ul>
					</label> </input>
				</div>
				<div class='newsfeed_header__right1'>
					<h1 id="selected_project">Now Projects</h1>
				</div>
			</div>

			<div class='newsfeed_articlecontainer'>
				<!-- Project 목록 불러오기(데이터포함)  -->
				<c:forEach var="pj_vo" items="${my_pj_list}">
					<div class='newsfeed_articlecontainer__article'>
						<div class='pj_option'>
							<i class="fas fa-ellipsis-v i-r b"></i>
						</div>
						<div class='d_date'>
							<p>D-15${pj_vo.pj_d_date}</p>
						</div>

						<div class='article_title'>
							<h1>${pj_vo.pj_name}KanBan
								Project#01 / <span>${pj_vo.pj_leader}내가리더다!!</span>
							</h1>
						</div>


						<div class='start_date'>
							<p>Start Date : 2019/12/10${pj_vo.pj_start_date}</p>
						</div>
						<div class='due_date'>
							<p>
								Due<span>l</span> Date : 2019/12/25${pj_vo.pj_due_date}
							</p>
						</div>

						<div class='article_content'>
							<p>What's happening in the industry? What important
								techniques have emerged recently? What about new case studies,
								insights, techniques and tools?</p>
						</div>

					</div>


				</c:forEach>

				<div class='newsfeed_articlecontainer__article' id="show_all">
					<button class="color-d circule" id="show">
						<i class="fas fa-angle-down fa-2x"></i>
					</button>
				</div>

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

			<div class='todo_done_doing_boardcontainer'>
				<c:forEach var="pj_vo" items="${my_pj_list}">
					<div class='  todo_done_doing_boardcontainer__board'>

						<div class='d_date'>
							<p>D-15${pj_vo.pj_d_date}</p>
						</div>

						<div class='article_title'>
							<h1>${pj_vo.pj_name}KanBan
								Project#01 / <span>${pj_vo.pj_leader}내가리더다!!</span>
							</h1>
						</div>


						<div class='start_date'>
							<p>Start Date : 2019/12/10${pj_vo.pj_start_date}</p>
						</div>
						<div class='due_date'>
							<p>
								Due<span>l</span> Date : 2019/12/25${pj_vo.pj_due_date}
							</p>
						</div>

						<div class='article_content'>
							<p>What's happening in the industry? What important
								techniques have emerged recently? What about new case studies,
								insights, techniques and tools?</p>
						</div>

					</div>


				</c:forEach>


				<div class='todo_done_doing_boardcontainer__board' id="show_all_do">
					<button class="color-d circule" id="show_do">
						<i class="fas fa-angle-down fa-2x"></i>
					</button>
				</div>

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
							id="pj_open" value='open' type="radio" class="form-control" /> <span>공개</span>
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


</body>
</html>