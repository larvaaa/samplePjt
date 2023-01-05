<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>

<%@ include file="/WEB-INF/views/header.jsp" %>
<head>

</head>
<body>

<script>

var page = "${page}" == "" ? 1 : "${page}";

$(document).ready(function() {
	
	//페이지 버튼 클릭
	$(".paging_btn").click(function() {
		
		var page_num = $(this).text();
		page = page_num;
		selectBoardList(page_num);
		$(".paging_btn").removeClass("active");
		$(this).addClass("active");
	});
	
	//글쓰기 버튼
	$("#btn_write").click(function() {
		goWrite();
	});
	
	//게시판 목록 조회
	selectBoardList(page);
	
});

//글쓰기페이지 이동
function goWrite() {
    location.href = "${pageContext.request.contextPath}/board/goWrite";
}

//게시판상세 이동
function goBoardDetail(bseq) {
	localStorage.setItem("page", page);
    location.href = "${pageContext.request.contextPath}/board/goBoardDetail?bseq="+bseq;
}

//게시판 목록 조회
function selectBoardList(pageNum) {
	
	var param = {
		"pageNum" : pageNum 
	};
	
	$.ajax({
		url: "${pageContext.request.contextPath}/board/selectBoardList",
		type: "get",
// 		contentType: "application/json",
		dataType: "json",
// 		data: JSON.stringify(param),
		data: param,
		/* beforeSend : function(xmlHttpRequest){
            xmlHttpRequest.setRequestHeader("AJAX", true); // ajax 호출을  header에 기록
        }, */
		success: function(data){
			if(data.result_cd == "S") {
				
				$(".board_list").remove();
				
				var board_html = "";
				var paging_html = "";
				var board_list = data.board_list;
				
				for(var i=0; i<board_list.length; i++) {
					
					board_html += 
					"<tr class='board_list'>"+
					"<td>"+board_list[i].rnum+"</td>"+
					"<td>"+board_list[i].title+"</td>"+
					"<td><a href=javascript:goBoardDetail("+board_list[i].bseq+")>"+board_list[i].content+"</a></td>"+
					"<td>"+board_list[i].reg_id+"</td>"+
					"<td>"+board_list[i].mod_date+"</td>"+
					"</tr>";
				}
				
				//페이징 버튼 세팅
				setPagingBtn(pageNum, data.end_page);
				
				$(".table").append(board_html);
				history.pushState(null, null, '/board/goBoard?page=' + pageNum);
			} else {
				
			}
		},
		error: function(request, status, error ) {
			if(request.status == 401) location.href = "${pageContext.request.contextPath}/login/goLogin";
		},
	});

}

//페이징 버튼 세팅
function setPagingBtn(pageNum, endPage) {
	
	//전체 페이지 버튼 개수
	let totalPageBtn = 10;
	
	let start = totalPageBtn * Math.floor((pageNum - 1) / totalPageBtn) + 1;
	let end = start + totalPageBtn;
	
	for(let i = start; i < end; i++) {
		if(i <= endPage) {
		    $(".paging_btn").eq(i - 1).show();
		    $(".paging_btn > a").eq(i - 1).show().text(i);
		}
	}
	
	$(".paging_btn").eq(pageNum - 1).addClass("active");
}


</script>
	 <table class="table" style="margin-left: auto; margin-right: auto;">
	   <tr class="active">
	     <th>번호</th>
	     <th>제목</th>
	     <th>내용</th>
	     <th>작성자</th>
	     <th>작성일</th>
	   </tr>
	 </table>
	 <nav style="text-align:center;">
	   <ul class="pagination">
	     <li>
	       <a href="#" aria-label="Previous">
	         <span aria-hidden="true">&laquo;</span>
	       </a>
	     </li>
	     <li style="display:none" class="paging_btn"><a href='javascript:void(0);'>1</a></li>
	     <li style="display:none" class="paging_btn"><a href='javascript:void(0);'>2</a></li>
	     <li style="display:none" class="paging_btn"><a href='javascript:void(0);'>3</a></li>
	     <li style="display:none" class="paging_btn"><a href='javascript:void(0);'>4</a></li>
	     <li style="display:none" class="paging_btn"><a href='javascript:void(0);'>5</a></li>
	     <li style="display:none" class="paging_btn"><a href='javascript:void(0);'>6</a></li>
	     <li style="display:none" class="paging_btn"><a href='javascript:void(0);'>7</a></li>
	     <li style="display:none" class="paging_btn"><a href='javascript:void(0);'>8</a></li>
	     <li style="display:none" class="paging_btn"><a href='javascript:void(0);'>9</a></li>
	     <li style="display:none" class="paging_btn"><a href='javascript:void(0);'>10</a></li>
	     <li>
	       <a href="#" aria-label="Next">
	         <span aria-hidden="true">&raquo;</span>
	       </a>
	     </li>
	   </ul>
	 </nav>
  <button id="btn_write" type="button" class="btn btn-primary">글쓰기</button>
  <button type="button" class="btn btn-default" onclick="location.href='${pageContext.request.contextPath}/goMain'">메인</button>
</body>
</html>