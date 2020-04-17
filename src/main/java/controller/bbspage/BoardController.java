package controller.bbspage;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import common.Paging;
import dao.bbspage.BoardDAO;
import vo.bbspage.BoardReplyVO;
import vo.bbspage.BoardVO;
import vo.bbspage.InviteVO;
import vo.bbspage.Invite_alert;
import vo.mainpage.DirectoryVO;

	@Controller
	public class BoardController {
	// 서블릿에 오토와이어드 설정 해놓음.
	@Autowired
	ServletContext application;
	
	@Autowired
	HttpSession session;
	
	@Autowired
	HttpServletRequest request;
	BoardDAO boarddaobean;
	DirectoryVO vo;
	

	public BoardController() {
	}
	
	public void setBoard_dao(BoardDAO boarddaobean) {
		this.boarddaobean = boarddaobean;
	}
	
	public BoardController(BoardDAO boarddaobean) {
		this.boarddaobean = boarddaobean;
	}
	
	// 게시글 전체목록
	@RequestMapping(value = {"/bbsboard_list.do" })
	public String list(Model model, Integer page) { // integer로 쓴 이유는 null체크 하려고 받은거다.

		int nowPage = 1;
		if (page != null) {
			nowPage = page;
		}
		
//		  int pj_idx= (Integer) session.getAttribute("pj_idx");
//		  System.out.println("세션pj_idx:"+pj_idx);
//		 
		// 한 페이지에서 표시되는 게시물의 시작과 끝번호를 계산
		// 1페이지라면 1~10번 게시물까지만 보여줘야 한다.
		// 2페이지라면 11~20번 게시물까지만 보여줘야 한다.
		int start = (nowPage - 1) * common.Common.Board.BLOCKLIST + 1;
		// start = nowPage를 파라미터로 받아서 파라미터가 null이 아닐 경우 정수로 변환 후 (보여줄 게시글 수 * nowPage) +
		// 1이 현재 페이지로 계산
		int end = start + common.Common.Board.BLOCKLIST - 1;
		// start와 end를 map에 저장
		Map map = new HashMap();
		map.put("pj_idx",21); 
		map.put("start", start);
		map.put("end", end);

		// 게시글 전체목록 가져오기
		List<BoardVO> list = null;
		list = boarddaobean.selectList(map);
		
		// 전체 게시물 수 구하기
		int row_total = boarddaobean.getRowTotal();

		// 페이지 메뉴 생성하기
		String pageMenu = Paging.getPaging("bbsboard_list.do", nowPage, row_total, common.Common.Board.BLOCKLIST,
				common.Common.Board.BLOCKPAGE);

		
		// request 영역에 list 바인딩
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
		// 세션에 등록되어 있던 show 정보를 없앤다
		request.getSession().removeAttribute("show");

		// 바인딩 한 정보를 포워딩
		return common.Common.VIEW_PATH + "board_list.jsp";
	}

	// 게시물 보기
	@RequestMapping("/bbsboard_view.do")
	public String view(Model model, int b_idx, int m_idx) {
		BoardVO bvo = boarddaobean.selectOne(b_idx);	
		DirectoryVO dvo = boarddaobean.directory_search(b_idx);
		List<BoardReplyVO> revo = boarddaobean.replyselectList(b_idx);
		String userNick = boarddaobean.userNickname(m_idx);
		//게시글 작성자 프로필 사진
		String writer_m_photo = boarddaobean.profile_search(bvo.getM_idx());
		bvo.setFile_name(writer_m_photo);
		
		//댓글 작성자 프로필 사진
		String reply_m_photo = boarddaobean.profile_search(m_idx);
		// 조회수 증가
		HttpSession session = request.getSession();
		
		String show = (String) session.getAttribute("show");
		if (show == null) {
			// 읽지 않은 게시물 일때만 조회수를 증가
			int res = boarddaobean.update_readhit(b_idx);
			session.setAttribute("show", "yes");
		}
		
		model.addAttribute("userNick", userNick);
		model.addAttribute("m_photo", reply_m_photo);
		model.addAttribute("dvo", dvo);
		model.addAttribute("bvo", bvo);
		model.addAttribute("revo", revo);
		return common.Common.VIEW_PATH + "board_view.jsp";
	}

	// 게시글 작성 페이지로 전환
	@RequestMapping("/bbsboard_insert_form.do")
	public String insert_form() {
		return common.Common.VIEW_PATH + "board_write.jsp";

	}

	// 게시글 작성
	@RequestMapping("/bbsboard_insert.do")
	public String insert(BoardVO vo) {
		
		String webPath = "/resources/upload/"; // 절대경로
		int pj_idx= (Integer) session.getAttribute("pj_idx");
		String savePath = application.getRealPath(webPath);

		// 업로드된 파일의 정보
		MultipartFile photo = vo.getPhoto();
		
		long file_memory = vo.getPhoto().getSize();
		String file_name = "no_file";
		// 업로드를 위한 이미지가 존재하는 경우
		if( !photo.isEmpty() ) {
			file_name = photo.getOriginalFilename(); // 업로드한 파일의 실제 파일명

			File saveFile = new File(savePath, file_name); // savePath에다가 filename을 넣을것.
			
			if( !saveFile.exists() ) { // 경로가 존재하지 않다면.
				saveFile.mkdirs();
			}else {
				// 동일파일명 중복방지
				long time = System.currentTimeMillis();
				file_name = String.format("%d_%s", time, file_name);
				saveFile = new File(savePath, file_name);
			}
		    try {
		        photo.transferTo(saveFile); // 업로드 파일에 saveFile이라는 껍데기 입힘
		    } catch (IOException e) {
		        e.printStackTrace();
		        return null;
		    }
		      
		}//if( !photo.isEmpty() )
		Map vomap = new HashMap();
		vomap.put("m_nick",vo.getM_nick());
		vomap.put("m_idx",vo.getM_idx());
		vomap.put("pj_idx",21);
		vomap.put("b_content",vo.getB_content());
		vomap.put("memo_seq",1);
		vomap.put("division",vo.getDivision());
		vomap.put("priority", vo.getPriority());
		vomap.put("subject", vo.getSubject());
		int res=boarddaobean.insert(vomap);
		
		Map dvomap = new HashMap();
		dvomap.put("pj_idx",21);
		dvomap.put("m_idx",vo.getM_idx());
		dvomap.put("file_name", file_name);
		dvomap.put("file_memory", file_memory);
		dvomap.put("file_title", vo.getSubject());
		dvomap.put("pwd",vo.getPassword());
		
		int dvores = boarddaobean.directoryinsert(dvomap);
		// 포워딩 없이 페이지만 이동
		return "redirect:bbsboard_list.do";
	}
	

	// 게시글 삭제
	@RequestMapping("/bbsboard_del.do")
	@ResponseBody // ajax로 하겠다는 뜻.(값으로 인식하라는 뜻. 데이터만 넘어간다.)
	public String delete( int b_idx, int m_idx) {
		/* BoardVO baseVO = boarddaobean.selectOne(b_idx); */
		String result = "no";
		System.out.println("del:"+m_idx);
		int res = boarddaobean.userSearch(m_idx);
		if(res != 0) {
			//삭제
			res = boarddaobean.del_update( b_idx );
			if(res == 1) {
				result = "yes";
			}
		}
		return result;
	}
		
	//버그 있어서 일단 기능 보류
		
	/*
	 * // 답글달기 화면으로 전환
	 * 
	 * @RequestMapping("/bbsboard_reply_form.do") public String reply_form() {
	 * return common.Common.VIEW_PATH + "board_reply.jsp"; }
	 * 
	 * // 답글 처리
	 * 
	 * @RequestMapping("/bbsboard_reply.do") public String reply( int idx, String
	 * name, String subject, String content, String pwd, String page ){
	 * 
	 * 
	 * //기준글 idx를 사용하여 게시물 정보를 얻어오기 BoardVO baseVO = boarddaobean.selectOne(idx);
	 * 
	 * //기준글의 step보다 큰 값은 step = step + 1; int res =
	 * boarddaobean.update_step(baseVO); String ip = request.getRemoteAddr();
	 * 
	 * //답글용 VO BoardVO vo = new BoardVO();
	 * 
	 * String webPath = "/resources/upload/"; String savePath =
	 * application.getRealPath(webPath); //절대 경로 System.out.println(savePath);
	 * 
	 * // 업로드된 파일의 정보 MultipartFile photo = vo.getPhoto(); String filename =
	 * "no_file";
	 * 
	 * // 업로드를 위한 이미지가 존재하는 경우 if( !photo.isEmpty() ) { filename =
	 * photo.getOriginalFilename(); // 업로드한 파일의 실제 파일명
	 * 
	 * File saveFile = new File(savePath, filename); // savePath에다가 filename을 넣을것.
	 * 
	 * if( !saveFile.exists() ) { // 경로가 존재하지 않다면. saveFile.mkdirs(); }else { //
	 * 동일파일명 중복방지 long time = System.currentTimeMillis(); filename =
	 * String.format("%d_%s", time, filename); saveFile = new File(savePath,
	 * filename); }
	 * 
	 * try { photo.transferTo(saveFile); } catch (Exception e) {}
	 * 
	 * }//if( !photo.isEmpty() )
	 * 
	 * 
	 * vo.setName(name); vo.setSubject(subject); vo.setContent(content);
	 * vo.setPwd(pwd); vo.setIp(ip); vo.setFilename(vo.getFilename());
	 * 
	 * //답글이 들어갈 위치 선정 vo.setRef(baseVO.getRef()); vo.setStep(baseVO.getStep() + 1);
	 * vo.setDepth(baseVO.getDepth() + 1);
	 * 
	 * boarddaobean.reply(vo);
	 * 
	 * 
	 * return "redirect:bbsboard_list.do?page="+page; }
	 */
		
	@RequestMapping("/bbsboard_comment.do")
	@ResponseBody
	public String commentInsert(BoardReplyVO vo, Model model) {
		
		// VO에 포장
//		BoardReplyVO vo = new BoardReplyVO();	
		vo.setB_idx(vo.getB_idx());
		vo.setContent(vo.getContent());
		vo.setRewriter(vo.getRewriter());
		vo.setM_idx(vo.getM_idx());
		String m_photo = boarddaobean.profile_search(vo.getM_idx());
		System.out.println("댓글 m_idx"+vo.getM_idx());
		vo.setFilename(m_photo);

		System.out.println("댓글 m_photo:"+vo.getFilename());
		int res = boarddaobean.coinsert(vo);
		
		model.addAttribute("reply", m_photo);
		String result="no";
		
		if( res != 0) {
			result = "yes"; // 댓글 작성 성공시
		}
		
		return result;
	}
	
	// 글 수정
	@RequestMapping("/modify_form.do")
	public String modify_form( Model model, int b_idx ) {
		BoardVO vo = boarddaobean.selectOne( b_idx ); // 수정 전 내용들이 vo에 들어간다.
		DirectoryVO dvo = boarddaobean.directory_search(vo.getB_idx());
		String existing_file = dvo.getFile_name();
		String subject = vo.getSubject();
		String content = vo.getB_content().replaceAll("<br>", "\n");
//		String filename = vo.getFile_name();
		
		vo.setSubject(subject);
		vo.setB_content(content);
//		vo.setFilename(filename);
		vo.setFilename(existing_file);
		if( vo != null ) {
			model.addAttribute("vo", vo);
		}
		
		return common.Common.VIEW_PATH + "board_modify_form.jsp";
	}
	
	@RequestMapping("/modify.do")
	@ResponseBody
	public String modify(BoardVO bvo) {
//		DirectoryVO dvo = boarddaobean.directory_search(bvo.getB_idx());
		String content = bvo.getB_content().replaceAll("\n", "<br>");
//		String new_file = dvo.getFile_name();
		
		bvo.setSubject(bvo.getSubject());
		bvo.setB_content(content);
		bvo.setMemo_seq(1);
		bvo.setPriority(bvo.getPriority());
		bvo.setDivision(bvo.getDivision());
		
//		int modify_fileres = boarddaobean.modify_filename(bvo.getB_idx(), new_file);
//		System.out.println(modify_fileres);
		
		String result = "no";
		
		int res = boarddaobean.modify_update(bvo);
		
		if( res != 0) {
			result = "yes"; // 수정 성공시
		}
		
		return result;
	}
	
	/*
	 * //초대 mapping
	 * 
	 * @RequestMapping("/invitesend.do") public String inviteflag(int m_idx) {
	 * String inviteres = boarddaobean.invite_search(m_idx);
	 * 
	 * //invite_result의 상태값이 false일 경우 invite flag true로 업데이트
	 * if(inviteres.equals("false")) { int res =
	 * boarddaobean.inviteflag_update(m_idx); }
	 * 
	 * return inviteres; }
	 */
	
	//초대수락
	@RequestMapping("/invite_accept.do") 
	@ResponseBody
	public String invite_accept(int m_idx) {
		String result = "no";		
		int res = boarddaobean.invite_accept(m_idx);
		if(res != 0) {
			result = "yes"; // 수정 성공시
		}
		return result;
	}
	
	//초대 조회 시 초대한 사람 닉네임, 초대한 사람 프로젝트 리턴
	@RequestMapping("/invite_alert.do") 
	public String invite_alert(int m_idx, Model model) {
		
		String inviteres = boarddaobean.invite_search(m_idx);
		System.out.println(inviteres);
		
		if(inviteres.equals("true")) {
			InviteVO vo = boarddaobean.invite_search_TB(m_idx);
			Invite_alert avo = new Invite_alert();
			
			String send_user = boarddaobean.userNickname(vo.getSend_m_idx());
			String project_name = boarddaobean.project_search(vo.getPj_idx());
			
			avo.setInvite_sender(send_user);
			avo.setProject(project_name);
			
			model.addAttribute("avo", avo);
		}
		else {
			String msg = "초대가 없습니다";
			model.addAttribute("msg", msg);
		}
		
		return common.Common.VIEW_PATH + "upmenubar.jsp";
	}
	
	// 캘린더
	@RequestMapping("/bbsboard_calendar.do")
	public String calendar() {
		
		return common.Common.VIEW_PATH + "board_calendar.jsp";
	}
}

















