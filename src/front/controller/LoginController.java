package front.controller;

import java.util.HashMap;

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

import front.service.LoginService;

@Controller
@RequestMapping(value="/login")
public class LoginController {

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	public static final String SUCCESS_CD = "S";
	public static final String SUCCESS_MSG = "성공";
	
	public static final String FAIL_CD = "F";
	public static final String FAIL_MSG = "실패";
	
	public static final String EMPTY_RESULT_CD = "N";
	public static final String EMPTY_RESULT_MSG = "결과 없음";
	
	@Autowired
	public LoginService loginService;
	
	//로그인 화면 이동
	@RequestMapping(value="/goLogin")
	public ModelAndView goLogin(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/front/login");
		
		return mv;
	}
	
	//로그인
	@ResponseBody
	@RequestMapping(value="/doLogin" , method=RequestMethod.POST)
	public HashMap<String,Object> doLogin(HttpServletRequest request, HttpServletResponse response, @RequestBody HashMap<String,String> parameterMap) {
		
		HashMap<String,Object> resultMap = loginService.doLogin(parameterMap,request,response);
		
		return resultMap; 
	}
	
	//로그아웃
	@RequestMapping(value="/doLogout" , method=RequestMethod.POST)
	public ModelAndView doLogout(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mv = new ModelAndView();
		
		HttpSession session = request.getSession();
		session.invalidate();
		
		mv.setViewName("/front/login");
		
		return mv;
	}
	
	//로그인 화면 이동
	@RequestMapping(value="/signUp")
	public ModelAndView signup(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/front/signUp");
		
		return mv;
	}
	
}
