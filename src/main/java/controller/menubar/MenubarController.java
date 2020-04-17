package controller.menubar;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import dao.signup.SignUpDAO;

@Controller
public class MenubarController {

	SignUpDAO signupdao;

	public void setSignupdao(SignUpDAO signupdao) {
		this.signupdao = signupdao;
	}
	
	
	@Autowired//자동 주입.(Spring으로 부터 application정보를 자동으로 받는다.)
	ServletContext application;
	
	@Autowired
	HttpSession session;
	
	@Autowired
	HttpServletRequest request;
	
	@RequestMapping("/upmenubar.do")
	public String upmenubar(int m_idx, Model model) {
		
		String m_inviteflag = null;
		
		m_inviteflag = signupdao.inviteflagcheck(m_idx);
		
		model.addAttribute("m_inviterflag", m_inviteflag);
		
		return "/WEB-INF/views/menubar/upmenubar.jsp";
	}
}
