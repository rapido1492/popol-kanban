package dao.mypage;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.mypage.MyPage_GroupVO;
import vo.mypage.MyPage_GroupVO2;
import vo.mypage.MyPage_InviteVO;
import vo.mypage.MyPage_MemberVO;
import vo.mypage.MyPage_MemoBoardVO;
import vo.mypage.MyPage_ProjectVO;
import vo.mypage.MyPage_ProjectVO2;

public class MyPageDAO {
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public MyPage_MemberVO selectOne(int m_idx){
		
		MyPage_MemberVO login_member;
		login_member = sqlSession.selectOne("myp.login_member", m_idx);
		return login_member;
		
	}
	
	public List<MyPage_ProjectVO2> selectpList(int m_idx){
		List<MyPage_ProjectVO2> p_list=null;
		p_list=sqlSession.selectList("myp.p_list", m_idx);		
		return p_list;
	}
	
	public List<MyPage_ProjectVO2> selectpList_now(int m_idx){
		List<MyPage_ProjectVO2> p_list=null;
		p_list=sqlSession.selectList("myp.p_list_now", m_idx);		
		return p_list;
	}
	
	public List<MyPage_ProjectVO2> selectpList_past(int m_idx){
		List<MyPage_ProjectVO2> p_list=null;
		p_list=sqlSession.selectList("myp.p_list_past", m_idx);		
		return p_list;
	}
	
	public int pj_insert(MyPage_ProjectVO vo) {
		int res = 0;
		res= sqlSession.insert("myp.pj_insert", vo);
		return res;
	}
	
	public int g_insert(int m_idx) {
		int res = 0;
		res= sqlSession.insert("myp.g_insert", m_idx);
		return res;
	}
	
	public int update_pj_progress(MyPage_ProjectVO2 vo2) {
		int res = 0;
		res =sqlSession.update("myp.pro_update", vo2);
		return res;
	}
	
	public String select_pj_leader(int pj_idx){
		String pj_leader= "";
		int g_leader=0;
		g_leader=(Integer) sqlSession.selectList("myp.g_leader", pj_idx).get(0);
		pj_leader=sqlSession.selectOne("myp.pj_leader", g_leader);
		return pj_leader;
	}
	
	public int pj_delete(int pj_idx){
		int res = 0;
		res =sqlSession.update("myp.pj_delete", pj_idx);
		return res;
	}
	
	public int pj_out(MyPage_GroupVO vo){
		int res = 0;
		res =sqlSession.delete("myp.pj_out", vo);
		return res;
	}

	public int pj_update(MyPage_ProjectVO vo3) {
		int res = 0;
		res= sqlSession.update("myp.pj_update", vo3);
		return res;
	}
	
	public List<MyPage_GroupVO2> selectgList(int pj_idx){
		List<MyPage_GroupVO2> g_list=null;
		g_list=sqlSession.selectList("myp.g_list", pj_idx);		
		return g_list;
	}
	
	public MyPage_MemberVO selectmOne(String m_email){
		MyPage_MemberVO m_vo=null;
		m_vo=sqlSession.selectOne("myp.m_one", m_email);		
		return m_vo;
	}
	
	public int in_insert(MyPage_InviteVO vo) {
		int res = 0;
		res= sqlSession.insert("myp.in_insert", vo);
		return res;
	}
	
	public int in_update(int recieve_m_idx) {
		int res = 0;
		res =sqlSession.update("myp.in_update", recieve_m_idx);
		return res;
	}
	
	public List<MyPage_InviteVO> selectinList(int pj_idx){
		List<MyPage_InviteVO> in_list=null;
		in_list=sqlSession.selectList("myp.in_list", pj_idx);		
		return in_list;
	}
	
	public int g_update(MyPage_GroupVO vo) {
		int res = 0;
		res= sqlSession.insert("myp.g_update", vo);
		return res;
	}
	
	public int g_leader_update(MyPage_GroupVO vo) {
		int res = 0;
		res= sqlSession.insert("myp.g_leader_update", vo);
		return res;
	}

	public List<MyPage_MemoBoardVO> selecttodoList(int m_idx){
		List<MyPage_MemoBoardVO> todo_list=null;
		todo_list = sqlSession.selectList("myp.todo_list", m_idx);		
		return todo_list;
	}
	
	public MyPage_ProjectVO selectpjnameone(int pj_idx){
		
		MyPage_ProjectVO vo;
		vo = sqlSession.selectOne("myp.pj_name", pj_idx);
		return vo;	
	}

	public List<MyPage_MemoBoardVO> selectdoingList(int m_idx){
		List<MyPage_MemoBoardVO> todo_list=null;
		todo_list = sqlSession.selectList("myp.doing_list", m_idx);		
		return todo_list;
	}
	
	public List<MyPage_MemoBoardVO> selectdoneList(int m_idx){
		List<MyPage_MemoBoardVO> todo_list=null;
		todo_list = sqlSession.selectList("myp.done_list", m_idx);		
		return todo_list;
	}
	
	
	
}













