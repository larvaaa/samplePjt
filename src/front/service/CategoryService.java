package front.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import front.dao.CategoryDao;
import front.dto.CategoryDto;

@Service
public class CategoryService {

	private CategoryDao categoryDao;
	
	@Autowired
	public CategoryService(CategoryDao categoryDao) {
		this.categoryDao = categoryDao;
	}
	
	//카테고리 등록
	public int insertCategory(CategoryDto categoryDto) {
		return categoryDao.insertCategory(categoryDto);
	}
	
	//상위 카테고리 조회
	public List<CategoryDto> selectParent(int depth) {
		return categoryDao.selectParent(depth);
	}
	
	//카테고리 목록 조회
	public List<CategoryDto> selectCateList() {
		return categoryDao.selectCateList();
	}
}
