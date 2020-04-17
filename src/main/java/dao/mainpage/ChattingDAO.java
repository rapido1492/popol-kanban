package dao.mainpage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;

import controller.mainpage.EchoHandler;
import vo.mainpage.BoardDivisionVO;
import vo.mainpage.BoardPageVO;
import vo.mainpage.ChattingListVO;
import vo.mainpage.ChattingRoomVO;
import vo.mainpage.GroupVO;

@Controller
public class ChattingDAO {
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		System.out.println("ChattingDAO 생성자 생성");
		this.sqlSession = sqlSession;
	}
	
	
	// 채팅창 목록 출력
	public List<ChattingListVO> selectRoomList(int m_idx) {
		List<Integer> chat_idx_list = new ArrayList<Integer>();
		chat_idx_list = sqlSession.selectList("chatting.chat_idx",m_idx);

		List<ChattingListVO> list =null;
		
		if(chat_idx_list.isEmpty()) {
			 
			return list;
			
		} 
		
		HashMap hm = new HashMap(); 
		hm.put("chat_idx", chat_idx_list);
		
		
		list = sqlSession.selectList("chatting.chat_all_list", hm);
		
		return list;
	}  
	 
	// 같은 방에 들어 있는 사람들
	public List<ChattingListVO> select_midx_List(int chat_idx){
		List<ChattingListVO> list =null;
		
		list = sqlSession.selectList("chatting.chat_midx_list",chat_idx);
		
		return list;
	}
	
	
	// 대화창 전체 select
	public List<ChattingRoomVO> selectList(int chat_idx) {
		List<ChattingRoomVO> list =null;
		System.out.println("대화창 전체 select chat_idx : " + chat_idx);
		// 특정프로젝트(pj_idx)의 정보만 불러오기.
		list = sqlSession.selectList("chatting.chat_list", chat_idx);
		
		return list;
	}
	
	// 대화 저장
	public int insert(ChattingRoomVO vo) {
		int res = sqlSession.insert("chatting.chat_content_insert", vo);
		
		return res;
	}

	// offline 저장
	public int offline(String offline, int chat_idx) {
		
		String[] offline_idx_str = offline.split("/");
		
		ChattingRoomVO vo = new ChattingRoomVO();
		
		vo.setChat_idx(chat_idx);
		
		int res = 0;	
		
		for( int i = 0 ; i < offline_idx_str.length ; i++) {
			
			int offline_idx = Integer.parseInt(offline_idx_str[i]);
			vo.setM_idx(offline_idx);
			 
			res = sqlSession.insert("chatting.chat_offline", vo);
		}
		
		return res;
	}
	
	// 채팅방 생성
	public int chat_room_save(ChattingListVO vo) {
		
		// chat_list table에 먼저 저장
		int res = sqlSession.insert("chatting.chat_list_save", vo);
		
		// chat_group에 저장하기
		int res1 = sqlSession.insert("chatting.chat_group_save", vo);
		 
		return res;
	} 
	
	// off 체크
	public int chat_offcheck(int m_idx) {
		// 특정 채팅방이랑, 툴바 채팅방 알림 인데 일단 툴바 채팅방 부터...
		 
		List<ChattingRoomVO> res = sqlSession.selectList("chatting.chat_offcheck", m_idx);
		
		int result = 0;
		// res가 null이면 도착한 메시지가 없다는 뜻.
		if(res.size() == 0) {
			result = 1;
		}
		
		return result; 
	}
	
 
}













