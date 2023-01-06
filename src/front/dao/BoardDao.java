package front.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDao{

	@Autowired
	private SqlSession sqlSessoin;
	
	//게시판 목록 조회
	public List<Map<String,Object>> selectBoardList(Map<String,String> parameterMap) {
		return sqlSessoin.selectList("BoardMapper.selectBoardList",parameterMap);
	}
	
	//글 작성
	public int write(Map<String,String> parameterMap) {
		return sqlSessoin.insert("BoardMapper.write",parameterMap);
	}
	
	//글 수정
	public int update(Map<String,String> parameterMap) {
		return sqlSessoin.insert("BoardMapper.update",parameterMap);
	}
	
	//게시판 목록 조회
	public Map<String,String> getBoardDetail(HashMap<String,String> paramMap) {
		return sqlSessoin.selectOne("BoardMapper.getBoardDetail",paramMap);
	}
}
