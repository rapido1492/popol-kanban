package controller.mypage;

import java.lang.reflect.Array;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import common.Common;
import dao.mypage.MyPageDAO;
import vo.mypage.MyPage_GroupVO;
import vo.mypage.MyPage_GroupVO2;
import vo.mypage.MyPage_InviteVO;
import vo.mypage.MyPage_MemberVO;
import vo.mypage.MyPage_MemoBoardVO;
import vo.mypage.MyPage_ProjectVO;
import vo.mypage.MyPage_ProjectVO2;

@Controller
public class MyPageController {
	MyPageDAO mypagedao;
	int m_idx = 1;

	public static Boolean empty(Object obj) {
		if (obj instanceof String)
			return obj == null || "".equals(obj.toString().trim());
		else if (obj instanceof List)
			return obj == null || ((List) obj).isEmpty();
		else if (obj instanceof Map)
			return obj == null || ((Map) obj).isEmpty();
		else if (obj instanceof Object[])
			return obj == null || Array.getLength(obj) == 0;
		else
			return obj == null;
	}

	public static Boolean notEmpty(Object obj) {
		return !empty(obj);
	}

	public MyPageController() {
	}

	public MyPageController(MyPageDAO mypagedao) {
		this.mypagedao = mypagedao;
	}

	@RequestMapping(value = { "/mypage.do" })
	public String show(Model model, HttpServletRequest request) throws ParseException {
		
		HttpSession session = request.getSession();
		String m_idx2= String.valueOf(session.getAttribute("m_idx"));
		int m_idx= Integer.parseInt(m_idx2);
		// membervo가져오기
		MyPage_MemberVO m_inf;
		m_inf = mypagedao.selectOne(m_idx);
		String phone = m_inf.getM_phone().substring(0, 3)+'-'+m_inf.getM_phone().substring(3, 7)+'-'+m_inf.getM_phone().substring(7, 11);
		m_inf.setM_phone(phone);
		List<MyPage_MemoBoardVO> do_list;
		do_list = mypagedao.selecttodoList(m_idx);
		m_inf.setTodo_cnt(do_list.size());
		do_list = mypagedao.selectdoingList(m_idx);
		m_inf.setDoing_cnt(do_list.size());
		do_list = mypagedao.selectdoneList(m_idx);
		m_inf.setDone_cnt(do_list.size());
		model.addAttribute("m_inf", m_inf);

		// DB에서 project 목록 가져오기
		List<MyPage_ProjectVO2> project_list = mypagedao.selectpList(m_idx);

		for (int i = 0; i < project_list.size(); i++) {
			// pj_contents인코딩
			MyPage_ProjectVO2 vo2 = project_list.get(i);
			vo2.setPj_contents(vo2.getPj_contents().replaceAll("<br>", "\n"));

			// pj_leader삽입
			String pj_leader = mypagedao.select_pj_leader(vo2.getPj_idx());
			vo2.setPj_leader(pj_leader);

			// d-day 삽입 및 progress 삽입
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Calendar c1 = Calendar.getInstance();
			String firstdate = format.format(c1.getTime());
			Date firstdate2 = format.parse(firstdate);
			Date seconddate = format.parse(vo2.getPj_ddate());

			long caldday = seconddate.getTime() - firstdate2.getTime();
			long dday = caldday / (24 * 60 * 60 * 1000);
			if (dday > 0) {
				vo2.setPj_dday("" + dday);
				vo2.setPj_progress("now");
				int res10 = mypagedao.update_pj_progress(vo2);
			} else {
				vo2.setPj_dday("Past Project");
				vo2.setPj_progress("past");
				int res11 = mypagedao.update_pj_progress(vo2);
			} // if
		} // for

		int max_pj = 2;
		// 더보기 기능을 위한..
		if (project_list.size() >= 2) {
			max_pj = 2; // 보여주는 프로젝트 최대 max_pj+1개
		} else {
			max_pj = project_list.size();
		}

		model.addAttribute("p_list", project_list);
		model.addAttribute("max_pj", max_pj);

		// DB에서 ToDo 목록 가져오기 +바인딩
		List<MyPage_MemoBoardVO> todo_list = mypagedao.selecttodoList(m_idx);
		
		for (int i = 0; i < todo_list.size(); i++) {
			MyPage_MemoBoardVO vo3 = todo_list.get(i);
			MyPage_ProjectVO pj_vo = mypagedao.selectpjnameone(vo3.getPj_idx());
			vo3.setPj_name(pj_vo.getPj_name());
			vo3.setB_content((vo3.getB_content().replaceAll("<br>", "\n")));
		} // for

		int max_todo = 3;
		// 더보기 기능을 위한..
		if (todo_list.size() >= 3) {
			max_todo = 3; 
		} else {
			max_todo = todo_list.size();
		}
		
		model.addAttribute("todo_list", todo_list);
		model.addAttribute("max_todo", max_todo);
		
		return Common.MyPage.VIEW_PATH + "mypage.jsp";
	}

	// 플젝 생성
	@RequestMapping(value = "/pj_create.do", method = RequestMethod.POST)
	@ResponseBody
	public String pj_create(HttpServletRequest request, MyPage_ProjectVO vo, Model model) throws Exception {

		HttpSession session = request.getSession();
		String m_idx2= String.valueOf(session.getAttribute("m_idx"));
		int m_idx= Integer.parseInt(m_idx2);

		// pj_contents디코딩
		String pj_contents = request.getParameter("pj_contents").replaceAll("\n", "<br>");
		String pj_ddate = request.getParameter("pj_ddate").trim();
		vo.setPj_name(request.getParameter("pj_name"));
		vo.setPj_open(request.getParameter("pj_open"));
		vo.setPj_sdate(request.getParameter("pj_sdate"));
		vo.setPj_ddate(pj_ddate);
		vo.setPj_contents(pj_contents);
		// 위의 정보를 DB에 기록 및 플젝생성
		int res = mypagedao.pj_insert(vo);

		// 그룹 동시에 생성
		res = mypagedao.g_insert(m_idx);

		if (res > 0) {
			return "success";
		} else {
			return "fail";
		}

	}

	// 더보기 버튼 구현
	@RequestMapping(value = "/pj_more.do", method = RequestMethod.POST)
	public String pj_more(HttpServletRequest request, Model model) throws Exception {

		HttpSession session = request.getSession();
		String m_idx2= String.valueOf(session.getAttribute("m_idx"));
		int m_idx= Integer.parseInt(m_idx2);
		MyPage_MemberVO m_inf;
		m_inf = mypagedao.selectOne(m_idx);
		String phone = m_inf.getM_phone().substring(0, 3)+'-'+m_inf.getM_phone().substring(3, 7)+'-'+m_inf.getM_phone().substring(7, 11);
		m_inf.setM_phone(phone);
		model.addAttribute("m_inf", m_inf);

		System.out.println("잘호출됏어");
		List<MyPage_ProjectVO2> project_list = mypagedao.selectpList(m_idx);

		for (int i = 0; i < project_list.size(); i++) {
			// pj_contents인코딩
			MyPage_ProjectVO2 vo2 = project_list.get(i);
			vo2.setPj_contents(vo2.getPj_contents().replaceAll("<br>", "\n"));

			// pj_leader삽입
			String pj_leader = mypagedao.select_pj_leader(vo2.getPj_idx());
			vo2.setPj_leader(pj_leader);

			// d-day 삽입 및 progress 삽입
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Calendar c1 = Calendar.getInstance();
			String firstdate = format.format(c1.getTime());
			Date firstdate2 = format.parse(firstdate);
			Date seconddate = format.parse(vo2.getPj_ddate());

			long caldday = seconddate.getTime() - firstdate2.getTime();
			long dday = caldday / (24 * 60 * 60 * 1000);
			if (dday > 0) {
				vo2.setPj_dday("" + dday);
				vo2.setPj_progress("now");
				int res10 = mypagedao.update_pj_progress(vo2);
			} else {
				vo2.setPj_dday("Past Project");
				vo2.setPj_progress("past");
				int res11 = mypagedao.update_pj_progress(vo2);
			} // if
		} // for

		model.addAttribute("p_list", project_list);

		return Common.MyPage.VIEW_PATH + "mypage_more.jsp";
	}

	@RequestMapping(value = "/pj_filter.do", method = RequestMethod.POST)
	public String pj_select(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		String m_idx2= String.valueOf(session.getAttribute("m_idx"));
		int m_idx= Integer.parseInt(m_idx2);
		MyPage_MemberVO m_inf;
		m_inf = mypagedao.selectOne(m_idx);
		String phone = m_inf.getM_phone().substring(0, 3)+'-'+m_inf.getM_phone().substring(3, 7)+'-'+m_inf.getM_phone().substring(7, 11);
		m_inf.setM_phone(phone);
		model.addAttribute("m_inf", m_inf);

		System.out.println("잘호출됏어");
		List<MyPage_ProjectVO2> project_list;

		String select = request.getParameter("select").trim();

		if (select.equals("Now Projects")) {
			System.out.println("NOW");
			project_list = mypagedao.selectpList_now(m_idx);
		} else if (select.equals("Past Projects")) {
			System.out.println("PAST");
			project_list = mypagedao.selectpList_past(m_idx);
		} else {
			System.out.println("ALL");
			project_list = mypagedao.selectpList(m_idx);
		}

		for (int i = 0; i < project_list.size(); i++) {
			// pj_contents인코딩
			MyPage_ProjectVO2 vo2 = project_list.get(i);
			vo2.setPj_contents(vo2.getPj_contents().replaceAll("<br>", "\n"));

			// pj_leader삽입
			String pj_leader = mypagedao.select_pj_leader(vo2.getPj_idx());
			vo2.setPj_leader(pj_leader);

			// d-day 삽입 및 progress 삽입
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Calendar c1 = Calendar.getInstance();
			String firstdate = format.format(c1.getTime());
			Date firstdate2 = format.parse(firstdate);
			Date seconddate = format.parse(vo2.getPj_ddate());

			long caldday = seconddate.getTime() - firstdate2.getTime();
			long dday = caldday / (24 * 60 * 60 * 1000);
			if (dday > 0) {
				vo2.setPj_dday("" + dday);
				vo2.setPj_progress("now");
				int res10 = mypagedao.update_pj_progress(vo2);
			} else {
				vo2.setPj_dday("Past Project");
				vo2.setPj_progress("past");
				int res11 = mypagedao.update_pj_progress(vo2);
			} // if
		} // for

		model.addAttribute("p_list", project_list);

		return Common.MyPage.VIEW_PATH + "mypage_more.jsp";
	}

	// 프로젝트 삭제
	@RequestMapping(value = "pj_delete.do", method = RequestMethod.POST)
	@ResponseBody
	public String pj_delete(int pj_idx) {

		int res = mypagedao.pj_delete(pj_idx);
		String result = "no";// 삭제실패시

		if (res != 0) {
			result = "yes";// 삭제성공시
		}

		return result;
	}

	// 프로젝트 탈퇴
	@RequestMapping(value = "pj_out.do", method = RequestMethod.POST)
	@ResponseBody
	public String pj_out(MyPage_GroupVO vo) {

		vo.setG_leader(-1);// 임시값
		vo.setG_leader(-1);// 임시값

		int res = mypagedao.pj_out(vo);
		String result = "no";// 탈퇴실패시

		if (res != 0) {
			result = "yes";// 탈퇴성공시
		}

		return result;
	}

	// 플젝 수정
	@RequestMapping(value = "/pj_update.do", method = RequestMethod.POST)
	@ResponseBody
	public String pj_update(HttpServletRequest request, MyPage_ProjectVO vo, Model model) throws Exception {
		HttpSession session = request.getSession();
		String m_idx2= String.valueOf(session.getAttribute("m_idx"));
		int m_idx= Integer.parseInt(m_idx2);
		// pj_contents디코딩
		String pj_contents = request.getParameter("pj_contents").replaceAll("\n", "<br>");
		String pj_ddate = request.getParameter("pj_ddate").trim();
		vo.setPj_idx(Integer.parseInt(request.getParameter("pj_idx")));
		vo.setPj_name(request.getParameter("pj_name"));
		vo.setPj_open(request.getParameter("pj_open"));
		vo.setPj_sdate(request.getParameter("pj_sdate"));
		vo.setPj_ddate(pj_ddate);
		vo.setPj_contents(pj_contents);
		// 위의 정보를 DB에 수정
		int res = mypagedao.pj_update(vo);

		if (res > 0) {
			return "success";
		} else {
			return "fail";
		}

	}

	// 그룹 멤버 목록 받아오기
	@RequestMapping(value = "/pj_group.do", method = RequestMethod.POST)
	public String pj_group(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		String m_idx2= String.valueOf(session.getAttribute("m_idx"));
		int m_idx= Integer.parseInt(m_idx2);
		int pj_idx = Integer.parseInt(request.getParameter("pj_idx"));
		List<MyPage_GroupVO2> g_list = mypagedao.selectgList(pj_idx);
		System.out.println("그룹 잘들고왔어");

		for (int i = 0; i < g_list.size(); i++) {
			// pj_contents인코딩
			MyPage_GroupVO2 g_vo = g_list.get(i);
			MyPage_MemberVO m_vo = mypagedao.selectOne(g_vo.getM_idx());
			g_vo.setM_email(m_vo.getM_email());
			g_vo.setM_nick(m_vo.getM_nick());
			g_list.set(i, g_vo);
		} // for

		model.addAttribute("g_list", g_list);

		return Common.MyPage.VIEW_PATH + "mypage_group.jsp";
	}

	@RequestMapping(value = "/g_search.do", method = RequestMethod.POST)
	public String g_search(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		String m_idx2= String.valueOf(session.getAttribute("m_idx"));
		int m_idx= Integer.parseInt(m_idx2);
		System.out.println("잘 검색했어");
		System.out.println(request.getParameter("m_email"));
		MyPage_MemberVO m_vo = mypagedao.selectmOne(request.getParameter("m_email"));

		System.out.println(m_vo.getM_nick());
		model.addAttribute("search_vo", m_vo);
		return Common.MyPage.VIEW_PATH + "mypage_search.jsp";
	}

	// 그룹 초대테이블 수정
	@RequestMapping(value = "/g_invite.do", method = RequestMethod.POST)
	@ResponseBody
	public String g_invite(HttpServletRequest request, Model model, MyPage_InviteVO vo) throws Exception {
		HttpSession session = request.getSession();
		String m_idx2= String.valueOf(session.getAttribute("m_idx"));
		int m_idx= Integer.parseInt(m_idx2);
		int send_m_idx = Integer.parseInt(request.getParameter("send_m_idx"));
		int pj_idx = Integer.parseInt(request.getParameter("pj_idx"));
		String[] recieve_m_idx_list = request.getParameterValues("invite_arr[]");
		List<MyPage_GroupVO2> g_list = mypagedao.selectgList(pj_idx);
		List<MyPage_InviteVO> in_list =mypagedao.selectinList(pj_idx);
		//이미 그룹에 있는지 여부 검사
		String res = "success";
		for (int i = 0; i < recieve_m_idx_list.length; i++) {
			for(int j=0; j<g_list.size();j++) {
				if(g_list.get(j).getM_idx()== Integer.parseInt(recieve_m_idx_list[i])) {
					res="overlap";
					break;
				}
			}
		}
		
		for (int i = 0; i < recieve_m_idx_list.length; i++) {
			for(int j=0; j<in_list.size();j++) {
				if(in_list.get(j).getRecieve_m_idx()== Integer.parseInt(recieve_m_idx_list[i])) {
					res="overlap_invite";
					break;
				}
			}
		}	
		
		if(res=="success") {
			for (int i = 0; i < recieve_m_idx_list.length; i++) {
				vo.setSend_m_idx(send_m_idx);
				vo.setPj_idx(pj_idx);
				vo.setRecieve_m_idx(Integer.parseInt(recieve_m_idx_list[i]));
				System.out.println(vo.getRecieve_m_idx()+"내가보내는사람");
				mypagedao.in_insert(vo);
				mypagedao.in_update(Integer.parseInt(recieve_m_idx_list[i]));
			}	
		}
			

		return res;

	}
	
	// 그룹 초대테이블 수정
		@RequestMapping(value = "/g_update.do", method = RequestMethod.POST)
		@ResponseBody
		public String g_update(HttpServletRequest request, Model model, MyPage_GroupVO vo) throws Exception {
			HttpSession session = request.getSession();
			String m_idx2= String.valueOf(session.getAttribute("m_idx"));
			int m_idx= Integer.parseInt(m_idx2);
			int g_leader = Integer.parseInt(request.getParameter("g_leader"));
			int pj_idx = Integer.parseInt(request.getParameter("pj_idx"));
			String[] g_delete_m_idx_list = request.getParameterValues("g_update_arr[]");
			if( g_delete_m_idx_list != null) {	
				for (int i = 0; i < g_delete_m_idx_list.length; i++) {
					vo.setM_idx((Integer.parseInt(g_delete_m_idx_list[i])));
					vo.setG_leader(g_leader);
					vo.setPj_idx(pj_idx);
					mypagedao.g_update(vo);
					mypagedao.g_leader_update(vo);
				}
			} else {
				mypagedao.g_leader_update(vo);
			}
			String res ="success";

			return res;
		}
		
		
		
		
		// todo더보기 버튼 구현
		@RequestMapping(value = "/todo_more.do", method = RequestMethod.POST)
		public String todo_more(HttpServletRequest request, Model model) throws Exception {
			HttpSession session = request.getSession();
			String m_idx2= String.valueOf(session.getAttribute("m_idx"));
			int m_idx= Integer.parseInt(m_idx2);
			MyPage_MemberVO m_inf;
			m_inf = mypagedao.selectOne(m_idx);
			String phone = m_inf.getM_phone().substring(0, 3)+'-'+m_inf.getM_phone().substring(3, 7)+'-'+m_inf.getM_phone().substring(7, 11);
			m_inf.setM_phone(phone);
			model.addAttribute("m_inf", m_inf);
			
			
			// DB에서 ToDo 목록 가져오기 +바인딩
			List<MyPage_MemoBoardVO> todo_list = mypagedao.selecttodoList(m_idx);
			
			for (int i = 0; i < todo_list.size(); i++) {
				MyPage_MemoBoardVO vo3 = todo_list.get(i);
				MyPage_ProjectVO pj_vo = mypagedao.selectpjnameone(vo3.getPj_idx());
				vo3.setPj_name(pj_vo.getPj_name());
				vo3.setB_content((vo3.getB_content().replaceAll("<br>", "\n")));
			} // for

			
			model.addAttribute("todo_list", todo_list);


			return Common.MyPage.VIEW_PATH + "mypage_todomore.jsp";
		}
		


		@RequestMapping(value = "/do_filter.do", method = RequestMethod.POST)
		public String do_select(HttpServletRequest request, Model model) throws Exception {
			HttpSession session = request.getSession();
			String m_idx2= String.valueOf(session.getAttribute("m_idx"));
			int m_idx= Integer.parseInt(m_idx2);
			MyPage_MemberVO m_inf;
			m_inf = mypagedao.selectOne(m_idx);
			String phone = m_inf.getM_phone().substring(0, 3)+'-'+m_inf.getM_phone().substring(3, 7)+'-'+m_inf.getM_phone().substring(7, 11);
			m_inf.setM_phone(phone);
			model.addAttribute("m_inf", m_inf);

			System.out.println("잘호출됏어");
			List<MyPage_MemoBoardVO> do_list;

			String select = request.getParameter("select").trim();
			System.out.println(m_idx);
			if (select.equals("To Do")) {
				System.out.println("To Do");
				do_list = mypagedao.selecttodoList(m_idx);
				for (int i = 0; i < do_list.size(); i++) {
					MyPage_MemoBoardVO vo3 = do_list.get(i);
					MyPage_ProjectVO pj_vo = mypagedao.selectpjnameone(vo3.getPj_idx());
					vo3.setPj_name(pj_vo.getPj_name());
					vo3.setB_content((vo3.getB_content().replaceAll("<br>", "\n")));
				}
			} else if (select.equals("Doing")) {
				System.out.println("Doing");
				do_list = mypagedao.selectdoingList(m_idx);
				for (int i = 0; i < do_list.size(); i++) {
					MyPage_MemoBoardVO vo3 = do_list.get(i);
					MyPage_ProjectVO pj_vo = mypagedao.selectpjnameone(vo3.getPj_idx());
					vo3.setPj_name(pj_vo.getPj_name());
					vo3.setB_content((vo3.getB_content().replaceAll("<br>", "\n")));
				}
			} else {
				System.out.println("Done");
				do_list = mypagedao.selectdoneList(m_idx);
				for (int i = 0; i < do_list.size(); i++) {
					MyPage_MemoBoardVO vo3 = do_list.get(i);
					MyPage_ProjectVO pj_vo = mypagedao.selectpjnameone(vo3.getPj_idx());
					vo3.setPj_name(pj_vo.getPj_name());
					vo3.setB_content((vo3.getB_content().replaceAll("<br>", "\n")));
				}
			}


			model.addAttribute("todo_list", do_list);

			return Common.MyPage.VIEW_PATH + "mypage_doselect.jsp";
		}
		
		
		
}


