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
	
	//글쓰기 버튼
	$("#btn_write").click(function() {
		goWrite();
	});
	
	//브랜드 목록 조회
	selectBrandList(page);
	
});

//브랜드 목록 조회
function selectBrandList(pageNum) {
	
	var param = {
		"pageNum" : pageNum 
	};
	
	$.ajax({
		url: "${pageContext.request.contextPath}/shopping/selectBrandList",
		type: "get",
// 		contentType: "application/json",
		dataType: "html",
// 		data: JSON.stringify(param),
		data: param,
		/* beforeSend : function(xmlHttpRequest){
            xmlHttpRequest.setRequestHeader("AJAX", true); // ajax 호출을  header에 기록
        }, */
		success: function(data){
				
				$("#include").html(data);
				history.pushState(null, null, '/shopping/goBrand?page=' + pageNum);
		},
		error: function(request, status, error ) {
			if(request.status == 401) location.href = "${pageContext.request.contextPath}/login/goLogin";
		},
	});

}

</script>
    <div id="include">
    </div>
    
  <button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/shopping/addBrand'">브랜드 추가</button>
  <button type="button" class="btn btn-default" onclick="location.href='${pageContext.request.contextPath}/goMain'">메인</button>

</body>
</html>