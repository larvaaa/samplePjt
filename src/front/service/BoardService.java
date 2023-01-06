package front.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import front.dao.BoardDao;

@Service
public class BoardService {
	
	@Autowired
	private BoardDao boardDao;
	
	
	//글 작성
	public int write(Map<String,String> parameterMap) {
		
		int result = boardDao.write(parameterMap);
		return result;
		
	}
	
	//글 .수정
	public int update(Map<String,String> parameterMap) {
		
		int result = boardDao.update(parameterMap);
		return result;
		
	}
	
	//게시판 목록 조회
	public List<Map<String,Object>> selectBoardList(Map<String,String> parameterMap) {
		
		int pageNum = Integer.parseInt(parameterMap.getOrDefault("pageNum", "1"));
		int startNum = pageNum*10 - 9;
		int endNum = pageNum*10;
		
		parameterMap.put("start_num", String.valueOf(startNum));
		parameterMap.put("end_num", String.valueOf(endNum));
		
		List<Map<String,Object>> resultList = boardDao.selectBoardList(parameterMap);
		
		//리스트 조회 결과가 없을 경우 마지막 페이지 조회
//		if(resultList.size() <= 0) 
		return boardDao.selectBoardList(parameterMap);
	}
	
	//게시판 목록 조회
	public Map<String,String> getBoardDetail(HashMap<String,String> paramMap) {
		return boardDao.getBoardDetail(paramMap);
	}
	
}
