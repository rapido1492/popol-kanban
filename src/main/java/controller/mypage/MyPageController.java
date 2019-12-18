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
		 * int m_idx = -1; //�α��� Ȯ�� �ȵ������� -1 Cookie[] cookies = request.getCookies();
		 * for (Cookie cookie : cookies) { if("login_true".equals(cookie.getName())) {
		 * m_idx = Integer.parseInt(cookie.getValue()); } else { m_idx = -1;} }
		 */
		//��Ű���� �α��ο��� Ȯ�� + �α��ε� ȸ�� m_idx ����
		//�α���ȸ������ �������� + ���ε�
		
	
		 int m_idx= 1; //�ӽ÷� �α����� ���idx=1
		 
		 MyPage_MemberVO m_inf;
		 
		 if(m_idx>=0) {
		 m_inf = mypagedao.selectOne(m_idx); } 
		 else { return "redirect:login.do";}
		 //�α����������� �ٽ� ���������� }
		 
		 model.addAttribute("m_inf", m_inf);
	 
		 //DB���� project ��� �������� List<MyPage_ProjectVO> project_list =
		 //mypagedao.selectpList(m_idx);
		 
		// model.addAttribute("p_list", project_list);

		
		
		
		//DB���� ToDo ��� �������� +���ε�

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
		//���� ������ DB�� ���
		int res = mypagedao.pj_insert(vo);
		if(res>0) {
			return "success";
		} else {
			return "fail";
		}
		
	}
	
	
	
	
	
	
	
	
	

}














