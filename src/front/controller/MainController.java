package front.controller;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import front.service.MainService;

@Controller
public class MainController {

	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@Autowired
	private MainService mainService;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response) {
		
		logger.info("url: /");
		
		ModelAndView mav = new ModelAndView();
		List<Map<String,Object>> data = mainService.getData();
		
		mav.addObject("data",data);
		mav.setViewName("index");
		
		return mav;
		
	}

	@RequestMapping(value="goMain") 
	public ModelAndView goMain(HttpServletRequest request, HttpServletResponse response){
		
		ModelAndView mv = new ModelAndView();
		
		HttpSession session = request.getSession();
		Map<String,String> userInfo = (Map)session.getAttribute("userInfo");
		
		String custId = userInfo.get("custId");
		String name = userInfo.get("name");
		
		mv.addObject("cust_id",custId);
		mv.addObject("name",name);
		
		mv.setViewName("front/main");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="test", method=RequestMethod.POST) 
	public Map<String,Object> test(HttpServletRequest request, HttpServletResponse response, @RequestBody HashMap<String,Object> parameterMap){
		
		for(Map.Entry<String, Object> entry : parameterMap.entrySet()) {
			logger.info(entry.getKey() + ":" + entry.getValue());
		}
		
		Map<String,Object> resultMap = new HashMap<String,Object>();
		return resultMap;
	}
	
}
