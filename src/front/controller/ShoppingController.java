package front.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import common.Const;
import common.util.ConvertUtil;
import front.service.ShoppingService;

@Controller
@RequestMapping(value="/shopping")
public class ShoppingController {

	private static final Logger logger = LoggerFactory.getLogger(ShoppingController.class);
	
	@Autowired
	private ShoppingService shoppingService; 
	
	//브랜드 페이지 이동
	@RequestMapping(value="/goBrand", method=RequestMethod.GET)
	public String goBoard(HttpServletRequest request, Model model) {
		
		int page;
		
		try {
			
			page = Integer.parseInt(request.getParameter("page"));
			if(page == 0) page = 1;
			
		} catch(NumberFormatException e) {
			page = 1;
		}
		
		model.addAttribute("page", page);
		return "/front/shopping/brand";
		
	}
	
	//브랜드 목록 조회
	@RequestMapping(value="/selectBrandList" , method=RequestMethod.GET)
	public ModelAndView selectBrandList(
			HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam("pageNum") String pageNum
			/*@RequestBody HashMap<String,String> parameterMap*/) {
		
		Map<String,Object> resultMap = new HashMap<String,Object>();
		HashMap<String,String> parameterMap = new HashMap<>();
		List<Map<String,Object>> boardList = new ArrayList<Map<String,Object>>();
		String result_cd = Const.SUCCESS_CD;
		int endPage = 1;
		
		try {
			
			parameterMap.put("pageNum", pageNum);
			boardList = shoppingService.selectBrandList(parameterMap);
			
			if(!boardList.isEmpty()) {
				int totalNum = Integer.parseInt(boardList.get(0).get("totalNum").toString());
				endPage = totalNum / 10 + 1;
				if(totalNum % 10 == 0) endPage--;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			result_cd = Const.FAIL_CD;
		}
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("pageNum", pageNum);
		mv.addObject("brand_list", boardList);
		mv.addObject("endPage", endPage);
		mv.setViewName("/front/shopping/include/brandList");
//		resultMap.put("brand_list", boardList);
//		resultMap.put("result_cd", result_cd);
		
		return mv; 
	}

	//브랜드 등록 페이지 이동
	@RequestMapping(value="/addBrand", method=RequestMethod.GET)
	public String addBrand() {
		
		return "/front/shopping/addBrand";
		
	}
	
	//브랜드 등록
	@ResponseBody
	@RequestMapping(value="/addBrand", method=RequestMethod.POST)
	public Map<String,String> addBrand(@RequestParam(value="uploadFile") MultipartFile[] uploadFile, HttpServletRequest request) throws Exception {
		
		HashMap<String,String> parameterMap = new HashMap<>();
		HashMap<String,String> resultMap = new HashMap<>();
		
		HttpSession session = request.getSession();
		Map<String,String> userInfo = ConvertUtil.ObjectToMap(session.getAttribute("userInfo"));

		String brandName = request.getParameter("brandName");
		
		parameterMap.put("cust_id", userInfo.get("custId"));
		parameterMap.put("brand_name", brandName);
		
		try {
			shoppingService.insertBrand(parameterMap, uploadFile);
			
			resultMap.put("result_cd", "S");
		} catch(Exception e) {
			e.printStackTrace();
			resultMap.put("result_cd", "F");
		}
	    
	    return resultMap;
	}
	
	//브랜드 수정 페이지 이동
	@RequestMapping(value="/moveBrandUpd", method=RequestMethod.GET)
	public String moveBrandUpd(@RequestParam("brand_id") String brandId, Model model) {
		
		HashMap<String,String> findResult = shoppingService.findBrand(brandId);
		model.addAttribute("brandInfo", findResult);
		
		return "/front/shopping/updBrand";
		
	}
}
