package front.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import front.dto.BrandDto;

@Repository
public class ShoppingDao{

	@Autowired
	private SqlSession sqlSession;
	
	//브랜드 목록 조회
	public List<Map<String,Object>> selectBrandList(Map<String,String> parameterMap) {
		return sqlSession.selectList("ShoppingMapper.selectBrandList",parameterMap);
	}

	//브랜드 이미지 추가
	public int insertBrandImage(Map<String, Object> brandImage) {
		return sqlSession.insert("ShoppingMapper.insertBrandImage", brandImage);
	}

	//브랜드 추가
	public int insertBrand(HashMap<String,String> parameterMap) {
		return sqlSession.insert("ShoppingMapper.insertBrand", parameterMap);
	}
	
	//브랜드 조회
	public List<Map<String,String>> findBrand(String brandId) {
		return sqlSession.selectList("ShoppingMapper.findBrand", brandId);
	}
	
	//브랜드 수정
	public int updateBrand(BrandDto brandDto) {
		return sqlSession.update("ShoppingMapper.updateBrand", brandDto);
	}
	
	//브랜드 이미지 수정
	public int deleteBrandImage(HashMap<String,Object> parameterMap) {
		return sqlSession.delete("ShoppingMapper.deleteBrandImage", parameterMap);
	}
}
