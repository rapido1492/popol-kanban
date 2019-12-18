package controller.mypage;


import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import common.Common;
import dao.mypage.MyPageDAO;
import vo.mypage.MyPage_MemberVO;
import vo.mypage.MyPage_ProjectVO;


@Controller
public class MyPageController {
	MyPageDAO mypagedao;

	public MyPageController() {
	}

	public MyPageController(MyPageDAO mypagedao) {
		this.mypagedao = mypagedao;
	}

	@RequestMapping(value = {"/", "/mypage.do"})
	public String show(Model model, HttpServletRequest request) {
		/*
		 * int m_idx = -1; //로그인 확인 안돼있으면 -1 Cookie[] cookies = request.getCookies();
		 * for (Cookie cookie : cookies) { if("login_true".equals(cookie.getName())) {
		 * m_idx = Integer.parseInt(cookie.getValue()); } else { m_idx = -1;} }
		 */
		//쿠키에서 로그인여부 확인 + 로그인된 회원 m_idx 받음
		//로그인회원정보 가져오기 + 바인딩
		
	
		 int m_idx= 1; //임시로 로그인한 멤버idx=1
		 
		 MyPage_MemberVO m_inf;
		 
		 if(m_idx>=0) {
		 m_inf = mypagedao.selectOne(m_idx); } 
		 else { return "redirect:login.do";}
		 //로그인페이지로 다시 돌려보내기 }
		 
		 model.addAttribute("m_inf", m_inf);
	 
		 //DB에서 project 목록 가져오기 List<MyPage_ProjectVO> project_list =
		 //mypagedao.selectpList(m_idx);
		 
		// model.addAttribute("p_list", project_list);

		
		
		
		//DB에서 ToDo 목록 가져오기 +바인딩

		//List<MyPage_ProjectVO> todo_list = mypagedao.selectdList(m_idx);


		return Common.MyPage.VIEW_PATH + "mypage.jsp";
	}
	
	@RequestMapping(value = "/pj_create.do", method=RequestMethod.POST)
	@ResponseBody
	public String pj_create(HttpServletRequest request, MyPage_ProjectVO vo) throws Exception {
		vo.setPj_name(request.getParameter("pj_name"));
		vo.setPj_open(request.getParameter("pj_open"));
		vo.setPj_sdate(request.getParameter("pj_sdate"));
		vo.setPj_ddate(request.getParameter("pj_ddate"));
		vo.setPj_contents(request.getParameter("pj_contents"));
		//위의 정보를 DB에 기록
		int res = mypagedao.pj_insert(vo);
		if(res>0) {
			return "success";
		} else {
			return "fail";
		}
		
	}
	
	
	
	
	
	
	
	
	

}














