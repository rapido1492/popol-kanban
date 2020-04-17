package dao.mainpage;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.mainpage.DirectoryVO;

public class DirectoryDAO {
	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		System.out.println("Directory 생성자 생성");
		this.sqlSession = sqlSession;
	}

	public int insert(DirectoryVO vo) {

		int res = 0;
		res = sqlSession.insert("main.dir_insert", vo);

		return res;
	}

	// 전체 조회
	public List<DirectoryVO> selectList(){

		List<DirectoryVO> list = null;
		list = sqlSession.selectList("main.dir_list");

		return list;
	}
	
	// 부분 조회
	public List<DirectoryVO> wordSelect(String search){

		List<DirectoryVO> list = null;
		list = sqlSession.selectList("main.dir_word_list", search);

		return list;
	}
	
	// 파일 삭제
	public int delete( int[] file_idx ) {
		
		HashMap hm = new HashMap();
		hm.put("file_idx", file_idx);

		int res = sqlSession.delete("main.dir_delete", hm);
		
		return res;
	}


}













