<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>

<%@ include file="/WEB-INF/views/header.jsp" %>

<head>

<style>

.btn {margin:10px;}
</style>
<title>네비게이션</title>

</head>

<body>
<script>
$(document).ready(function() {
	
	
});

//로그아웃
function doLogout() {
    let f = document.createElement('form');
    f.setAttribute('method', 'post');
    f.setAttribute('action', '/login/doLogout');
    document.body.appendChild(f);
    f.submit();
}

//게시판 이동
function goBoard() {
	location.href = "${pageContext.request.contextPath}/board/goBoard?page=1"
}


</script>

<div><button type="button"  class="btn btn-primary" onClick="location.href='${pageContext.request.contextPath}/board/goBoard?page=1'">게시판</button></div>
<div><button type="button" class="btn btn-secondary" onClick="location.href='${pageContext.request.contextPath}/shopping/goBrand'">브랜드</button></div>
<div><button type="button" class="btn btn-success" onClick="location.href='/shopping/add/item'">상품관리</button></div>
<div><button type="button" class="btn btn-danger" onClick="location.href='/shopping/category'">카테고리관리</button></div>
<div><button type="button" class="btn btn-warning">Warning</button></div>
<div><button type="button" class="btn btn-info">Info</button></div>
<div><button type="button" class="btn btn-light">Light</button></div>
<div><button type="button" onclick="doLogout()" class="btn btn-dark">로그아웃</button></div>

</body>
</html>