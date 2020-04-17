package controller.mainpage;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class EchoHandler extends TextWebSocketHandler {

	// 웹 소켓 세션을 저장할 리스트 생성
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	//              방번호                             id       session
	private HashMap<String,HashMap<String,WebSocketSession>> sessionListINRoom = new HashMap<String,HashMap<String,WebSocketSession>> ();
	//               id       session				: 웹소켓 세션에 해당 m_idx를 넣는다.
	private HashMap<String,WebSocketSession> sessionINMain=new HashMap<String, WebSocketSession>();
//※클라이언트 연결 된 후
//WebSocketSession을 매개 변수로 받고 클라이언트가 연결된 후 
//해당 클라이언트의 정보를 가져와 연결확인 작업을한다.
//클라이언트의 세션을 세션 저장 리스트에 add()로 추가 한다.

	int UserId;

	// 새로운 세션이 연결되는 순간 이쪽의 메소드가 호출된다.
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("-----------------------------------------------------");
		System.out.println("접속 Sesseion ID : " + session.getId());
		sessionList.add(session);
	}

//※클라이언트와 연결이 끊어진 경우
//add()와 반대로 remove()를 이용해서 세션리스트에서 제거한다.
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("연결끝");
		sessionList.remove(session);
	}

// 웹 소켓 서버로 데이터를 전송했을 경우
//연결된 모든 클라이언트에게 메시지 전송 : 리스트
//연결된 모든 사용자에게 보내야 하므로 for문으로 세션리스트에 있는 모든 세션들을 돌면서
// sendMessage()를 이용해 데이터를 주고 받는다.

	// 메세지가 일로 떨어진다.
	// 어떤 세션인지 어떤 메시지 인지 알게됨.
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("handleTextMessage IN ");
		JSONParser jsonParse = new JSONParser();
		JSONObject jsonObject = (JSONObject)jsonParse.parse(message.getPayload());
//		idWithSessionINList.put((String)jsonObject.get("m_idx"), session);
		// jsp에서 보낸 sender의 밸류인 m_idx를 여기서 받을 수 있다.
		// db저장은 대충 알겠거
//		Map<String, Object> map = session.getAttributes();
//		String aa = (String) map.get("aa");
		System.out.println("message : " + message.getPayload());
		System.out.println("jsonObject EntrySet : "+jsonObject.entrySet());

		String[] m_idxList = String.valueOf(jsonObject.get("m_idx_list")).split("/");
		
		// 메세지를 보냈을때
		if("text".equals(jsonObject.get("type"))){
			textMsg(jsonObject, m_idxList);
			
			// 룸으로 들어왔을때
		}else if("open".equals(jsonObject.get("type"))){
			roomIn(jsonObject, session);
			
			// 메인페이지에 들어왓을때 연결.
		}else if("list".equals(jsonObject.get("type"))){
			System.out.println("Session ID : "+session.getId());
			String id=String.valueOf(jsonObject.get("m_idx"));
			System.out.println("session에 들어가는 id : " + id);
			if(sessionINMain.get(id)==null) {
				sessionINMain.put(id, session);
			}else {
				sessionINMain.remove(id);
			}
		} 
	}
	 
	private void roomIn(JSONObject jsonObject, WebSocketSession session) {
		System.out.println("Room OPEN");
		String roomNum=(String)jsonObject.get("chat_idx");
		String id=(String) jsonObject.get("m_idx");
		if(sessionListINRoom.get((String)jsonObject.get("chat_idx"))==null) {
			System.out.println("ROOM FIRST!!");
			HashMap<String, WebSocketSession> idListWithSessionInRoom = new HashMap<String, WebSocketSession>();
			idListWithSessionInRoom.put(id, session);
			sessionListINRoom.put(roomNum,idListWithSessionInRoom);
		}else {
			System.out.println("사람있음 !! : "+ sessionListINRoom.get((String)jsonObject.get("chat_idx")).toString());
			// 여기다가 m_idx를 넣는다. 
			// 만약 sessionListINRoom에 없다면 
			// sessionINMain에 메세지를 보내야 한다.(메세지가 도착했습니다. 이거나 숫자 보내기)
			sessionListINRoom.get(roomNum).put(id, session);
		}
	}
	private void textMsg(JSONObject jsonObject, String[] m_idxList) throws IOException {
		System.out.println("Text RECEIVE");
		String roomNum=(String)jsonObject.get("chat_idx");
		String id=(String) jsonObject.get("m_idx");
		String msg=(String)jsonObject.get("text");
		System.out.println("roomNum : "+roomNum+" / id : "+ id+ " / msg : "+ msg);
		HashMap<String, WebSocketSession> idListWithSessionInRoom=sessionListINRoom.get(roomNum);
		
		// 오프라인인 사람들에게 메세지가 도착했다고 보내야 하니까. 
        // 목록을 가지고 있어야 한다. db에서 가져오면 될듯하다.
	    String offline = "/";
	    for(int i = 0 ; i < m_idxList.length ; i++) {
	        if(sessionListINRoom.get(roomNum).get(m_idxList[i])==null) {
	        	offline += m_idxList[i]+"/";
	        }
	    }
	    
	    System.out.println("offline : " + offline);
	    
        for(String key:idListWithSessionInRoom.keySet()) {
        	// 온라인인 애들 한테 메시지 던지는거고 
        	msg += offline;
        	idListWithSessionInRoom.get(key).sendMessage(new TextMessage(msg));
        	System.out.println("idListWithSessionInRoom.get(key) : " + idListWithSessionInRoom.get(key));
        }
	        
//          sess.sendMessage(new TextMessage(message.getPayload()));
          System.out.println("SEND END");
    	
//		for(int i=0;i<sessionListWithRoom.size();i++) {
//		
//		}
	}
}
