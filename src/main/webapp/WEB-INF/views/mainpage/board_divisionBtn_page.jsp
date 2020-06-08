<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>

<c:import url="/upmenubar.do">
		<c:param name="m_idx" value="${m_idx}"/>
	</c:import>
	<jsp:include page="../menubar/leftmenubar.jsp"/>

<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- 부트스트랩 3.x를 사용한다. -->
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.js"></script>
<!-- css 가져오는 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mainpage/boardpage.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mainpage/switchbtn.css">


<script>
	
var boo = true;
var page = "";


$(document).ready(function() {
page = document.getElementById('page').value;   

if(page == "all"){
	// board.do 들어오면 divisionAll 페이지 부터 들어가고.
	// 그 이후부터 밑에서 왔따갔다.
	    $.ajax({
	        type : "GET",
	        url : "divisionAll_list.do",
	        dataType : "text",
	        error : function(){
	            alert('통신실패!!'); 
	        },
	        success : function(data){
	            $("#container-fluid").html(data) ;
	        }
	         
	    });
	     
	 
}else{
	
	$.ajax({ 
        type : "GET",
        url : "divisionMine_list.do",
        dataType : "text",
        async: true,
        error : function(){
            alert('통신실패!!');
        },
        success : function(data){
        	boo = false;
//         	alert(boo);
            $("#container-fluid").html(data);
        }
         
    }); 
	
}

});

	
	function switch_btn() {

		if(boo == true){
			        $.ajax({ 
			            type : "GET",
			            url : "divisionMine_list.do",
			            dataType : "text",
			            async: true,
			            error : function(){
			                alert('통신실패!!');
			            },
			            success : function(data){
			            	boo = false;
// 			            	alert(boo);
			                $("#container-fluid").html(data);
			            }
			             
			        }); 
			          
		}else{
			        $.ajax({
			            type : "GET",
			            url : "divisionAll_list.do",
			            dataType : "text",
			            async: true,
			            error : function(){
			                alert('통신실패!!');
			            },
			            success : function(data){
			            	boo = true;
// 			            	alert(boo);
// 			            	location.reload();
// 			            	$("#container-fluid").load('divisionAll_list.do');
			                $("#container-fluid").html(data) ;
			            }
			             
			        });
			         
		}
		
		
		
		
// 		$("#bbs").click(function() {
			
// 			 $.ajax({ 
// 		            type : "GET",
// 		            url : "bbsboard_list.do",
// 		            dataType : "text",
// 		            async: true,
// 		            error : function(){
// 		                alert('통신실패!!');
// 		            },
// 		            success : function(data){
// 		            	boo = false;
// //		            	alert(boo);
// 		                $("#container-fluid").html(data);
// 		            }
		             
// 		        }); 
			
			
// 		});
	}
	
	
	
	
	
	

	</script>
	
</head>
<body> 
	<!-- ALL or MINE -->
		ALL<div class="switch" onclick="switch_btn();">  <input class="check" type="checkbox">
<!-- 		체크가 되어있는게 디폴트.  -->
		<span class="slider round"></span>  
		</div> MINE	

<!-- <button onclick="switch_btn();">스위치 버튼 </button>	 -->
		<button class="bbs" onclick="location.href='bbsboard_list.do'">게시판으로 이동</button>
	<div in="alarm"></div>
	
	<input type="hidden" id="page" value="${page}"/>
	<div class="container-fluid" id="container-fluid"></div>
	
</body>
</html>




















