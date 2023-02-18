package front.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import front.dto.CommentDto;

@Repository
public class BoardDao{

	@Autowired
	private SqlSession sqlSession;
	
	//게시판 목록 조회
	public List<Map<String,Object>> selectBoardList(Map<String,String> parameterMap) {
		return sqlSession.selectList("BoardMapper.selectBoardList",parameterMap);
	}
	
	//글 작성
	public int write(Map<String,String> parameterMap) {
		return sqlSession.insert("BoardMapper.write",parameterMap);
	}
	
	//글 수정
	public int update(Map<String,String> parameterMap) {
		return sqlSession.insert("BoardMapper.update",parameterMap);
	}
	
	//게시판 조회
	public Map<String,String> getBoardDetail(HashMap<String,String> paramMap) {
		return sqlSession.selectOne("BoardMapper.getBoardDetail",paramMap);
	}

	//댓글 작성
	public int insertComment(CommentDto commentDto) {
		return sqlSession.insert("BoardMapper.insertComment",commentDto);
	}
	
	//댓글 리스트 조회
	public List<Map<String,Object>> selectCommentList(CommentDto commentDto) {
		return sqlSession.selectList("BoardMapper.selectCommentList",commentDto);
	}
}
