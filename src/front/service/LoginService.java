package front.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import front.dao.LoginDao;

@Service
public class LoginService {

	public static final String SUCCESS_CD = "S";
	public static final String SUCCESS_MSG = "성공";
	
	public static final String FAIL_CD = "F";
	public static final String FAIL_MSG = "실패";
	
	public static final String EMPTY_RESULT_CD = "N";
	public static final String EMPTY_RESULT_MSG = "결과 없음";
	
	@Autowired
	private LoginDao loginDao;
	
	//로그인 처리
	public HashMap<String,Object> doLogin(HashMap<String,String> parameterMap, HttpServletRequest requset, HttpServletResponse response) {
		
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		
		try {
			Map<String,String> loginMap = loginDao.doLogin(parameterMap);  //회원정보 조회
			
			if(loginMap != null && !loginMap.isEmpty()) { // 조회 결과
				
				//세션 생성 및 저장
				HttpSession session = requset.getSession();
				session.setAttribute("userInfo", loginMap);

				resultMap.put("result_cd",SUCCESS_CD);
				resultMap.put("result_msg",SUCCESS_MSG);
				
			} else { //조회 결과 없음
				resultMap.put("result_cd",EMPTY_RESULT_CD);
				resultMap.put("result_msg",EMPTY_RESULT_MSG);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			resultMap.put("result_cd",FAIL_CD);
			resultMap.put("result_cd",FAIL_MSG);
		}
		
		return resultMap;
	}
	
}
