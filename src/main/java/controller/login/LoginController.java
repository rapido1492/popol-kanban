package controller.login;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import common.Common;
import dao.login.LoginDAO;
import vo.sign.signupVO;

@Controller
public class LoginController {
	LoginDAO logindao;
	
	public void setLogindao(LoginDAO logindao) {
		this.logindao = logindao;
	}

	@Autowired//자동 주입.(Spring으로 부터 application정보를 자동으로 받는다.)
	ServletContext application;
	
	@Autowired
	HttpSession session;
	
	@Autowired
	HttpServletRequest request;
	
	@RequestMapping(value = {"/", "/login_form.do"})
	public String login_form( Model model ) {
		System.out.println( org.springframework.core.SpringVersion.getVersion() ); 
		return Common.loginPage.VIEW_PATH + "login.jsp";
	}
	
	@RequestMapping("/login.do")
	public String login(String m_email, String m_pwd, Model model, HttpServletRequest request) {
		
		signupVO vo = logindao.login(m_email);
		
		String loginresultpath = "mypage.do";
		String loginerrer = null;
		
		
		if( vo == null ) {
			
			loginerrer = "id errer";
			loginresultpath = "login.jsp";
			model.addAttribute("loginerrer", loginerrer);
			
			return Common.loginPage.VIEW_PATH + loginresultpath;
			
		}
		if( !vo.getM_pwd().equals(m_pwd) ) {
			
			loginerrer = "pwd errer";
			loginresultpath = "login.jsp";
			model.addAttribute("loginerrer", loginerrer);
			
			return Common.loginPage.VIEW_PATH + loginresultpath;
			
		}
		
		 session.setAttribute("m_idx",vo.getM_idx());
		 session.setAttribute("m_photo", vo.getM_photo());
		 session.setAttribute("m_name", vo.getM_name());
		 session.setMaxInactiveInterval(600*60);

		return loginresultpath;
	}
	
	@RequestMapping("/logout.do")
	public String logout() {
		
		session.removeAttribute("m_idx");
		session.removeAttribute("m_photo");
		session.removeAttribute("m_name");
		
		return Common.loginPage.VIEW_PATH + "login.jsp";
	}
	
}
