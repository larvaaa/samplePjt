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
	selectCateList();
});


//게시판 목록 조회
function selectCateList() {
	
	$.ajax({
		url: "${pageContext.request.contextPath}/shopping/category/list",
		type: "get",
		dataType: "json",
		success: function(data){
				
				$(".cate_list").remove();
				
				var html = "";
				
				for(var i=0; i<data.length; i++) {
					
					html += 
					"<tr class='cate_list'>"+
					"<td><a href=javascript:goCateDetail("+data[i].id+")>"+data[i].name.replaceAll(' ','&nbsp&nbsp&nbsp&nbsp&nbsp')+"</a></td>"+
					"</tr>";
				}
				
				$(".table").append(html);
		},
		error: function(request, status, error) {
			if(request.status == 401) location.href = "${pageContext.request.contextPath}/login/goLogin";
		},
	});

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
  <button id="btn_write" type="button" class="btn btn-primary" onclick="location.href='/shopping/add/category'">카테고리 등록</button>
  <button type="button" class="btn btn-default" onclick="location.href='${pageContext.request.contextPath}/goMain'">메인</button>
</body>
</html>