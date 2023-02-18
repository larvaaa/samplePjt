package front.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LoginDao{

	@Autowired
	private SqlSession sqlSession;
	
	public List<Map<String,Object>> getData() {
		return sqlSession.selectList("MainMapper.getData");
	}
	
	public HashMap<String,String> doLogin(HashMap<String,String> parameterMap) {
		
		HashMap<String,String> map = sqlSession.selectOne("LoginMapper.doLogin",parameterMap);
		
		return map;
	}
}
