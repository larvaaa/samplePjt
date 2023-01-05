package common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class CommonInterceptor implements HandlerInterceptor{

	private static final Logger logger = LoggerFactory.getLogger(CommonInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object object) throws Exception {
		
		logger.info("preHandle");
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("userInfo") != null) {
			return true;
		} else {
			
			//ajax요청은 리다이렉트 불가
			if("XMLHttpRequest".equals(request.getHeader("x-requested-with"))) {
				response.sendError(401);
			} else {
				response.sendRedirect("/login/goLogin");
			}
			return false;
		}
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object object, ModelAndView mv) throws Exception {
//		logger.info("postHandle");
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object object, Exception e) throws Exception {
		
		
	}
	
}
