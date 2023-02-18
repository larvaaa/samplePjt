package front.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import front.dto.CategoryDto;
import front.service.CategoryService;

@Controller
@RequestMapping(value="/shopping")
public class CategoryController {
	
	private CategoryService categoryService;
	
	@Autowired
	public CategoryController(CategoryService categoryService) {
		this.categoryService = categoryService;
	}

	//카테고리 등록 이동
	@RequestMapping(value="/add/category", method=RequestMethod.GET)
	public String moveCateReg() {
		return "/front/shopping/category/register";
	}
	
	//카테고리 등록
	@ResponseBody
	@RequestMapping(value="/add/category", method=RequestMethod.POST)
	public HashMap<String, Object> insertCategory(@ModelAttribute CategoryDto categoryDto) {
		
		HashMap<String,Object> resultMap = new HashMap<>();
		
		categoryService.insertCategory(categoryDto);
		resultMap.put("id", categoryDto.getId());
		
		return resultMap;
	}
	
	//상위 카테고리 조회
	@ResponseBody
	@RequestMapping(value="/category/depth/{depth}", method=RequestMethod.GET)
	public List<CategoryDto> selectParent(@PathVariable("depth") int depth) {
		
		List<CategoryDto> list = categoryService.selectParent(depth);
		return list;
	}
	
	//카테고리 목록 조회
	@ResponseBody
	@RequestMapping(value="/category/list", method=RequestMethod.GET)
	public List<CategoryDto> selectCateList() {
		
		List<CategoryDto> list = categoryService.selectCateList();
		return list;
	}
	
	//카테고리 이동
	@RequestMapping(value="/category", method=RequestMethod.GET)
	public String moveCate() {
		return "/front/shopping/category/list";
	}
}
