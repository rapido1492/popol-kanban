package controller.signup;

import java.io.File;
import java.util.HashMap;
import java.util.Map;
 
//import javax.jws.WebParam.Mode;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import common.Common;
import dao.signup.SignUpDAO;
import vo.sign.signupVO;
@Controller
public class SignUpController {
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
	
	
	@RequestMapping("/signup_form.do")
	public String signup_form() {
		
		System.out.println( org.springframework.core.SpringVersion.getVersion() ); 
		return Common.signupPage.VIEW_PATH + "signup.jsp";
		
	}
	
	@RequestMapping("/signchange_form.do")
	public String signchange_form(int m_idx, Model model) {
		
		System.out.println(m_idx);
		
		signupVO vo = signupdao.sign(m_idx);
		
		model.addAttribute("vo", vo);
		
		System.out.println( org.springframework.core.SpringVersion.getVersion() ); 
		return Common.signupPage.VIEW_PATH + "signchange.jsp";
		
	}
	@RequestMapping("/pwdsearch_form.do")
	public String pwd_search() {
		
		System.out.println( org.springframework.core.SpringVersion.getVersion() ); 
		return Common.signupPage.VIEW_PATH + "pwd_search.jsp";
		
	}
	
	@RequestMapping("/signup_insert.do")
	public String signup_insert(signupVO vo) {
		
		System.out.println(vo.getPhoto().getOriginalFilename());
		
		if(!vo.getPhoto().isEmpty()) {
			
			vo.setM_photo(photosave(vo.getPhoto()));
			
		}
		else if(vo.getPhoto().isEmpty()){
			
			vo.setM_photo("빈값");
			
		}
		
		int res = signupdao.signup(vo);
		
		return "/login_form.do";
		
	}
	
	@RequestMapping("/signchange.do")
	public String signchange(signupVO vo) {
		
		String inphoto = signupdao.select_photo(vo.getM_idx());
		
		System.out.println(inphoto);

		if(!vo.getPhoto().isEmpty() ) {
			
			vo.setM_photo(photosave(vo.getPhoto()));
			
		}
		
		
		else if( vo.getPhoto().isEmpty()) {
			vo.setM_photo(inphoto);
		}
		
		int res = signupdao.signchange(vo);
		
		return common.Common.loginPage.VIEW_PATH + "/logintestform.jsp";
		
	}
	
	@RequestMapping("/email_search.do")
	@ResponseBody
	public String email_search(String m_email) {
		
		String result = "no";
		
		String res = signupdao.email_search(m_email);
		
		if(res != null) {
			
			result = "yes";			
		}
		
		return result;
	}
	
	@RequestMapping("/pwd_change.do")
	public String pwd_change(String m_email, String m_pwd) {
		
		System.out.println(m_email + m_pwd);
		
		int res = signupdao.pwd_change(m_email, m_pwd);
		
		return "/login_form.do";
	}
	
	public String photosave( MultipartFile multipartfile ) {

		String webPath = "/resources/upload/";
		
		System.out.println(webPath);
		
		String savePath = application.getRealPath(webPath);
		System.out.println(savePath);
		
		//사용자가 업로드한 파일 정보
		MultipartFile photo = multipartfile ;
		
		String filename = "no_file";
		
		if( !photo.isEmpty() ) {
			//업로드 실제 파일명
			filename = photo.getOriginalFilename();
			
			//저장할 파일의 경로
			File saveFile = new File(savePath, filename);
			
			if(!saveFile.exists()) {
				//저장할 경로가 존재하지 않을 시, 새로운 폴더 생성.
				saveFile.mkdirs();	
			}else {
				//동일 파일명 방지하기 위해 현재 업로드 시간을 붙여서 중복을 방지한다.
				long time = System.currentTimeMillis();
				filename = String.format("%d_%s", time, filename);
				saveFile = new File(savePath, filename);
			}
			
			try {
				//업로드를 요청받은 파일은 multipartResolver클래스가 저장한 임시 저장소에 있는데,
				//임시 저장소에 있는 파일은 일정 시간이 지나면 사라지므로, 
				//내가 지정해놓은 경로로 복사를 해둔다.
				photo.transferTo(saveFile);
			} catch (Exception e) {
				e.printStackTrace();
			}
	}
		return filename;
	}
}

