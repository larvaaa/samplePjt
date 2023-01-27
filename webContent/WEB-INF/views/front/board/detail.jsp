<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>

<%@ include file="/WEB-INF/views/header.jsp" %>
<head>

<style>
 .write_comment {margin-bottom:50px;}
</style>

</head>
<body>
<%-- <%
String custId = "";
Cookie[] cookies = request.getCookies();
for(Cookie cookie : cookies) {
	if(cookie.getName().equals("custId")) {
		custId = cookie.getValue();
	}
}

%> --%>


<script>

var bseq = "${board_detail.bseq}";

$(document).ready(function() {
	
	//댓글 리스트 조회
	selectCommentList();
	
	//작성버튼클릭
	$("#upd_btn").click(function() {
		update();
	});
	
	$("#tit").val("${board_detail.title}");
	/* $("#cont").val("${board_detail.content}"); */
});

//글작성
function update() {
	
	var title = $("#tit").val();
	var content = $("#cont").val();
	
	var param = {
		"bseq" : bseq,
		"title" : title,
		"content" : content
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/board/update",
		type: "post",
		contentType: "application/json",
		dataType: "json",
		data: JSON.stringify(param),
		success: function(data){
			if(data.result_cd == "S") {
				alert("수정 완료했습니다.");
				let page = localStorage.getItem("page");
				location.href = "${pageContext.request.contextPath}/board/goBoard?side_idx=1&page="+ page;
			} else {
				alert("오류가 발생했습니다.");
			}
		}
	});

}

//취소버튼
function clickCancelBtn() {
	history.back();
}

//댓글작성
function insertComment() {
    
    let param = {
	    "content" : $("#write_comment > textarea").val(),
	    "bseq" : bseq,
	    "cdepth" : "0"
    }
    
    $.ajax({
        url: "${pageContext.request.contextPath}/board/insertComment",
        type: "post",
        //processData:false,
        //contentType:false,
        contentType: "application/json",
        dataType: "json",
        data: JSON.stringify(param),
        success: function(data){
            if(data.result_cd == "S") {
                alert("댓글 작성 완료했습니다.");
            	selectCommentList();
            } else {
                alert("오류가 발생했습니다.");
            }
        }
    });

}

//댓글 리스트 조회
function selectCommentList() {

	$.ajax({
	    url: "${pageContext.request.contextPath}/board/selectCommentList",
	    type: "post",
	    dataType: "html",
	    data: {"bseq" : bseq},
	    success: function(data){
	    	$(".div_comment").html(data);
	    	
	        /* if(data.result_cd == "S") {
	            alert("수정 완료했습니다.");
	        } else {
	            alert("오류가 발생했습니다.");
	        } */
	    }
	});
}

</script>
<!-- Page content-->
  <form>
    <div class="form-group">
      <label for="exampleInputPassword1">제목</label>
      <input type="text" class="form-control" id="tit" placeholder="제목을 입력하세요.">
    </div>
    <div class="form-group">
      <label for="cont">내용</label>
      <textarea id="cont" class="form-control" rows="10" placeholder="내용을 입력하세요.">${board_detail.content}</textarea>
    </div>
    <button id="upd_btn" type="button" class="btn btn-primary">수정</button>
    <button onclick="clickCancelBtn()" type="button" class="btn btn-danger">취소</button>
  </form>
  
  <label for="write_comment">댓글작성</label>
  <div class="write_comment" id="write_comment">
    <textarea class="form-control" rows="3"></textarea>
    <button onclick="insertComment()">등록</button>
  </div>
  
  <div class="div_comment">
    
  </div>
  
  
</body>
</html>