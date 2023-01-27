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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import common.Const;
import common.util.ConvertUtil;
import front.dto.CommentDto;
import front.service.BoardService;

@Controller
@RequestMapping(value="/board")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	private BoardService boardService; 
	
	//게시판 페이지 이동
	@RequestMapping(value="/goBoard", method=RequestMethod.GET)
	public String goBoard(HttpServletRequest request, Model model) {
		
		int page;
		
		try {
			
			page = Integer.parseInt(request.getParameter("page"));
			if(page == 0) page = 1;
			
		} catch(NumberFormatException e) {
			page = 1;
		}
		
		model.addAttribute("page", page);
		return "/front/board/list";
		
	}
	
	//글 목록 조회
	@ResponseBody
	@RequestMapping(value="/selectBoardList" , method=RequestMethod.GET)
	public Map<String,Object> selectBoardList(
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
			boardList = boardService.selectBoardList(parameterMap);
			
			if(!boardList.isEmpty()) {
				int totalNum = Integer.parseInt(boardList.get(0).get("totalNum").toString());
				endPage = totalNum / 10 + 1;
				if(totalNum % 10 == 0) endPage--;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			result_cd = Const.FAIL_CD;
		}
		
		resultMap.put("end_page",endPage);
		resultMap.put("board_list", boardList);
		resultMap.put("result_cd", result_cd);
		
		return resultMap; 
	}

	//글쓰기 페이지 이동
	@RequestMapping(value="goWrite", method=RequestMethod.GET) 
	public ModelAndView goWrite(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/front/board/write");
		
		return mav;
	}
	
	//게시판 상세 조회
	@RequestMapping(value="goBoardDetail", method=RequestMethod.GET) 
	public ModelAndView goBoardDetail(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		HashMap<String,String> paramMap = new HashMap<String,String>();
		
		String bseq = request.getParameter("bseq"); //게시판 번호
		
		paramMap.put("bseq", bseq);
		Map<String,String> boardDetailMap = boardService.getBoardDetail(paramMap);
		
		
		mav.addObject("board_detail", boardDetailMap);
		mav.setViewName("/front/board/detail");
		
		return mav;
	}
	
	//글 작성
	@ResponseBody
	@RequestMapping(value="/write" , method=RequestMethod.POST)
	public Map<String,String> write(HttpServletRequest request, HttpServletResponse response, @RequestBody HashMap<String,String> parameterMap) {
		
		Map<String,String> resultMap = new HashMap<String,String>();
		HttpSession session = request.getSession();
		Map<String,String> userInfo = ConvertUtil.ObjectToMap(session.getAttribute("userInfo"));
		parameterMap.put("cust_id", userInfo.get("custId"));
		String result_cd = "";
		
		try {
			
			int writeResult = boardService.write(parameterMap);
			if(writeResult > 0) {
				result_cd = Const.SUCCESS_CD;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			result_cd = Const.FAIL_CD;
		}
		
		resultMap.put("result_cd", result_cd);
		
		return resultMap; 
	}
	
	//글 수정
	@ResponseBody
	@RequestMapping(value="/update" , method=RequestMethod.POST)
	public Map<String,String> update(
		HttpServletRequest request,
		HttpServletResponse response,
		@RequestBody Map<String,String> parameterMap) {
		
		Map<String,String> resultMap = new HashMap<String,String>();
		HttpSession session = request.getSession();
		String result_cd = "";
		
		try {
			
			Map<String,String> userInfo = ConvertUtil.ObjectToMap(session.getAttribute("userInfo"));
			parameterMap.put("cust_id", userInfo.get("custId"));
			
			int writeResult = boardService.update(parameterMap);
			if(writeResult > 0) {
				result_cd = Const.SUCCESS_CD;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			result_cd = Const.FAIL_CD;
		}
		
		resultMap.put("result_cd", result_cd);
		
		return resultMap; 
	}
	
	//댓글작성
	@ResponseBody
	@RequestMapping(value="/insertComment" , method=RequestMethod.POST)
	public Map<String,String> insertComment(@RequestBody CommentDto commentDto, HttpSession session) {
		
		Map<String,String> resultMap = new HashMap<String,String>();
		String result_cd = "";
		
		try {
			
			Map<String,String> userInfo = ConvertUtil.ObjectToMap(session.getAttribute("userInfo"));
			commentDto.setWriter(userInfo.get("custId"));
			
			int Result = boardService.insertComment(commentDto);
			
			if(Result > 0) {
				result_cd = Const.SUCCESS_CD;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			result_cd = Const.FAIL_CD;
		}
		
		resultMap.put("result_cd", result_cd);
		
		return resultMap; 
	}
	
	//댓글 리스트 조회
	@RequestMapping("/selectCommentList")
	public String selectCommentList(@ModelAttribute CommentDto commentDto, Model model) {
		
		List<Map<String,Object>> commentList = boardService.selectCommentList(commentDto);
		model.addAttribute("commentList",commentList);
		
		return "/front/board/include/comment";
	}
	
	
}
