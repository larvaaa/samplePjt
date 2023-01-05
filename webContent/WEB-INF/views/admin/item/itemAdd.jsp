<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>

<%@ include file="/WEB-INF/views/header.jsp" %>

<head>
<%-- <link href='${pageContext.request.contextPath}/resources/css/styles.css' rel='stylesheet' /> --%>

<title>네비게이션</title>

</head>

<body>
<script>
$(document).ready(function() {
	
	$("#test").click(function() {
		test();
	});
	
	$("#btn_logout").click(function() {
		
	});
	
});

//테스트
function test() {
	
	var arr = [1,2,3,4,5];
	var obj = {
		"하나":1,
		"둘" : 2,
		"셋" : 3
	}
	
	var param = {
		"aa" : "aa"
		, "bb" : "bb"
		, "arr" : arr
		, "obj" : obj
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/test",
		type: "post",
		contentType: "application/json",
		dataType: "json",
		data: JSON.stringify(param),
		success: function(data){
			if(data.result_cd == "S") {
				
			} else {
				
			}
		}
	});

}

</script>
<%@ include file="/WEB-INF/views/admin/include/nav_head.jsp" %>
<form>
  <div class="mb-3">
    <label for="name" class="form-label">상품명</label>
    <input type="text" class="form-control" id="name" aria-describedby="emailHelp">
<!--     <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div> -->
  </div>
  <select class="form-select" aria-label="Default select example">
	  <option selected>브랜드</option>
	  <option value="1">One</option>
	  <option value="2">Two</option>
	  <option value="3">Three</option>
  </select>
  <select class="form-select" aria-label="Default select example">
	  <option selected>카테고리</option>
	  <option value="1">One</option>
	  <option value="2">Two</option>
	  <option value="3">Three</option>
  </select>
  <div class="mb-3">
    <label for="price" class="form-label">가격</label>
    <input type="text" class="form-control" id="price">
  </div>
  <div class="mb-3">
    <label for="quantity" class="form-label">수량</label>
    <input type="text" class="form-control" id="quantity">
  </div>
  <button type="submit" class="btn btn-primary">Submit</button>
</form>


<%@ include file="/WEB-INF/views/admin/include/nav_foot.jsp" %>
</body>
</html>