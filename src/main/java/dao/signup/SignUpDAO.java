package dao.signup;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.sign.signupVO;

public class SignUpDAO {
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		System.out.println("loginDAO 생성자 생성");
		this.sqlSession = sqlSession;
	}
	
	public int signup(signupVO vo) {
		
		int res = 0;
		
		res = sqlSession.insert("signup.signupinsert", vo);
		
		return res;
	}
	
	public String select_photo(int m_idx) {
		
		String photo = null;
		
		System.out.println(m_idx + "여긴 dao");
		
		photo = sqlSession.selectOne("signup.select_photo", m_idx);
		
		System.out.println(photo + "여긴 dao");
		
		return photo;
	}
	
	public int signchange(signupVO vo) {
		
		int res = 0;
		
		res = sqlSession.update("signup.signupdate", vo);
		
		return res;
	}
	
	public String email_search(String m_email) {
		
		String res = sqlSession.selectOne("signup.email_search", m_email);
		
		return res;
		
	}
	
	public int pwd_change(String m_email, String m_pwd) {
		
		int res = 0;
		
		Map map = new HashMap();
		
		map.put("m_email", m_email);
		map.put("m_pwd", m_pwd);
		
		res = sqlSession.update("signup.pwdchange", map);
		
		return res;
	}
	
	public signupVO sign(int m_idx) {
		
		signupVO vo = null;
		
		vo = sqlSession.selectOne("signup.sign",m_idx);
		
		return vo;
	}
	
	public String inviteflagcheck(int m_idx) {
		
		String m_inviteflagcheck = null;
		
		m_inviteflagcheck = sqlSession.selectOne("signup.inviteflag", m_idx);
		
		return m_inviteflagcheck;
	}
}
