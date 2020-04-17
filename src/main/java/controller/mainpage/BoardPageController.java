/**
 * 신이룸
 */

package controller.mainpage;



import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.asm.Attribute;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


import common.Common;
import dao.mainpage.BoardPageDAO;
import vo.mainpage.BoardDivisionVO;
import vo.mainpage.BoardPageVO;
import vo.mainpage.GroupVO;


@Controller
public class BoardPageController {
	String page = "all";

	BoardPageDAO boarddao;

	public BoardPageController() {
		System.out.println("BoardPageController 생성자");
	}

	public BoardPageController(BoardPageDAO boarddao) {
		this.boarddao = boarddao;
	}
	
	// 페이지 체크
	@RequestMapping("/pagecheck.do")
	public String pagecheck(String page) {
		
		this.page = page;
		return "redirect:board.do";
	}
	

	// 첫페이지
	@RequestMapping("/board.do")
	public String btn(Model model,HttpSession session, int pj_idx) {
		
		int m_idx = (Integer) session.getAttribute("m_idx");
		
		// 정환이 한테 받은 pj_idx 세션에 넣기.
		session.setAttribute("pj_idx", pj_idx);
		
		if(page.equals("mine")) {
			model.addAttribute("page", page);
			System.out.println("pagemine : " + page);
		}else {
			model.addAttribute("page", page);
			System.out.println("pageall : " + page);
		}
		
		
		return Common.BoardPage.BOARD_VIEW_PATH + "board_divisionBtn_page.jsp"; 
	} 
	
	// 전체 리스트 가져오기
	@RequestMapping("/divisionAll_list.do")
	public String list( Model model, HttpSession session) { 
		// 넘겨받은 idx가 없으니 임시
		int pj_idx = (Integer) session.getAttribute("pj_idx");

		List<BoardPageVO> b_list = null;
		List<GroupVO> g_list = null;
		b_list = boarddao.selectList(pj_idx);
		
		// 굳이 그룹테이블을 가져온 이유는, 팀에 몇명이 있는지 파악하고 팀원수+1 만큼 보드 만들어야 하기 때문에
		g_list = boarddao.selectGroupList(pj_idx);
		model.addAttribute("b_list", b_list);
		model.addAttribute("g_list", g_list);

		return Common.BoardPage.BOARD_VIEW_PATH + "board_divisionAll_page.jsp";

	}
	
	// 내 리스트 가져오기
	@RequestMapping("/divisionMine_list.do")
	public String division(Model model, HttpSession session) {
		// 넘겨받은 idx가 없으니 임시
		int m_idx = (Integer) session.getAttribute("m_idx");
		int pj_idx = (Integer) session.getAttribute("pj_idx");
		
		
		List<BoardPageVO> list = null;
		list = boarddao.division_select(m_idx);
		
		
		model.addAttribute("my_list", list);
		return Common.BoardPage.BOARD_VIEW_PATH + "board_divisionMine_page.jsp";
	}

	// 글 등록
	@RequestMapping("/reg_memo.do")
	public String regform(BoardPageVO vo, HttpSession session) {
		
		int pj_idx = (Integer) session.getAttribute("pj_idx");
		vo.setPj_idx(pj_idx); 
		System.out.println("b_content : " + vo.getB_content());
		System.out.println("실제 등록 m_idx : " + vo.getM_idx());
		System.out.println("priority : " + vo.getPriority());

		int res = boarddao.insert(vo);
		
		if(vo.getPage().equals("mine")) {
			page = "mine";
			
		}else {
			page = "all";
		}
		
		return "redirect:board.do";
	}

	// ALL 메모 이동 업데이트
	@RequestMapping("/memoSeq_modify.do")
	@ResponseBody
	public String memoSeq_modify( BoardDivisionVO vo, HttpSession session) {
		int pj_idx = (Integer) session.getAttribute("pj_idx");
		// 임시
		vo.setPj_idx(pj_idx);
		
		int res = boarddao.memo_move_update(vo);
		
		return "res";
		
	}
	
	// MINE 메모 이동 업데이트
	@RequestMapping("/Mine_memoSeq_modify.do")
	@ResponseBody
	public String MINE_memoSeq_modify( BoardDivisionVO vo, HttpSession session) {
		int pj_idx = (Integer) session.getAttribute("pj_idx");
		// 임시
		vo.setPj_idx(pj_idx);
		
		int res = boarddao.mine_memo_move_update(vo);
		
		return "res";
		 
		
	}
	
	// 메모 변경 업데이트
	@RequestMapping("/modify_update.do")
	public String modify_update(BoardPageVO vo) {
		
		int res = boarddao.memo_update(vo);

		
		if(vo.getPage().equals("mine")) {
			page = "mine";
			
		}else {
			page = "all";
		}
		
		return "redirect:board.do";
	}
	
	// 메모 등록 모달창 이동
	@RequestMapping("/reg_form.do")
	public String regformtest(Model model, int m_idx, int pj_idx, String division, String page) {
		// 여기까지 m_idx가 잘 들어옴. 버튼으로 했을때
		
		System.out.println("m_idx : " + m_idx);
		System.out.println("pj_idx : " + pj_idx);
		
		BoardPageVO vo = new BoardPageVO();
		vo.setM_idx(m_idx);
		vo.setPj_idx(pj_idx);
		vo.setDivision(division);
		
		if(page.equals("all")) {
			model.addAttribute("page", "all");
		}else {
			model.addAttribute("page", "mine");
			
		}
		
		model.addAttribute("list", vo);
		return Common.BoardPage.BOARD_VIEW_PATH + "memo_reg_form.jsp";
	}

	// 메모 변경 모달창 이동
	@RequestMapping("/memo_modify_form.do")
	public String modifytest(Model model, int b_idx, String page) {
		System.out.println("b_idx : " + b_idx);
		
		model.addAttribute("b_idx", b_idx);
		model.addAttribute("page", page);
		
		return Common.BoardPage.BOARD_VIEW_PATH + "memo_modify_form.jsp";
	}
	
	// 메모 삭제
	@RequestMapping("/memo_del.do")
	public String delete(int b_idx, String page) {
		System.out.println("b_idx : " + b_idx);
		System.out.println("del : " + page);
		int res = boarddao.delete(b_idx); 
		
		this.page = page;
		
		String result="no";
		 
		if( res != 0) {
			result = "yes"; // 삭제 성공시
		}

		return "redirect:board.do";
	}
	

}

















