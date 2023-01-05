<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>

<%@ include file="/WEB-INF/views/header.jsp" %>
<head>
<style>
  .menu {background-color:#FD93F9;width:20%;height:50vh}
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
$(document).ready(function() {
	
	//작성버튼클릭
	$("#reg_btn").click(function() {
		write();
	});
	
});

//글작성
function write() {
	
	var title = $("#tit").val();
	var content = $("#cont").val();
	
	var param = {
		"title" : title,
		"content" : content
			
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/board/write",
		type: "post",
		contentType: "application/json",
		dataType: "json",
		data: JSON.stringify(param),
		success: function(data){
			if(data.result_cd == "S") {
				alert("작성 완료했습니다.");
				location.href = "${pageContext.request.contextPath}/board/goBoard";
			} else {
				alert("오류가 발생했습니다.");
			}
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
      <textarea id="cont" class="form-control" rows="10" placeholder="내용을 입력하세요."></textarea>
    </div>
    <button id="reg_btn" type="button" class="btn btn-primary">등록</button>
  </form>
  

</body>
</html>