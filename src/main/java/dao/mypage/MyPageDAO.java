package dao.mypage;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.mypage.MyPage_MemberVO;
import vo.mypage.MyPage_ProjectVO;

public class MyPageDAO {
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public MyPage_MemberVO selectOne(int m_idx){
		
		MyPage_MemberVO login_member;
		login_member = sqlSession.selectOne("mp.login_member", m_idx);
		return login_member;
		
	}
	
	public List<MyPage_ProjectVO> selectpList(int m_idx){
		List<MyPage_ProjectVO> p_list=null;
		p_list=sqlSession.selectList("mp.p_list", m_idx);		
		return p_list;
	}
	
	public int pj_insert(MyPage_ProjectVO vo) {
		int res = 0;
		res= sqlSession.insert("mp.pj_insert", vo);
		return res;
	}
	
	

}













