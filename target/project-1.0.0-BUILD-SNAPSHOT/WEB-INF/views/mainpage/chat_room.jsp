<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>

 
</head>
<body> 
    <!-- Server responses get written here -->
    <div id="messages" style="overflow:auto; width:100%; height:380px; border:1px solid #fff; bottom: 0; background:white;">
    	<c:forEach var="vo" items="${roomlist}">
    	<!-- vo.m_name이 나 라면 오른쪽으로 뜨게..? -->
    		${vo.m_name} 
    		${vo.chat_content}<br>
    	</c:forEach> 
    	
    </div> 
    <div>
        <!-- 모델로 받으면 m_name 넣기. --> 
        <!-- chat_idx는 다 똑같기 때문에 걍 0으로 -->
	    <input type="text" id="chat_idx" value="${chat_idx}" style="display: none;">
	    <input type="text" id="sender" value="${m_idx}" style="display: none;">
	    <input type="text" id="m_name" value="${m_name}" style="display: none;">
	    <input type="text" id="m_idx_list" value="${m_idx_list}" style="display: none;">
        <input type="text" id="messageinput" onkeydown="if(event.keyCode==13) {send(); this.value='';}">
    </div>
    <div>
<!--         <button type="button" onclick="openSocket();">Open</button> -->
        <button type="button" onclick="send();">Send</button>
<!--         <button type="button" onclick="closeSocket();">Close</button> -->
<!-- 		<button type="exit" onclick="location.href='chat_list.do'">닫기</button> -->
		
    </div>
    <!-- websocket javascript -->
   <script type="text/javascript">
   var a = 0;
   console.log("CAHT ROOM IN");
      let ws=SockJS("<c:url value='/echo' />");
      console.log("hohphohphphphp");
       // 스크롤있을떄 시야를 하단 고정
       var divbottom = document.getElementById("messages");
       divbottom.scrollTop = divbottom.scrollHeight;

       var messages=document.getElementById("messages");
       var allMsg = "";
        
//         function openSocket(){
//             console.log("socket OPEN START");
//             if(ws!==undefined && ws.readyState!==WebSocket.CLOSED){
//                 console.log("WebSocket is already opened.");
//                 return;
//             }
//         }
        // 웹소켓이 열리면 호출
        ws.onopen=function(event){
        	console.log("작동되면 안됌");
            console.log("hello socket");
            console.log(event.data);
            var msg={};
            msg.type="open";
            msg.chat_idx="${chat_idx}";
            msg.m_idx="${m_idx}";
            console.log(msg);
            ws.send(JSON.stringify(msg));
        };
        
       // 메시지가 도착하면 호출
       ws.onmessage=function onMessage(event){
                console.log("22 receive Message from Socket : "+ event.data);
                writeResponse(event.data);
       };
       
       ws.onclose=function onClose(event){
    	   var m_idx = <%=session.getAttribute("m_idx")%>;
                console.log("22 Socket Close");
                var msg={};
                msg.type = "close";
                msg.chat_idx = "${chat_idx}";
                msg.m_idx = m_idx;
                console.log(msg);
                ws.send(JSON.stringify(msg));
//                 writeResponse("Connection closed");
                /* 나갈때 어디로 갈지. */
//                 location.href="chat_save.do";
       };
         
        
       function send(){
           console.log("send1");
//            var text=document.getElementById("messageinput").value+"/"+document.getElementById("sender").value +"/";
           var text=document.getElementById("messageinput").value;
//            ws.send(text);
            var msg={};
            msg.type="text";
            msg.chat_idx="${chat_idx}";
            msg.m_idx="${m_idx}";
            msg.m_idx_list="${m_idx_list}";
            msg.text = text;
            console.log(msg);
            ws.send(JSON.stringify(msg));
           text="";
           messageinput.innerHTML = "";
        }
       function close(){
    	   ws.close();
        }
        
        function closeSocket(){
        	console.log("끝");
            ws.close(); 
        }
        
        function writeResponse(text){
        	// 여기서 내용들을 저장하고. 
        	// 채팅방을 나가면 db전송으로 할까..
        	console.log("안들어온사람 m_idx : "+text);
        	var offline = text.split('/');
        	var msg = "";
        	var offline_idx = "";
        	 
        	for(var i = 0 ; i < offline.length-1 ; i++){
        		if(i==0){
        			msg = offline[0];
        		}else{
        			console.log("offline"+"["+i+"]"+offline[i]);
                	offline_idx += offline[i]+"/";
        		}
        	} 
        	 
            messages.innerHTML+=document.getElementById("m_name").value+ " "+msg + "<br>";
            
            var chat_idx = document.getElementById("chat_idx").value;
            var m_idx = document.getElementById("sender").value;
            var divbottom = document.getElementById("messages");
            divbottom.scrollTop = divbottom.scrollHeight;
            
            console.log("보낸 메시지 : "+msg);
            
            // 내용 저장하면서 오프라인인 사람 db에 표시하기.
            var url = "chat_save.do"
            var param = "chat_content="+encodeURI(msg) + "&chat_idx=" + chat_idx + "&m_idx=" + m_idx + "&offline_idx=" + offline_idx;
            
            sendRequest(url, param, resultFn, "Post");
            
        }
        
        function resultFn() {
			console.log("저장콜백");
		}
        
        </script>
</body>
</html>


