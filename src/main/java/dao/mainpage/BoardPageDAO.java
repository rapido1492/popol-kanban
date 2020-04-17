package dao.mainpage;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.mainpage.BoardDivisionVO;
import vo.mainpage.BoardPageVO;
import vo.mainpage.GroupVO;

public class BoardPageDAO {
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		System.out.println("BoardPageDAO 생성자 생성");
		this.sqlSession = sqlSession;
	}
	
	// 팀 전체 리스트
	public List selectList(int pj_idx) {
		List<BoardPageVO> list =null;
		
		// 특정프로젝트(pj_idx)의 정보만 불러오기.
		list = sqlSession.selectList("main.board_list", pj_idx);
		
		return list;
	}
	
	// 내 리스트
	public List division_select(int m_idx) {
		List<BoardPageVO> list =null;
		m_idx=1;
		list = sqlSession.selectList("main.board_division_list", m_idx);
		
		return list;
	}

	// group 리스트
	public List selectGroupList(int pj_idx) {
		List<GroupVO> list =null;
		
		// 그룹테이블에서 특정프로젝트(pj_idx)의 정보만 불러오기.
		list = sqlSession.selectList("main.group_list", pj_idx);
		
		return list;
	}
	
	// 메모 등록
	public int insert(BoardPageVO vo) {
		int memo_seq = 0;
		// memo_seq 먼저 구해아한다.
		try {
			memo_seq = sqlSession.selectOne("main.board_memo_seq_select", vo);
			memo_seq += 1;
			
		} catch (Exception e) { 
			memo_seq = 0 ;
			// TODO: handle exception
		}	
			vo.setMemo_seq(memo_seq);
		System.out.println(vo.getMemo_seq());
		
		int res = sqlSession.insert("main.board_insert", vo);
		
		return res; 
	} 

	// 메모 변경
	public int memo_update(BoardPageVO vo) {
		System.out.println(vo.getB_content());//여기까지 잘 옴
		System.out.println(vo.getB_idx());
		int res = sqlSession.update("main.board_memo_update", vo);
		System.out.println("res : " + res);
		
		return res;
	}
	
	
	// 메모 삭제
	public int delete(int b_idx) {
		
		int res = sqlSession.delete("main.board_delete", b_idx);
		
		return res;
	}
	
	// ALL 메모 이동
	public int memo_move_update(BoardDivisionVO vo) {
		
		// 같은 보드 이동시 memo_seq를 0으로 만들어주는 작업을 거치고 난 이후 아래 보드들을 +1을 해주어야 한다.
		if(vo.getBoard_after_id() == vo.getBoard_before_id()) {
			int res3 = sqlSession.update("memo_move.board_zero_update", vo);
		}
		
		if(vo.getBoard_after_id() == vo.getBoard_before_id() && vo.getCard_after_index() > vo.getCard_before_index()) {
			int res = sqlSession.update("memo_move.board_plusseq0_update", vo);
		}else {
			int res6 = sqlSession.update("memo_move.board_plusseq_update", vo);
		}
		
		// 같은 보드 이동시.
		if(vo.getBoard_after_id() == vo.getBoard_before_id()) {
			int res2 = sqlSession.update("memo_move.board_minusseq_update", vo);
			int res4 = sqlSession.update("memo_move.board_move0_update", vo);
			
		}else {
			// 다른 보드 이동시.
			int res1 = sqlSession.update("memo_move.board_move_update", vo);
			int res2 = sqlSession.update("memo_move.board_minusseq_update", vo);
		}
		
		return 1;
	}
	
	
	
	// MINE 메모 이동
		public int mine_memo_move_update(BoardDivisionVO vo) { 
			
			
			if(vo.getDivision_after_id().equals(vo.getDivision_before_id())){
				System.out.println("같은곳 ");
				return 1;
			}else {
				
				int res = sqlSession.update("memo_move.mine_board_update", vo);
				System.out.println(res); 
			}
			
			return 1;
		}

}













