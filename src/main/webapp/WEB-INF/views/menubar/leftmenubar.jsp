<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/menubar/leftmenubar.css">


</head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.js"></script>

<script type="text/javascript">
	 
$(document).ready(function () {
	$(".alarm").hide();
	 
	  $('.yeti-open-sections-list-button').on('click', function () {
	    $('.yeti-left-two').animate({ scrollTop: 0 }, 1);
	    $('.yeti-open-sections-list-button, .yeti-open-add-section-button, .chatting-button').removeClass('yeti-active');
	    $('.yeti-left-two').removeClass('yeti-open');
	    $(this).addClass('yeti-active');
	    $('.yeti-left-two.yeti-one').addClass('yeti-open');
	  });
	  
	  $('.yeti-open-add-section-button').click('mouseenter', function () {
	    $('.yeti-left-two').animate({ scrollTop: 0 }, 1);
	    $('.yeti-open-sections-list-button, .yeti-open-add-section-button, .chatting-button').removeClass('yeti-active');
	    $('.yeti-left-two').removeClass('yeti-open');
	    $(this).addClass('yeti-active');
	    $('.yeti-left-two.yeti-two').addClass('yeti-open');
	  });
	  
	  $('.chatting-button').on('click', function () {
		$('.yeti-left-two').animate({ scrollTop: 0 }, 1);
		$('.yeti-open-sections-list-button, .yeti-open-add-section-button, .chatting-button').removeClass('yeti-active');
		$('.yeti-left-two').removeClass('yeti-open');
		$(this).addClass('yeti-active');
		$('.yeti-left-two.chatting').addClass('yeti-open');
		
		 $.ajax({
		        type : "GET",
		        url : "chat_list.do",
		        dataType : "text",
		        error : function(){
		            //alert('통신실패!!'); 
		        },
		        success : function(data){
		            $("#chat_list").html(data) ;
		        }
		         
		    });
		
	  });
	  
	   
	  
	  $('.chat_exit').click('mouseleave', function () {
	    $('.yeti-open-sections-list-button, .yeti-open-add-section-button').removeClass('yeti-active');
	    $('.yeti-left-two').removeClass('yeti-open');
	  }); 
	  
	  $('.yeti-unlock-button').click(function () {
	    $('.yeti-unlock-button i').toggleClass('ion-ios-locked-outline, ion-ios-unlocked-outline');
	  });
	  
	  
	  // off 체크하기.
	  $.ajax({ 
	        type : "GET", 
	        url : "chat_offCheck.do?m_idx="+<%= session.getAttribute("m_idx")%>,
	        dataType : "text",
	        error : function(){
	            //alert('통신실패!!');  
	        },
	        success : function(text){
	            if(text == 1){
	        		$(".alarm").hide();
	        	}else{
	        		$(".alarm").show();
	        	}
	            
	        }
	         
	    });
	  
	  
	  
	});
	
	
	


/* ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ */




let ws=new SockJS("<c:url value='/echo' />");
ws.onopen=function(event){
    console.log("hello socket");
    console.log(event.data);
    var msg={};
    msg.type="list";
	var h = <%=session.getAttribute("m_idx")%>;
	alert("h : " + h);
	
    msg.m_idx=h;
    console.log(msg);
    ws.send(JSON.stringify(msg));
};

// 메시지가 도착하면 호출
ws.onmessage=function onMessage(event){
        console.log("22 receive Message from Socket : "+ event.data);
        console.log("메세지가 도착하면 호출 btn");
        /* 여기서도 들어오면 빨간점 뜨게 하기. */
        
          // off 체크하기.
	  $.ajax({ 
	        type : "GET", 
	        url : "chat_offCheck.do?m_idx="+<%= session.getAttribute("m_idx")%>,
	        dataType : "text",
	        error : function(){
	            //alert('통신실패!!');  
	        },
	        success : function(text){
	            if(text == 1){
	        		$(".alarm").hide();
	        	}else{
	        		$(".alarm").show();
	        	}
	            
	        }
	         
	    });
        
        
        writeResponse(event.data);
        
        
};

ws.onclose=function onClose(event){
        console.log("22 Socket Close");
//         writeResponse("Connection closed");
        /* 나갈때 어디로 갈지. */
//         location.href="chat_save.do";
};


function writeResponse(text){
	// 여기서 내용들을 저장하고. 
	// 채팅방을 나가면 db전송으로 할까..
   alarm.innerHTML+="메세지가 도착했씁니다.";
   
   var chat_idx = document.getElementById("chat_idx").value;
   var m_idx = document.getElementById("sender").value;
   
//    alert("chat_idx : " + chat_idx +"m_idx : " + m_idx);
   
//    var divbottom = document.getElementById("messages");
//    divbottom.scrollTop = divbottom.scrollHeight;
   
   console.log("보낸 메시지"+text);
   
//    var url = "chat_save.do"
//    var param = "chat_content="+encodeURI(text) + "&chat_idx=" + chat_idx + "&m_idx=" + m_idx;
   
//    sendRequest(url, param, resultFn, "Post");
}

//function resultFn() {
//		console.log("저장콜백");
//	} 

</script>

<body>   
<div id="yeti-left-nav" class="cleanslate" >
  <div class="yeti yeti-left-nav">
    <div class="yeti-left-left">
      <a class="yeti yeti-left-menu-button yeti-open-sections-list-button">
      	<img alt="" src="${pageContext.request.contextPath}/resources/css/menubar/menu.png">
        <i class="ion-ios-copy-outline"></i>
      </a>
      <a class="yeti yeti-left-menu-button yeti-open-add-section-button">
      	<img alt="" src="${pageContext.request.contextPath}/resources/css/menubar/file.png">
        <i class="ion-ios-plus-empty"></i>
      </a> 
      <a class="yeti yeti-left-menu-button chatting-button">
      	<span class="alarm">@</span>
      	<img alt="" src="${pageContext.request.contextPath}/resources/css/menubar/file.png">
        <i class="ion-ios-plus-empty"></i>
      </a>
      
       
      
       
<!--        <div class="yeti-align-button-bottom">
        <a class="yeti yeti-left-menu-button yeti-unlock-button">
          <i class="ion-ios-gear-outline"></i>
        </a>
        <a class="yeti yeti-left-menu-button yeti-unlock-button">
          <i class="ion-ios-locked-outline"></i>
        </a>
      </div> -->
    </div>
    
    <div class="yeti-left-two yeti-one">
      <div class="yeti-left-title">
        MANAGE SECTIONS
        <a href="#">
        <img src="${pageContext.request.contextPath}/resources/css/menubar/closed.png" 
        style="width: 40px; height: 40px; position: absolute; top: 0%; left: 80%;">
      	</a>
      </div>
      <a class="yeti yeti-left-menu-button yeti-align-left">
        <i class="ion-ios-drag"></i>
        <span class="yeti-text">Hero Section</span>
        <i class="ion-ios-trash-outline yeti-float-right yeti-trash-icon"></i>
      </a>
      <a class="yeti yeti-left-menu-button yeti-align-left">
        <i class="ion-ios-drag"></i>
        <span class="yeti-text">About Us</span>
        <i class="ion-ios-trash-outline yeti-float-right yeti-trash-icon"></i>
      </a>
    </div>
   </div>

    <div class="yeti-left-two yeti-two">
      <div class="yeti-left-title">
        ADD A SECTION
        <a href="#">
       <img src="${pageContext.request.contextPath}/resources/css/menubar/closed.png" 
       style="width: 40px; height: 40px; position: absolute; top: 0%; left: 80%;">
     	</a>
      </div>
      <a class="yeti yeti-left-menu-button">
        <span class="yeti-text yeti-thumbnail-label">Hero Section</span>
      </a>
      <a class="yeti yeti-left-menu-button">
        <span class="yeti-text yeti-thumbnail-label">Hero Section</span>
      </a>
    </div>
    
     <div class="yeti-left-two chatting">
      <div class="yeti-left-title">
        CHATTING
        <a href="#" class="chat_exit">
       <img src="${pageContext.request.contextPath}/resources/css/menubar/closed.png" 
       		style="width: 40px; height: 40px; position: absolute; top: 0%; left: 80%;">
     	</a>
      </div>
<!--       <a class="yeti yeti-left-menu-button">
        <span class="yeti-text yeti-thumbnail-label">Hero Section</span>
      </a>
      <a class="yeti yeti-left-menu-button">
        <span class="yeti-text yeti-thumbnail-label">Hero Section</span>
      </a> -->
      <div id="chat_list" class="chat_list"></div>
      
    </div>
    
  </div>



	
</body>
</html>