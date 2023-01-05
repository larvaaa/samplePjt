package admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/admin")
public class ItemContoller {

	private static final Logger logger = LoggerFactory.getLogger(ItemContoller.class);
	
	//관리자 로그인
	@RequestMapping(value="/adminLogin")
	public ModelAndView adminLogin() {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/admin/main");
		
		return mv;
	}
	
	//상품등록 페이지 이동
	@RequestMapping(value="/itemAdd")
	public ModelAndView itemAdd() {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/admin/item/itemAdd");
		
		return mv;
	}
	
	//상품등록
	/*@ResponseBody
	@RequestMapping(value="/insertItem" , method=RequestMethod.GET)
	public Map<String,Object> insertItem (
			HttpServletRequest request,
			HttpServletResponse response,
			@RequestBody HashMap<String,String> parameterMap) {
		
		
		
		
		
		return resultMap; 
	}*/

}
