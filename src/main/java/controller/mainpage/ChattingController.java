/**
 * 신이룸
 */

package controller.mainpage;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import common.Common;
import dao.mainpage.ChattingDAO;
import vo.mainpage.BoardPageVO;
import vo.mainpage.ChattingListVO;
import vo.mainpage.ChattingRoomVO;
import vo.mainpage.GroupVO;


@Controller
public class ChattingController {
	
	ChattingDAO chattingdao;

	public ChattingController() {
		System.out.println("BoardPageController 생성자");
	}

	public ChattingController(ChattingDAO chattingdao) {
		this.chattingdao = chattingdao;
	}
	
	// 채팅방 리스트
	@RequestMapping("/chat_list.do")
	public String chat_list( Model model, HttpServletRequest request ) {
		
		HttpSession session = request.getSession();
//		session.setAttribute("aa", "엥");
//		Object aa1 = session.getAttribute("aa");
//		System.out.println(aa1);
		// 임시
		int m_idx = (Integer) session.getAttribute("m_idx");
		System.out.println("첫채팅: " + m_idx);
//		int m_idx = session.getAttribute("m_idx");
		List<ChattingListVO> list = null;
		list = chattingdao.selectRoomList(m_idx);
		
		model.addAttribute("list", list);
//		System.out.println("chat_name : "+list.get(0).getChat_name());
//		System.out.println(list.get(0).getColor());
		
		return Common.BoardPage.BOARD_VIEW_PATH + "chat_list.jsp";
	}
	
	
	// 대화창
	@RequestMapping("/chat_room.do")
	public String chat_room( HttpServletRequest request , Model model, int chat_idx) { 
		
		HttpSession session = request.getSession();
		
		List<ChattingRoomVO> list = null;
		list = chattingdao.selectList(chat_idx);
 
		// 이건 로긴페이지에서 줄테니까 받으면 됨 아래 줄 지우면 됨
		int m_idx = (Integer) session.getAttribute("m_idx");
		
		// 같은 방에 있는 사람들의  m_idx를 가져와야 한다.
		List<ChattingListVO> m_idx_list = null;
		m_idx_list = chattingdao.select_midx_List(chat_idx);
		String all_list = "";

		for(int i = 0 ; i < m_idx_list.size() ; i++) {
			all_list += m_idx_list.get(i).getM_idx() + "/";
		} 
		 
		System.out.println("all_list : " + all_list);
		model.addAttribute("roomlist", list);
		model.addAttribute("m_idx", m_idx);
		model.addAttribute("chat_idx", chat_idx);
		model.addAttribute("m_idx_list", all_list);
		
		return Common.BoardPage.BOARD_VIEW_PATH + "chat_room.jsp";
 
	}
	  
	// 채팅 내용 db 저장
	@RequestMapping("/chat_save.do")
	public String chatSave( Model model, ChattingRoomVO vo, String offline_idx ) {
		
		System.out.println("컨트롤러 offline_idx : " + offline_idx);
		// offline_idx를 이용해서 오프라인인 사람에게 컬럼을 1로 준다.
		int res1 = chattingdao.offline(offline_idx, vo.getChat_idx());
		
		// 채팅 내용 저장
		int res = chattingdao.insert(vo);
		
		return "";
	}
	
	// 채팅방 생성
	@RequestMapping("/chat_reg.do")
	public String chat_reg_form( Model model, ChattingListVO vo) {
		vo.setM_idx(1);
		int res = chattingdao.chat_room_save(vo);
		
		return Common.BoardPage.BOARD_VIEW_PATH + "chat_room.jsp"; 
	}
	
	// 부재 메세지 체크
	@RequestMapping("/chat_offCheck.do")
	@ResponseBody
	public int offCheck(int m_idx) {
		
		int res = chattingdao.chat_offcheck(m_idx);
		//만약 res가 1이면 메시지가 없다는 뜻.
		 
		return res;
	}
	

}

















