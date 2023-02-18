package front.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import front.dto.CategoryDto;

@Repository
public class CategoryDao {

	private SqlSession sqlSession;
	
	@Autowired
	public CategoryDao(SqlSession sqlSessoin) {
		this.sqlSession = sqlSessoin;
	}
	
	//카테고리 등록
	public int insertCategory(CategoryDto categoryDto) {
		return sqlSession.insert("CategoryMapper.insertCategory",categoryDto);
	}
	
	//상위 카테고리 조회
	public List<CategoryDto> selectParent(int depth) {
		return sqlSession.selectList("CategoryMapper.selectParent",depth);
	}
	
	//카테고리 목록 조회
	public List<CategoryDto> selectCateList() {
		return sqlSession.selectList("CategoryMapper.selectCateList");
	}
	
}
