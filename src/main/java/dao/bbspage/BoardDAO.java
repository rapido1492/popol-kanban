package dao.bbspage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.bbspage.BoardReplyVO;
import vo.bbspage.BoardVO;
import vo.bbspage.InviteVO;
import vo.mainpage.DirectoryVO;
import vo.sign.signupVO;

public class BoardDAO {
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		System.out.println("bbspageDAO 생성자 생성");
		this.sqlSession = sqlSession;
	}

	//전체 게시물 조회
	public List<BoardVO> select_boardList(int m_idx) {
		List<BoardVO> list = null;
		list = sqlSession.selectList("board.board_list", m_idx);
		return list;	
	}
	
	//글 등록
	public int insert(Map map) {
		int res = sqlSession.insert("board.board_insert",map);
		return res;
	}
		
	//댓글 등록
	public int coinsert(BoardReplyVO vo) {
		int res = sqlSession.insert("board.board_coinsert",vo);
		return res;
	}
	
	//댓글 목록 불러오기
	public List<BoardReplyVO> replyselectList(int b_idx) {
		List<BoardReplyVO> list = null;
		list = sqlSession.selectList("board.board_replylist", b_idx);
		return list;	
	}
	
	//클릭한 게시글 한건 조회하기
	public BoardVO selectOne(int b_idx) {
		BoardVO vo = null;
		vo = sqlSession.selectOne("board.board_one",b_idx);
		return vo;
	}
	
	//조회수 증가
	public int update_readhit(int b_idx) {
		int res = sqlSession.update("board.update_readhit",b_idx);
		return res;
	}
	
	//기준글의 step+1 하기
	public int update_step(BoardVO baseVO) {
		int res = sqlSession.update("board.board_update_step", baseVO);
		return res;
	}
	
//	//답글달기
//	public int reply(BoardVO vo){
//		int res = sqlSession.insert("board.board_reply",vo);
//		return res;
//	}
	
	//삭제할 게시글 번호
	public BoardVO deleteOne(int b_idx) {
		BoardVO vo = null;
		vo = sqlSession.selectOne("board.board_idx",b_idx);
		return vo;
	}
	
	//글 삭제 전 유저가 리더인지 체크
	public int userSearch(int m_idx) {
		Integer res = 0;
		res = sqlSession.selectOne("board.board_leaderSearch", m_idx);
		return res;
	}
	//글 삭제
	public int del_update(int b_idx) {
		int res = 0;
		res = sqlSession.update("board.board_del_update", b_idx);
		return res;
	}
	
	//페이징을 포함한 조건별 검색
	public List<BoardVO> selectList(Map map) {
		List<BoardVO> list = null;
		list = sqlSession.selectList("board.board_list_condition", map);
		return list;	
	}
	
	//전체 게시물 갯수
	public int getRowTotal() {
		int count = sqlSession.selectOne("board.board_count");
		return count;
	}
	
	// 글 수정
	public int modify_update( BoardVO vo ) {
		int res = 0;
		res = sqlSession.update("board.board_modifyupdate", vo);
		return res;
	}
	
	//파일TB에 넣기
	public int directoryinsert(Map map) {
		int res = 0;
		res = sqlSession.insert("board.directory_insert", map);
		return res;
	}
	//파일TB 조회
	public DirectoryVO directory_search(int b_idx) {
		DirectoryVO vores = null;
		vores = sqlSession.selectOne("board.directory_search", b_idx + 1);
		return vores;
	}
	//invite_result 조회
	public String invite_search(int m_idx) {
		String res = null;
		res = sqlSession.selectOne("board.invite_search", m_idx);
		return res;
	}

	//invite_flag가 false일 경우 invite flag wait로 업데이트
	public int inviteflag_update(int m_idx) {
		int res = 0;
		res = sqlSession.update("board.inviteflag_update", m_idx);
		return res;
	}
	
	//초대 수락 시 invite_flag 다시 false로 변경
	public int invite_accept(int m_idx) {
		int res = 0;
		res = sqlSession.update("board.invite_accept", m_idx);
		return res;
	}
	
	//유저 프로필 사진 조회
	public String profile_search(int m_idx) {
		String res = null;
		res = sqlSession.selectOne("profile_search",m_idx);
		System.out.println("유저 프로필 사진:"+res);
		return res;
	}
	//유저 닉네임 조회
	public String userNickname(int m_idx) {
		String res = null;
		res = sqlSession.selectOne("userNickname", m_idx);
		return res;
	}
	
	public int modify_filename(int b_idx, String file_name) {
		Map map = new HashMap();
		map.put("b_idx", b_idx);
		map.put("file_name", file_name);
		
		int res = sqlSession.update("board.directory_update", map);
		return res;
	}
	
	//inviteTB조회
	public InviteVO invite_search_TB(int m_idx) {
		InviteVO vores = null;
		vores = sqlSession.selectOne("invite_alert", m_idx);
		return vores;
	}
	
	//projectName 조회
	public String project_search(int pj_idx) {
		String res = null;
		res = sqlSession.selectOne("project_search", pj_idx);
		return res;
	}
}